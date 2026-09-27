# Minimal qK layout API

Copy `layout_lab/` and `experiments/qk_softmax/run.py` to the repository root.
Python uses only its standard library. C++17 with Clang/GCC and POSIX allocation
(macOS/Linux) is required.

```bash
python3 experiments/qk_softmax/run.py --stage qk --s 128 --h 8 --d 128 --trials 3 --target-ms 2 --out results/generated-qk-smoke
python3 experiments/qk_softmax/run.py --stage qk-softmax --s 128 --h 8 --d 128 --trials 3 --target-ms 2 --out results/generated-softmax-smoke
```

`qk` generates six schedules (three K layouts × two loop orders) with HS output
and no scaling, matching the original mathematical operation.
`qk-softmax` generates twelve schedules by adding HS/SH score layouts. All qK
scores are scaled by 1/sqrt(D). Stable softmax operates along S independently
for each head, in place, with the same h→s passes for both score layouts.

Each candidate is generated and compiled separately. Shapes are passed at
runtime to reduce constant-shape specialization relative to the earlier code.
The generated layout indices are specialized; inspect assembly before assuming
performance equivalence to the original runtime-stride kernels.

Outputs: `generated/` sources/executables, `raw.csv`, `metadata.json` with
compiler, flags, command order and SHA-256 hashes of generated sources.
An existing output directory is rejected. One candidate is allocated per process.
Allocation, initialization, validation, and compilation are excluded from timing.

Modes in the softmax stage:
- `qk`: scaled qK alone.
- `softmax`: restore original scores before each timed call; exclude copy time.
  Input is consequently warm. This includes per-call clock overhead.
- `pipeline`: execute scaled qK then in-place softmax under one timing interval.
  Use this measured total rather than summing isolated stage times.

Every process validates full qK output with an independently indexed FP64
reference. Softmax additionally checks full probabilities against FP64,
nonnegativity, finiteness, and per-head normalization. This is deterministic
random-input validation, not exhaustive numerical testing. Fast-math is not
supported because the reference and benchmark share a translation unit.

The allocation includes Q, K, a working score buffer and a saved score buffer,
plus a double-precision reference. `score_bytes` is one score buffer, not total
workspace. Padding is per token, including the last token. Loop modes operate
on all heads; softmax changes the meaning of the working buffer from scores
to probabilities without changing its physical layout.

Repeat entire runs with fresh output directories. Keep `--seed` fixed and vary
`--order-seed` to vary candidate/mode order. Trials within one process are not
independent process runs. No autotuner, transpose, fusion, pV, or KV append is
implemented yet.

API example (run from repository root):

```python
from layout_lab.spec import QKProblem, Schedule
from layout_lab.codegen import generate_cpp

generate_cpp(
    QKProblem(S=128, H=8, D=128, softmax=True),
    Schedule(k_layout='SHD_PAD', loop_order='shd',
             score_layout='SH', padding_bytes=128),
    'generated.cpp',
)
```

The template is not directly compilable; `generate_cpp` substitutes its markers.
The problem's dimensions are validated by the API and passed by the runner to
the executable, rather than embedded as compile-time constants.
