"""Compare raw benchmark CSVs. Python 3.10+; plotting requires matplotlib.

Example:
  python3 scripts/compare_runs.py result-1.csv result-2.csv result-3.csv \
      --labels Run1 Run2 Run3 --out results/comparison

Time panels show within-run median and IQR. Ratio panels show ratios of
medians (not medians of trial ratios), without uncertainty intervals.
Runs are never pooled. Input files are never modified.
"""
import argparse
import csv
import math
from collections import defaultdict
from pathlib import Path
import statistics

LAYOUTS = ('SHD', 'HSD', 'DSH')
SHAPE = ('S', 'H', 'D', 'head_start', 'heads_processed')
REQUIRED = {*SHAPE, 'layout', 'trial', 'ns_per_call', 'seed', 'cache_mode'}


def read_run(path):
    groups = defaultdict(list)
    trials = defaultdict(set)
    settings = set()
    with path.open(newline='', encoding='utf-8-sig') as f:
        reader = csv.DictReader(f)
        missing = REQUIRED - set(reader.fieldnames or [])
        if missing:
            raise ValueError(f'{path}: missing columns: {sorted(missing)}')
        for line, row in enumerate(reader, 2):
            try:
                shape = tuple(int(row[k]) for k in SHAPE)
                s, h, d, start, count = shape
                layout = row['layout']
                trial = int(row['trial'])
                us = float(row['ns_per_call']) / 1000
                if min(s, h, d, count) <= 0 or start < 0 or start + count > h:
                    raise ValueError('invalid shape/head range')
                if layout not in LAYOUTS or trial < 0 or not math.isfinite(us) or us <= 0:
                    raise ValueError('invalid layout, trial or time')
                key = (*shape, layout)
                if trial in trials[key]:
                    raise ValueError('duplicate trial for this shape/layout')
                trials[key].add(trial)
                groups[key].append(us)
                settings.add((int(row['seed']), row['cache_mode']))
            except (ValueError, TypeError) as e:
                raise ValueError(f'{path}:{line}: {e}') from e
    if not groups:
        raise ValueError(f'{path}: no data')
    if len(settings) != 1:
        raise ValueError(f'{path}: mixed seeds or cache modes')
    for shape in {k[:-1] for k in groups}:
        if any((*shape, layout) not in groups for layout in LAYOUTS):
            raise ValueError(f'{path}: missing layout for {shape}')
        if len({frozenset(trials[(*shape, l)]) for l in LAYOUTS}) != 1:
            raise ValueError(f'{path}: trial sets differ between layouts for {shape}')
    summary = {}
    for key, values in groups.items():
        median = statistics.median(values)
        q1, _, q3 = (statistics.quantiles(values, n=4, method='inclusive')
                     if len(values) > 1 else [median] * 3)
        summary[key] = (len(values), median, q1, q3)
    return summary, settings


def write_summary(path, runs, labels):
    with path.open('w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['run', *SHAPE, 'layout', 'samples', 'median_us',
                         'q1_us', 'q3_us', 'time_over_hsd'])
        for label, run in zip(labels, runs):
            for key, values in sorted(run.items()):
                baseline = run[(*key[:-1], 'HSD')][1]
                writer.writerow([label, *key, *values, values[1] / baseline])


def plot(runs, labels, out, cache_mode, plt):
    # One file per H/D/head selection: columns=layouts; rows=time and ratio.
    panels = sorted({key[1:5] for key in runs[0]})
    for h, d, head, count in panels:
        lengths = sorted({key[0] for key in runs[0] if key[1:5] == (h,d,head,count)})
        fig, axes = plt.subplots(2, 3, figsize=(14, 8), sharex=True, sharey='row')
        colors = [plt.get_cmap('tab10')(i % 10) for i in range(len(runs))]
        markers = ['o', 's', '^', 'D', 'v', 'P']
        for col, layout in enumerate(LAYOUTS):
            for i, (label, run) in enumerate(zip(labels, runs)):
                stats = [run[(s,h,d,head,count,layout)] for s in lengths]
                medians = [v[1] for v in stats]
                ratios = [v[1]/run[(s,h,d,head,count,'HSD')][1] for s,v in zip(lengths,stats)]
                style = dict(color=colors[i], marker=markers[i % len(markers)], label=label,
                             alpha=.85, markersize=5)
                axes[0,col].errorbar(lengths, medians,
                                    yerr=[[v[1]-v[2] for v in stats], [v[3]-v[1] for v in stats]],
                                    capsize=3, **style)
                axes[1,col].plot(lengths, ratios, **style)
            axes[0,col].set_title(layout)
            axes[0,col].set_yscale('log')
            axes[1,col].axhline(1, color='gray', linestyle=':', linewidth=1)
            axes[1,col].set_xlabel('Sequence length S')
            for row in range(2):
                axes[row,col].set_xscale('log', base=2)
                axes[row,col].set_xticks(lengths, labels=[str(s) for s in lengths], rotation=30)
                axes[row,col].grid(True, alpha=.2)
        axes[0,0].set_ylabel('Time per call (us, log scale)\nMedian and within-run IQR')
        axes[1,0].set_ylabel('Time / HSD time\nRatio of medians; higher = slower')
        axes[0,0].legend()
        fig.suptitle(f'qK layout comparison: H={h}, D={d}, head={head}, count={count}\n'
                     f'Cache mode: {cache_mode}; each run summarized separately')
        fig.tight_layout(rect=(0,0,1,.92))
        stem = out/f'h{h}_d{d}_head{head}_count{count}'
        fig.savefig(stem.with_suffix('.png'), dpi=180)
        fig.savefig(stem.with_suffix('.svg'))
        plt.close(fig)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('csvs', nargs='+', type=Path)
    parser.add_argument('--labels', nargs='+', help='One unique label per input CSV')
    parser.add_argument('--out', type=Path, required=True, help='New output directory; existing directories are rejected')
    parser.add_argument('--summary-only', action='store_true', help='Write comparison.csv without matplotlib')
    args = parser.parse_args()
    labels = args.labels or [p.stem for p in args.csvs]
    if len(labels) != len(args.csvs) or len(set(labels)) != len(labels):
        parser.error('Supply one unique label per input CSV')
    try:
        parsed = [read_run(p) for p in args.csvs]
        runs = [r for r,_ in parsed]
        for run, settings in parsed[1:]:
            if set(run) != set(runs[0]):
                raise ValueError('Input runs have different shape/layout sets')
            if settings != parsed[0][1]:
                raise ValueError('Input runs have different seeds or cache modes')
        if not args.summary_only:
            try:
                import matplotlib
                matplotlib.use('Agg')
                import matplotlib.pyplot as plt
            except ImportError:
                parser.error('Install matplotlib in this Python environment: python3 -m pip install matplotlib')
        args.out.mkdir(parents=True, exist_ok=False)
        write_summary(args.out/'comparison.csv', runs, labels)
        if not args.summary_only:
            plot(runs, labels, args.out, next(iter(parsed[0][1]))[1], plt)
    except (ValueError, OSError) as e:
        parser.error(str(e))
    print(f'Saved: {args.out.resolve()}')
    print('Ratios use per-run medians. IQR bars describe within-run spread, not confidence intervals.')


if __name__ == '__main__':
    main()