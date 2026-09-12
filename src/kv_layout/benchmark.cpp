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

enum Layout { SHD, HSD, DSH };
template<Layout L>
size_t index(size_t s, size_t h, size_t d, size_t S, size_t H, size_t D) {
  if constexpr (L == SHD) return (s * H + h) * D + d;
  if constexpr (L == HSD) return (h * S + s) * D + d;
  return (d * S + s) * H + h;
}

// Separate specialized functions; no layout dispatch in the timed inner loop.
template<Layout L>
__attribute__((noinline)) void dot(const float* q, const float* k, float* out,
  size_t S, size_t H, size_t D, size_t head) {
  for (size_t s = 0; s < S; ++s) {
    float sum = 0;
    for (size_t d = 0; d < D; ++d) {
      sum += q[d] * k[index<L>(s, head, d, S, H, D)];
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
    if (argc != 8) throw std::runtime_error("Usage: benchmark S H D head trials target_ms seed");
    auto number = [](const char* s) -> size_t {
      std::string value(s); size_t pos = 0;
      if (value.empty() || value[0] == '-') throw std::runtime_error("Invalid integer");
      auto n = std::stoull(value, &pos);
      if (pos != value.size() || n > std::numeric_limits<size_t>::max())
        throw std::runtime_error("Invalid Integer");
      return static_cast<size_t>(n);
    };
    const size_t S = number(argv[1]), H = number(argv[2]), D = number(argv[3]);
    const size_t head = number(argv[4]), trials = number(argv[5]);
    const size_t target_ms = number(argv[6]), seed = number(argv[7]);
    if (!S || !H || !D || !trials || !target_ms || head >= H)
      throw std::runtime_error("Dimensions, trials, target_ms must be positive; head < H");
    if (S > SIZE_MAX/H || S*H > SIZE_MAX/D || S*H*D > SIZE_MAX/sizeof(float))
      throw std::runtime_error("Shape overflow");
    const size_t count = S*H*D;
    std::vector<float> q(D), shd(count), hsd(count), dsh(count), out(S);
    std::mt19937 rng(static_cast<uint32_t>(seed));
    auto random_float = [&]() {return static_cast<float>(rng() >> 8) / 8388608.0f - 1.0f; };
    for (auto& x: q) x = random_float();
    for (size_t s = 0; s < S; ++s) {
      for (size_t h = 0; h < H; ++h) {
        for (size_t d = 0; d < D; ++d) {
          const float x = random_float();
          shd[index<SHD>(s, h, d, S, H, D)] = x;
          hsd[index<HSD>(s, h, d, S, H, D)] = x;
          dsh[index<DSH>(s, h, d, S, H, D)] = x;
        }
      }
    }
    std::vector<double> reference(S);
    for (size_t s = 0; s < S; ++s) {
      for (size_t d = 0; d < D; ++d) {
        reference[s] += double(q[d])*double(shd[index<SHD>(s, head, d, S, H, D)]);
      }
    }
    using Kernel = void(*)(const float*, const float*, float*, size_t, size_t, size_t, size_t);
    Kernel kernels[] = {dot<SHD>, dot<HSD>, dot<DSH>};
    const float* data[] = {shd.data(), hsd.data(), dsh.data()};
    const char* names[] = {"SHD", "HSD", "DSH"};
    double errors[3] = {};
    constexpr double atol = 1e-4, rtol = 1e-4;
    for (int l = 0; l < 3; ++l) {
      kernels[l](q.data(), data[l], out.data(), S, H, D, head);
      for (size_t s = 0; s < S; ++s) {
        double e = std::abs(double(out[s]) - reference[s]);
        errors[l] = std::max(errors[l], e);
        if (!std::isfinite(out[s]) || e > atol+rtol*std::abs(reference[s])) {
          throw std::runtime_error(std::string("validation failed:")+names[l]);
        }
      }
    }
    auto measure=[&](int l, size_t iterations) {
      const auto start = std::chrono::steady_clock::now();
      for (size_t i = 0; i < iterations; ++i) {
        kernels[l](q.data(), data[l], out.data(), S, H, D, head);
        observe(out.data());
      }
      return std::chrono::duration<double,std::nano>
        (std::chrono::steady_clock::now()-start).count();
    };
    size_t iterations[3]={1,1,1};
    for(int l=0;l<3;++l) {
      while(measure(l,iterations[l]) < double(target_ms)*1e6) {
        if(iterations[l] > SIZE_MAX/2) throw std::runtime_error("Iteration overflow");
        iterations[l]*=2;
      }
    }
    std::cout << "layout,S,H,D,head_start,heads_processed,trial,iterations,ns_per_call,max_abs_error,seed,cache_mode\n" << std::setprecision(12);
    std::vector<int> order={0,1,2};
    for(size_t trial=0;trial<trials;++trial) {
      std::shuffle(order.begin(),order.end(),rng);
      for(int l:order) {
        measure(l,iterations[l]); // Warm this layout immediately before measurement.
        const double ns=measure(l,iterations[l])/iterations[l];
        std::cout << names[l] << ',' << S << ',' << H << ',' << D << ',' << head
          << ",1," << trial << ',' << iterations[l] << ',' << ns << ','
          << errors[l] << ',' << seed << ",repeated_buffer\n";
      }
    }
  } catch(const std::exception& e) { std::cerr << e.what() << '\n'; return 1; }
}
