// macOS/Linux, Clang/GCC, C++17. FP32, one thread, h -> s -> d.
// Build without fast-math so reference/validation retain normal FP semantics.
// Usage: all_heads_benchmark S H D trails target_ms seed [padding_elements=32]

#include <algorithm>
#include <array>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <limits>
#include <memory>
#include <random>
#include <stdexcept>
#include <string>
#include <vector>
#include <unistd.h>

static_assert(sizeof(float) == 4, "Requires FP32 float");
size_t add(size_t a, size_t b) {
  if (b > SIZE_MAX - a) throw std::runtime_error("Size overflow");
  return a + b;
}
size_t mul(size_t a, size_t b) {
  if (a && b > SIZE_MAX/a) throw std::runtime_error("Size overflow");
  return a * b;
}

size_t number(const char* arg) {
  const std::string s(arg);
  if (s.empty() || s.find_first_not_of("0123456789") != std::string::npos)
    throw std::runtime_error("Expected unsigned integer: " + s);
  size_t end = 0;
  auto value = std::stoull(s, &end);
  if (end != s.size() || value > SIZE_MAX) throw std::runtime_error("Integer overflow");
  return static_cast<size_t>(value);
}

struct Free {
  void operator()(float* p) const {std::free(p);}
};

using Buffer = std::unique_ptr<float, Free>;

Buffer allocate(size_t count, size_t alignment) {
  void* p = nullptr;
  const int error = posix_memalign(&p, alignment, mul(count, sizeof(float)));
  if (error) throw std::runtime_error("posix_memalign failed: " + std::to_string(error));
  Buffer result(static_cast<float*> (p));
  std::fill_n(result.get(), count, 0.0f);
  return result;
}

// One runtime-stride kernel for all layouts. Inspect assembly for target-specific
// versioning. Inputs strides differ; Q, output and loop order are shared.
__attribute__((noinline))
void dot_all(const float* q, const float* k, float* out,
            size_t S, size_t H, size_t D, size_t sequence_stride, size_t head_stride) {
  for(size_t h = 0; h < H; ++h) {
    const float* qh = q + h * D;
    for(size_t s = 0; s < S; ++s) {
      const float* row = k + s * sequence_stride + h * head_stride;
      float sum = 0.0f;
      for(size_t d = 0; d < D; ++d) {
        sum += qh[d] * row[d];
      }
      out[h * S + s] = sum;
    }
  }
}

inline void observe(const float* p) {
  asm volatile("" : : "r"(p) : "memory");
}

int main(int argc, char** argv) {
  try {
    if(argc != 7 && argc != 8)
      throw std::runtime_error("Usage: all_heads_benchmark S H D trails target_ms seed [padding_elements=32]");
    const size_t S = number(argv[1]), H = number(argv[2]), D = number(argv[3]);
    const size_t trials = number(argv[4]), target_ms = number(argv[5]), seed = number(argv[6]);
    const size_t padding = argc == 8 ? number(argv[7]):32;
    if(!S || !H || !D || !trials || !target_ms || !padding || seed>UINT32_MAX)
      throw std::runtime_error("Shapes, trails, target_ms, padding must be positive; seed must be uint32");
    const size_t HD = mul(H, D), SD = mul(S, D), HS = mul(H, S);
    const size_t count = mul(S, HD), padded_stride = add(HD, padding);
    // Allocate padding after every token, including the final token.
    const size_t padded_count = mul(S, padded_stride);
    const size_t logical_bytes = mul(count, 4), extra_bytes = mul(mul(S, padding), 4);
    const size_t total_k_bytes = add(mul(logical_bytes, 2), mul(padded_count, 4));
    const long page = sysconf(_SC_PAGESIZE);

    if(page <= 0) throw std::runtime_error("Could not determine page size");
    const size_t alignment = static_cast<size_t>(page);

    std::cerr << "K allocations: " << total_k_bytes << " bytes; alignment: " << alignment << " bytes; loop order: h-s-d\n";
    auto q = allocate(HD, alignment);
    auto out = allocate(HS, alignment);
    std::array<Buffer, 3> k = {allocate(count, alignment), allocate(count, alignment), allocate(padded_count, alignment)};
    const std::array<const char*, 3> names = {"SHD", "HSD", "SHD_PAD"};
    const std::array<size_t, 3> seq_stride = {HD, D, padded_stride};
    const std::array<size_t, 3> head_stride = {D, SD, D};
    const std::array<size_t, 3> allocated = {logical_bytes, logical_bytes, mul(padded_count, 4)};
    std::mt19937 data_rng(static_cast<uint32_t>(seed));
    auto random_float = [&]() { return float(data_rng() >> 8)/8388608.0f - 1.0f; };
    for(size_t i = 0; i < HD; ++i) q.get()[i] = random_float();
    // Stream one canonical logical tensor into all layouts, without a fourth copy.
    for(size_t s = 0; s < S; ++s)
      for(size_t h = 0; h < H; ++h)
        for(size_t d = 0; d < D; ++d) {
          float value = random_float();
          for(size_t l = 0; l < 3; ++l)
            k[l].get()[s*seq_stride[l] + h * head_stride[l] + d] = value;
        }
    std::vector<double> reference(HS, 0.0);
    for(size_t h = 0; h < H; ++h)
      for(size_t s = 0; s < S; ++s)
        for(size_t d = 0; d < D; ++d) {
          reference[h * S + s] += double(q.get()[h * D + d]) * double(k[0].get()[s * HD + h * D + d]);          
        }
    constexpr double atol = 1e-4, rtol = 1e-4;
    std::array<double, 3> errors = {};
    auto invoke = [&](size_t l) {
      dot_all(q.get(), k[l].get(), out.get(), S, H, D, seq_stride[l], head_stride[l]);
      observe(out.get());
    };
    for(size_t l = 0; l < 3; ++l) {
      invoke(l);
      for(size_t i = 0; i < HS; ++i) {
        const double error = std::abs(double(out.get()[i]) - reference[i]);
        errors[l] = std::max(errors[l], error);
        if(!std::isfinite(out.get()[i]) || error > atol + rtol * std::abs(reference[i]))
          throw std::runtime_error(std::string("Validation failed: ") + names[l] + "output=" + std::to_string(i));
      }
    }
    auto measure = [&](size_t l, size_t iterations) {
      const auto start = std::chrono::steady_clock::now();
      for(size_t i = 0; i < iterations; ++i) invoke(l);
      return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now() - start).count();
    };
    std::array<size_t, 3> iterations = {1, 1, 1};
    for(size_t l = 0; l < 3; ++l)
      while(measure(l, iterations[l]) < double(target_ms)*1e6)
        iterations[l] = mul(iterations[l], 2);
    std::cout << "layout, S, H, D, heads_processed, loop_order, padding_elements, padding_bytes_per_token,"
                 "sequence_stride_bytes, head_stride_bytes, trial, order_index, iterations, ns_per_call,"
                 "max_abs_error, logical_k_bytes, allocated_k_bytes, extra_k_bytes, total_k_allocated_bytes,"
                 "alignment_bytes, seed, cache_mode\n" << std::setprecision(12);
    std::mt19937 order_rng(static_cast<uint32_t>(seed));
    std::array<size_t, 3> order = {0, 1, 2};
    for(size_t trial = 0; trial < trials; ++trial) {
      std::shuffle(order.begin(), order.end(), order_rng);
      for(size_t position = 0; position < 3; ++position) {
        const size_t l = order[position];
        measure(l, iterations[l]);
        const double ns = measure(l, iterations[l])/iterations[l];
        std::cout << names[l] << ',' << S << ',' << H << ',' << D << ',' << H << ",h-s-d,"
                  << (l==2?padding:0) << ',' << (l==2?mul(padding, 4):0) << ','
                  << mul(seq_stride[l], 4) << ',' << mul(head_stride[l], 4) << ','
                  << trial << ',' << position << ',' << iterations[l] << ',' << ns << ','
                  << errors[l] << ',' << logical_bytes << ',' << allocated[l] << ','
                  << (l==2?extra_bytes:0) << ',' << total_k_bytes << ',' << alignment << ','
                  << seed << ",repeated_buffer\n";
      }
    }
  } catch(const std::exception& e) {
    std::cerr << e.what() << '\n';
    return 1;
  }
}