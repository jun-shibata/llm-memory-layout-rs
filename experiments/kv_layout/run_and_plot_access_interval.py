"""Build, run and plot the access-interval sweep (S x D x stride).

Stride is expressed as a multiplier of D: multiplier=1 is the HSD-equivalent
access pattern (stride=D), multiplier=H is the SHD-equivalent pattern for H
heads (stride=H*D). Plotting requires matplotlib; pass --no-plot to skip it
and use only the standard library.
"""
import argparse
import csv
import datetime
import io
import itertools
import json
import os
from collections import defaultdict
from pathlib import Path
import platform
import shlex
import statistics
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]

def capture(command):
    try:
        return subprocess.run(
            command, check=True, text=True, capture_output=True
        ).stdout
    except subprocess.CalledProcessError as e:
        print(f"Command failed: {shlex.join(command)}", file=sys.stderr)
        print(e.stderr.strip() or "(no stderr output)", file=sys.stderr)
        raise

def run_sweep(a):
    executable = a.out/'access_interval_benchmark'
    command = [a.cxx, *shlex.split(a.flags),
               str(ROOT/'src/kv_layout/access_interval_benchmark.cpp'), '-o', str(executable)]
    metadata = {'status': 'running', 'started_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
                'platform': platform.platform(), 'machine': platform.machine(), 'processor': platform.processor(),
                'python': sys.version, 'compiler': capture([a.cxx, '--version']), 'build_command': command,
                'arguments': {k: str(v) if isinstance(v, Path) else v for k,v in vars(a).items()},
                'threads': 1, 'cache_mode': 'repeated_buffer', 'atol': 1e-4, 'rtol': 1e-4,
                'timing_scope': 'qK dot only, single shared kernel parameterized by stride; '
                                'excludes allocation, packing and validation',
                'stride_mode': (
                    'absolute_elements' if a.strides is not None else 'multiplier_of_D'
                ),
                'note': (
                    'Stride is measured in float elements. '
                    '--strides supplies absolute values; --multipliers supplies multiples of D. '
                    'stride=D is the contiguous baseline.'
                ),
                'commands': [],
                'buffer_alignment_policy': 'OS page size via posix_memalign',
                }
    for key, cmd in [('commit', ['git','-C',str(ROOT),'rev-parse','HEAD']),
                     ('git_status', ['git','-C',str(ROOT),'status','--porcelain'])]:
        try: metadata[key] = capture(cmd).strip()
        except (OSError, subprocess.CalledProcessError): metadata[key] = None
    if sys.platform == 'darwin':
        try: metadata['cpu_details'] = capture(['sysctl','-n','machdep.cpu.brand_string']).strip()
        except (OSError, subprocess.CalledProcessError): metadata['cpu_details'] = 'unavailable'
    elif Path('/proc/cpuinfo').exists():
        metadata['cpu_details'] = Path('/proc/cpuinfo').read_text()
    meta_path = a.out/'metadata.json'
    def save(): meta_path.write_text(json.dumps(metadata, indent=2)+'\n')
    save()
    csv_path = a.out/'raw.csv'
    try:
        subprocess.run(command, check=True)
        with csv_path.open('w', newline='') as f:
            writer = None
            for s, d in itertools.product(a.s, a.d):
                if a.strides is not None:
                    strides = sorted(set(a.strides))
                else:
                    strides = sorted({m * d for m in a.multipliers})
                cmd = [str(executable), *map(str, [s, d, a.trials, a.target_ms, a.seed]),
                       *map(str, strides)]
                print(f'S={s} D={d} strides={strides}', flush=True)
                metadata['commands'].append(cmd)
                rows = csv.DictReader(io.StringIO(capture(cmd)))
                if writer is None:
                    writer = csv.DictWriter(f, fieldnames=rows.fieldnames)
                    writer.writeheader()
                writer.writerows(rows)
                f.flush()
                save()
        metadata['status'] = 'complete'
    except Exception as e:
        metadata.update(status='failed', error=str(e))
        raise
    finally: save()
    return csv_path

def summarize(csv_path):
    groups = defaultdict(list)
    with csv_path.open(newline='') as f:
        for r in csv.DictReader(f):
            key = (int(r['S']), int(r['D']), int(r['stride']))
            groups[key].append(float(r['ns_per_call'])/1000)
    if not groups:
        raise ValueError(f'{csv_path}: no measurements')
    summary = {}
    for key, values in groups.items():
        median = statistics.median(values)
        q1, _, q3 = statistics.quantiles(values, n=4, method='inclusive') if len(values) > 1 else [median]*3
        summary[key] = (len(values), median, q1, q3)
    return summary

def write_summary(summary, out_path):
    with out_path.open('w', newline='') as f:
        w = csv.writer(f)
        w.writerow(['S','D','stride','stride_over_d','samples','median_us','q1_us','q3_us','time_over_stride_eq_d'])
        for (s, d, stride) in sorted(summary):
            samples, median, q1, q3 = summary[(s, d, stride)]
            baseline = summary.get((s, d, d))
            ratio = median/baseline[1] if baseline else ''
            w.writerow([s, d, stride, stride/d, samples, median, q1, q3, ratio])

def plot(summary, out_dir, plt):
    # One figure per D: x-axis is stride/D (log2); one line per S; top row is
    # absolute time, bottom row is the ratio to that S's stride=D (HSD-equivalent) time.
    d_values = sorted({d for _, d, _ in summary})
    colors = [plt.get_cmap('tab10')(i % 10) for i in range(10)]
    markers = ['o', 's', '^', 'D', 'v', 'P']
    for d in d_values:
        s_values = sorted({s for s, dd, _ in summary if dd == d})
        stride_bytes = sorted({stride * 4 for s, dd, stride in summary if dd == d})
        fig, axes = plt.subplots(2, 1, figsize=(7, 8), sharex=True)
        for i, s in enumerate(s_values):
            points = sorted(
                (stride * 4, summary[(s, d, stride)])
                for s2, dd, stride in summary
                if dd == d and s2 == s
            )
            xs = [x for x, _ in points]
            medians = [v[1] for _, v in points]
            q1s = [v[2] for _, v in points]
            q3s = [v[3] for _, v in points]
            style = dict(color=colors[i % len(colors)], marker=markers[i % len(markers)],
                         label=f'S={s}', alpha=.85, markersize=6)
            axes[0].errorbar(xs, medians,
                              yerr=[[max(0, m-q) for m, q in zip(medians, q1s)],
                                    [max(0, q-m) for m, q in zip(q3s, medians)]],
                              capsize=3, **style)
            baseline = summary.get((s, d, d))
            if baseline:
                axes[1].plot(xs, [m/baseline[1] for m in medians], **style)
        axes[0].set_yscale('log')
        axes[0].set_ylabel('Time per call (us, log scale)\nMedian and IQR')
        axes[0].set_title(f'Access-interval sweep: D={d}\nSingle shared kernel; repeated buffer')
        axes[0].grid(True, which='both', alpha=.2)
        axes[0].legend()
        axes[1].axhline(1, color='gray', linestyle=':', linewidth=1)
        axes[1].set_ylabel('Time / time at stride=D\n(HSD-equivalent baseline)')
        axes[1].set_xlabel('Sequence stride (bytes; FP32)')
        axes[1].set_xscale('log', base=2)
        axes[1].set_xticks(
            stride_bytes,
            labels=[str(value) for value in stride_bytes],
            rotation=60
        )
        axes[1].grid(True, alpha=.2)
        fig.tight_layout()
        stem = out_dir/f'd{d}_access_interval'
        fig.savefig(stem.with_suffix('.png'), dpi=180)
        fig.savefig(stem.with_suffix('.svg'))
        plt.close(fig)

def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--s', nargs='+', type=int, default=[128, 8192, 32768])
    p.add_argument('--d', nargs='+', type=int, default=[64, 128])
    stride_options = p.add_mutually_exclusive_group()
    stride_options.add_argument('--multipliers', nargs='+', type=int,
                                help='stride = multiplier * D; default: 1 8 32')
    stride_options.add_argument('--strides', nargs='+', type=int,
                                help='Absolute strides in float elements, not bytes; each must be >= D')
    p.add_argument('--trials', type=int, default=10)
    p.add_argument('--target-ms', type=int, default=20)
    p.add_argument('--seed', type=int, default=0)
    p.add_argument('--cxx', default=os.environ.get('CXX', 'clang++'))
    p.add_argument('--flags', default='-std=c++17 -O3 -march=native')
    p.add_argument('--out', type=Path,
                    default=ROOT/'results'/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f')+'-access-interval'))
    p.add_argument('--no-plot', action='store_true', help='Skip plotting; only write raw.csv/summary.csv')
    a = p.parse_args()
    # Preserve the original defaults when neither option is specified.
    if a.multipliers is None and a.strides is None:
        a.multipliers = [1, 8, 32]
    if min(a.s + a.d + [a.trials, a.target_ms]) <= 0:
        p.error('S, D, trials and target-ms must be positive.')
    if not 0 <= a.seed <= 2**32 - 1:
        p.error('seed must be uint32.')
    if a.strides is not None:
        # A single D keeps the direct-stride sweep and its baseline unambiguous.
        if len(a.d) != 1:
            p.error('--strides requires exactly one --d value.')
        d = a.d[0]
        if any(stride < d for stride in a.strides):
            p.error(f'Every --strides value must be >= D ({d}).')
        if d not in a.strides:
            p.error(f'--strides must include D ({d}) as the baseline.')
    else:
        if any(m <= 0 for m in a.multipliers):
            p.error('--multipliers values must be positive.')
        if 1 not in a.multipliers:
            p.error('--multipliers must include 1 as the baseline.')
    if not a.no_plot:
        try:
            import matplotlib
            matplotlib.use('Agg')
            import matplotlib.pyplot as plt
        except ImportError:
            p.error('Install matplotlib in this Python environment, or pass --no-plot: '
                     'python3 -m pip install matplotlib')
    a.out = a.out.resolve()
    a.out.mkdir(parents=True, exist_ok=False)
    csv_path = run_sweep(a)
    print(csv_path)
    summary = summarize(csv_path)
    write_summary(summary, a.out/'summary.csv')
    print(a.out/'summary.csv')
    if not a.no_plot:
        fig_dir = a.out/'figures'
        fig_dir.mkdir(exist_ok=True)
        plot(summary, fig_dir, plt)
        print(fig_dir)
    print('Ratios in summary.csv/plots use per-shape medians relative to stride=D (HSD-equivalent).')

if __name__ == '__main__':
    main()
