#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <iomanip>
#include <iostream>
#include <limits>
#include <random>
#include <stdexcept>
#include <string>
#include <vector>
#include <cstdlib>
#include <memory>
#include <new>
#include <unistd.h>

// Single, non-templated kernel: the access interval along the sequence
// dimension (stride, in floats) is a runtime argument.
// For each fixed S and D, compare different strides using the same kernel.
// Inspect generated assembly to verify that no stride-specific paths exist.
//   stride == D      <-> fixed single head in HSD layout
//   stride == H*D     <-> fixed single head in SHD layout
//   other values      <-> arbitrary interval spacing
__attribute__((noinline)) void dot(const float* q, const float* k, float* out,
  size_t S, size_t D, size_t stride) {
  for (size_t s = 0; s < S; ++s) {
    float sum = 0.0f;
    for (size_t d = 0; d < D; ++d) {
      sum += q[d] * k[s * stride + d];
    }
    out[s] = sum;
  }
}

// Compiler barrier: make all output stores observable on each call.
inline void observe(const float* p) {
  asm volatile("" : : "r"(p) : "memory");
}

int main(int argc, char** argv) {
  try {
    if (argc < 7) throw std::runtime_error(
      "Usage: access_interval_benchmark S D trials target_ms seed stride [stride ...]");
    auto number = [](const char* s) -> size_t {
      std::string value(s); size_t pos = 0;
      if (value.empty() || value[0] == '-') throw std::runtime_error("Invalid integer");
      auto n = std::stoull(value, &pos);
      if (pos != value.size() || n > std::numeric_limits<size_t>::max())
        throw std::runtime_error("Invalid Integer");
      return static_cast<size_t>(n);
    };
    const size_t S = number(argv[1]), D = number(argv[2]);
    const size_t trials = number(argv[3]);
    const size_t target_ms = number(argv[4]), seed = number(argv[5]);
    if (!S || !D || !trials || !target_ms)
      throw std::runtime_error("S, D, trials and target_ms must be positive");
    if (S > SIZE_MAX/D) throw std::runtime_error("Shape overflow");

    std::vector<size_t> strides;
    for (int i = 6; i < argc; ++i) {
      const size_t stride = number(argv[i]);
      if (stride < D) throw std::runtime_error("stride must be >= D");
      if (stride > SIZE_MAX / sizeof(float)) throw std::runtime_error("stride byte size overflow");
      const size_t span = S - 1;
      if (span != 0 && stride > (SIZE_MAX - D) / span)
        throw std::runtime_error("Shape overflow");
      const size_t count = span * stride + D;
      if (count > SIZE_MAX/sizeof(float)) throw std::runtime_error("Shape overflow");
      strides.push_back(stride);
    }
    const size_t L = strides.size();

    std::mt19937 rng(static_cast<uint32_t>(seed));
    auto random_float = [&]() {return static_cast<float>(rng() >> 8) / 8388608.0f - 1.0f; };

    // Canonical [S, D] data, independent of stride/padding: every condition
    // reads the exact same S*D values, only their spacing in memory differs.
    std::vector<float> q(D);
    for (auto& x: q) x = random_float();
    std::vector<float> canonical(S*D);
    for (auto& x: canonical) x = random_float();

    std::vector<double> reference(S);
    for (size_t s = 0; s < S; ++s) {
      for (size_t d = 0; d < D; ++d) {
        reference[s] += double(q[d]) * double(canonical[s*D + d]);
      }
    }

    // One buffer per stride: same S*D values, laid out with that stride's
    // padding between consecutive sequence positions. dot() never reads the
    // padding, so its content is irrelevant and left default-initialized.
    // Align every buffer to the OS page boundary.
    // This controls the virtual page offset, not physical memory placement.
    const long page_size = sysconf(_SC_PAGESIZE);
    if (page_size <= 0) throw std::runtime_error("Failed to obtain page size");
    const size_t alignment = static_cast<size_t>(page_size);

    struct FreeDeleter {
      void operator()(float* p) const noexcept {
        std::free(p);
      }
    };

    using AlignedBuffer = std::unique_ptr<float, FreeDeleter>;
    std::vector<AlignedBuffer> buffers;
    buffers.reserve(L);

    for (size_t i = 0; i < L; ++i) {
      const size_t stride = strides[i];
      const size_t count = (S - 1) * stride + D;
      const size_t bytes = count * sizeof(float);

      void* raw = nullptr;
      const int rc = posix_memalign(&raw, alignment, bytes);
      if (rc != 0) throw std::runtime_error("posix_memalign failed: error=" + std::to_string(rc));
      AlignedBuffer buffer(static_cast<float*>(raw));

      // Initialize the entire allocation outside the timed region.
      std::fill_n(buffer.get(), count, 0.0f);

      for (size_t s = 0; s < S; ++s) {
        for (size_t d = 0; d < D; ++d) {
          buffer.get()[s * stride + d] = canonical[s * D + d];
        }
      }
      buffers.push_back(std::move(buffer));
    }

    std::vector<float> out(S);
    std::vector<double> errors(L, 0.0);
    constexpr double atol = 1e-4, rtol = 1e-4;
    for (size_t i = 0; i < L; ++i) {
      dot(q.data(), buffers[i].get(), out.data(), S, D, strides[i]);
      for (size_t s = 0; s < S; ++s) {
        double e = std::abs(double(out[s]) - reference[s]);
        errors[i] = std::max(errors[i], e);
        if (!std::isfinite(out[s]) || e > atol + rtol*std::abs(reference[s])) {
          throw std::runtime_error("validation failed: stride=" + std::to_string(strides[i]));
        }
      }
    }

    auto measure = [&](size_t i, size_t iterations) {
      const auto start = std::chrono::steady_clock::now();
      for (size_t it = 0; it < iterations; ++it) {
        dot(q.data(), buffers[i].get(), out.data(), S, D, strides[i]);
        observe(out.data());
      }
      return std::chrono::duration<double,std::nano>
        (std::chrono::steady_clock::now()-start).count();
    };

    std::vector<size_t> iterations(L, 1);
    for (size_t i = 0; i < L; ++i) {
      while (measure(i, iterations[i]) < double(target_ms)*1e6) {
        if (iterations[i] > SIZE_MAX/2) throw std::runtime_error("Iteration overflow");
        iterations[i] *= 2;
      }
    }

    std::cout << "stride,S,D,trial,iterations,ns_per_call,max_abs_error,seed,cache_mode,"
     "stride_bytes,useful_k_bytes,address_span_bytes,"
     "allocated_bytes,alignment_bytes\n" << std::setprecision(12);
    std::vector<size_t> order(L);
    for (size_t i = 0; i < L; ++i) order[i] = i;
    for (size_t trial = 0; trial < trials; ++trial) {
      std::shuffle(order.begin(), order.end(), rng);
      for (size_t i : order) {
        measure(i, iterations[i]); // Warm this condition immediately before measurement.
        const double ns = measure(i, iterations[i]) / iterations[i];
        const size_t stride = strides[i];
        const size_t stride_bytes = stride * sizeof(float);
        const size_t useful_k_bytes = S * D * sizeof(float);
        const size_t address_span_bytes =
          ((S - 1) * stride + D) * sizeof(float);
        
        std::cout
          << stride << ',' << S << ',' << D << ',' << trial << ','
          << iterations[i] << ',' << ns << ',' << errors[i] << ','
          << seed << ",repeated_buffer,"
          << stride_bytes << ','
          << useful_k_bytes << ','
          << address_span_bytes << ','
          << address_span_bytes << ','  // Requested allocation size
          << alignment << '\n';
      }
    }
  } catch(const std::exception& e) { std::cerr << e.what() << '\n'; return 1; }
}
