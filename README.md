# Evaluating KV Cache Layout, Loop Order, and Padding on a CPU

## Objective

This study investigates how the physical layout of the KV cache, loop order, and the range of heads processed affect qK execution time on a CPU. Generated assembly and available performance counters were also examined to investigate the effects of padding.

The experiments were conducted on macOS with an Apple M1. S denotes sequence length, H the number of heads, and D the head dimension.

## 1. From Single-Head to Multi-Head Processing

The initial single-head experiments compared SHD, HSD, and DSH layouts. Execution time varied with both layout and sequence length.

Subsequent experiments focused on SHD and HSD, varying the access stride along the sequence dimension and introducing padding. These experiments showed that changing the stride affected performance, but the contributions of compiler optimizations and the memory hierarchy remained unresolved.

Single-head processing does not access the other heads, so its layout ranking does not necessarily apply to all-head processing. We therefore compared two loop orders for processing all heads: h→s→d and s→h→d.

HSD was faster with h→s→d, whereas SHD and SHD_PAD were faster with s→h→d. Layout performance must therefore be evaluated together with the head range and loop order.

[Insert single-head layout comparison figure](notes/kv-layout-loop-order/figures/h32_d128_head16_count1.svg)

[Insert multi-head comparison figure by loop order](notes/kv-layout-loop-order/figures/all-heads-loop-order-boxplot.svg)

## 2. Effects of Padding

Using generated qK + softmax implementations, we varied sequence length and padding size while keeping H=8, D=128, and the intermediate score layout fixed to HS.

With h→s→d, the processing cost of padded layouts tended to increase as sequence length grew. With s→h→d, the cost remained comparatively stable. The difference persisted after dividing execution time by S, indicating that it could not be explained solely by the increase in the number of elements processed.

The effects of padding depended on sequence length, padding size, and loop order. Changing the stride to avoid a particular access pattern did not necessarily improve performance.

[Insert execution time / S figure by padding size](notes/kv-layout-loop-order/figures/normalized_cost.svg)

## 3. Investigating the Performance Differences

For the SHD and SHD_PAD assembly examined, the main computation was equivalent within each loop order. We found no evidence that differences in vector width or accumulation strategy alone explained the observed performance gap.

L1D measurements showed more load misses per token for SHD_PAD with h→s→d. However, a substantial difference in miss counts was already present at S=2048, where the execution-time difference was small. The increase in execution time at larger sequence lengths could not be explained by the increase in L1D miss counts alone.

For S=8192, L2 TLB measurements were repeated with a different execution order. SHD_PAD with h→s→d remained slower than SHD despite having fewer L2 TLB data misses per token. This result does not support the hypothesis that an increase in L2 TLB misses caused the slowdown introduced by padding.

Absolute L2 TLB miss counts varied between measurement sessions. L2 data cache misses could not be measured, leaving the contributions of lower-level caches, prefetching, and memory-access concurrency unresolved.

## Conclusions

- KV layout performance depends on the combination of physical layout, the range of heads processed, and loop order.
- Padding is condition-dependent and cannot be applied as a universally effective optimization.
- Assembly inspection and performance counters narrowed the possible explanations, but did not establish the cause of the performance differences.

These conclusions are limited to the CPU, tensor shapes, implementations, and measurement conditions evaluated. Timings collected with performance counters are treated separately from ordinary benchmark timings. Measurement intervals within a single process are also distinguished from independent process runs.
