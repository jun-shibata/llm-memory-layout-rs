// Generated benchmark. Dimensions remain runtime arguments; no fast-math.
#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <cstdint>
#include <iomanip>
#include <iostream>
#include <memory>
#include <random>
#include <stdexcept>
#include <string>
#include <vector>
#include <unistd.h>
constexpr size_t PAD=@PADDING@;
constexpr bool SOFTMAX=@SOFTMAX@;

size_t checked_mul(size_t a, size_t b) {
  if(a && b > SIZE_MAX/a)
    throw std::runtime_error("size overflow");
    return a * b;
}

size_t ki(size_t s, size_t h, size_t d, size_t S, size_t H, size_t D) { return @K_INDEX@; }
size_t oi(size_t h, size_t s, size_t S, size_t H) { return @SCORE_INDEX@; }

struct Free {
  void operator()(float* p) const {std::free(p);}
};

using Buffer = std::unique_ptr<float, Free>;

Buffer buffer(size_t n, size_t alignment) {
  void* p = nullptr;
  if(posix_memalign(&p, alignment, checked_mul(n, sizeof(float))))
    throw std::runtime_error("allocation failed");
  Buffer b(static_cast<float*>(p));
  std::fill_n(b.get(), n, 0.f);
  return b;
}

inline void observe(const float* p) {
  asm volatile("" : : "r"(p) : "memory");
}

__attribute__((noinline))
void qk(const float* q, const float* k, float* z, size_t S, size_t H, size_t D) {
  const float scale = SOFTMAX ? 1.f/std::sqrt(float(D)): 1.f;
  @LOOPS@ {
    float sum = 0;
    for(size_t d = 0; d < D; ++d) {
      sum += q[h*D+d] * k[ki(s, h, d, S, H, D)];
    }
    z[oi(h, s, S, H)] = sum * scale;
  }
}

__attribute__((noinline)) void softmax(float* z, size_t S, size_t H) {
  for(size_t h = 0; h < H; ++h) {
    float maximum = -INFINITY;
    for(size_t s = 0; s < S; ++s)
      maximum = std::max(maximum, z[oi(h, s, S, H)]);
    float sum = 0;
    for(size_t s = 0; s < S; ++s) {
      auto i = oi(h, s, S, H);
      z[i] = std::exp(z[i] - maximum);
      sum += z[i];
    }
    for(size_t s = 0; s < S; ++s)
      z[oi(h, s, S, H)] /= sum;
  }
}

size_t number(const char* p) {
  std::string s(p);
  if(s.empty() || s.find_first_not_of("0123456789") != std::string::npos)
    throw std::runtime_error("invalid integer");
  auto v = std::stoull(s);
  if(v > SIZE_MAX)
    throw std::runtime_error("integer overflow");
  return size_t(v);
}

int main(int argc, char** argv) {
  try {
    if(argc != 8)
      throw std::runtime_error("Usage: benchmark S H D trials target_ms seed mode(qk[softmax|pipeline])");
    size_t S = number(argv[1]), H = number(argv[2]), D = number(argv[3]),
           trials = number(argv[4]), ms = number(argv[5]), seed = number(argv[6]);
    std::string mode = argv[7];
    if(!S || !H || !D || !trials || !ms || seed > UINT32_MAX)
      throw std::runtime_error("invalid arguments");
    if(mode != "qk" && mode != "softmax" && mode != "pipeline")
      throw std::runtime_error("invalid mode");
    if(!SOFTMAX && mode != "qk")
      throw std::runtime_error("softmax disabled");
    size_t HD = checked_mul(H, D), HS = checked_mul(H, S);
    if(PAD > SIZE_MAX - HD)
      throw std::runtime_error("size overflow");
    size_t count = checked_mul(S, HD+PAD);
    long page = sysconf(_SC_PAGESIZE);
    if(page <= 0)
      throw std::runtime_error("page size unavailable");
    auto q = buffer(HD, page), k = buffer(count, page), z = buffer(HS, page), scores = buffer(HS, page);
    std::mt19937 rng{uint32_t(seed)};
    auto random = [&](){
      return float(rng() >> 8)/8388608.f - 1.f;
    };
    for(size_t i = 0; i < HD; ++i)
      q.get()[i] = random();
    std::vector<double> ref(HS, 0.0);
    for(size_t s = 0; s < S; ++s)
      for(size_t h = 0; h < H; ++h)
        for(size_t d = 0; d < D; ++d) {
          float value = random();
          k.get()[ki(s, h, d, S, H, D)] = value;
          ref[h * S + s] += double(q.get()[h * D + d]) * double(value);
        }
    if(SOFTMAX)
      for(auto& v:ref)
        v /= std::sqrt(double(D));
    qk(q.get(), k.get(), scores.get(), S, H, D);
    double score_error = 0, prob_error = 0, sum_error = 0;
    for(size_t h = 0; h < H; ++h)
      for(size_t s = 0; s < S; ++s) {
        double v = scores.get()[oi(h, s, S, H)], r = ref[h * S + s];
        score_error = std::max(score_error, std::abs(v - r));
        if(!std::isfinite(v) || std::abs(v - r) > 1e-4 + 1e-4 * std::abs(r))
          throw std::runtime_error("qK validation failed");
      }
    if(SOFTMAX) {
      std::copy_n(scores.get(), HS, z.get());
      softmax(z.get(), S, H);
      for(size_t h = 0; h < H; ++h) {
        double maximum = *std::max_element(ref.begin() + h * S, ref.begin() + (h + 1) * S), sum = 0, actual_sum = 0;
        for(size_t s = 0; s < S; ++s) {
          ref[h * S + s] = std::exp(ref[h * S + s] - maximum);
          sum += ref[h * S + s];
        }
        for(size_t s = 0; s < S; ++s) {
          double r = ref[h * S + s]/sum, v = z.get()[oi(h, s, S, H)];
          prob_error = std::max(prob_error, std::abs(v - r));
          actual_sum += v;
          if(!std::isfinite(v) || v < 0 || std::abs(v - r) > 1e-6 + 1e-4 * std::abs(r))
            throw std::runtime_error("softmax validation failed");
        }
        sum_error = std::max(sum_error, std::abs(actual_sum - 1));
        if(std::abs(actual_sum - 1) > 1e-4)
          throw std::runtime_error("normalization failed");
      }
    }
    auto invoke = [&]() {
      if(mode != "softmax")
        qk(q.get(), k.get(), z.get(), S, H, D);
      if(mode != "qk")
        softmax(z.get(), S, H);
      observe(z.get());
    };

    // Softmax-only restores original scores outside each timed call. This makes
    // its input warm and excludes copy time. Do not sum stage timings to predict pipeline.
    auto measure = [&](size_t n) {
      double ns = 0;
      if(mode == "softmax")
        for(size_t i = 0; i < n; ++i) {
          std::copy_n(scores.get(), HS, z.get());
          observe(z.get());
          auto t = std::chrono::steady_clock::now();
          invoke();
          ns += std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now() - t).count();
        }
      else {
        auto t = std::chrono::steady_clock::now();
        for(size_t i = 0; i < n; ++i)
          invoke();
        ns += std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now() - t).count();
      }
      return ns;
    };

    size_t n = 1;
    while(measure(n) < double(ms) * 1e6)
      n = checked_mul(n, 2);   
    std::cout << "schedule,mode,S,H,D,trial,iterations,ns_per_call,score_max_abs_error,prob_max_abs_error,prob_sum_error,k_bytes,score_bytes,alignment_bytes,seed\n"
              << std::setprecision(12);
    for(size_t t = 0; t < trials; ++t) {
      measure(n);
      double ns=measure(n)/n;
      std::cout <<"@NAME@,"<<mode<<','<<S<<','<<H<<','<<D<<','<<t<<','<<n<<','<<ns<<','<<score_error<<','<<prob_error<<','<<sum_error<<','<<checked_mul(count,4)
                <<','<<checked_mul(HS,4)<<','<<page<<','<<seed<<'\n';
    }
  } catch(const std::exception& e) {
    std::cerr << e.what() << '\n';
    return 1;
  }
}