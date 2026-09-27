"""Plot paired SHD_PAD/SHD timings from the 36 size-sweep raw CSVs."""
import argparse
import csv
import math
import re
import statistics
from collections import defaultdict
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, required=True, help='Results directory')
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    # sizes, pads, runs = (1024, 2048, 4096, 8192), (64, 128, 256), (1, 2, 3)
    sizes, pads, runs = (1024, 2048, 2560, 3072, 3584, 4096, 8192), (64, 128, 256), (1, 2, 3)
    modes, orders = ('qk', 'pipeline'), ('hsd', 'shd')
    records = []
    for size in sizes:
        for pad in pads:
            for run in runs:
                source = args.root / f'generated-softmax-size-s{size}-p{pad}-run{run}' / 'raw.csv'
                groups = defaultdict(list)
                trial_ids = defaultdict(set)
                with source.open(newline='') as stream:
                    for row in csv.DictReader(stream, skipinitialspace=True):
                        if (int(row['S']), int(row['H']), int(row['D'])) != (size, 8, 128):
                            raise ValueError(f'Unexpected shape: {source}')
                        match = re.fullmatch(r'(SHD|SHD_PAD)_(hsd|shd)_HS_p(\d+)', row['schedule'])
                        if not match or row['mode'] not in modes:
                            continue
                        layout, order, actual_pad = match.groups()
                        expected_pad = 0 if layout == 'SHD' else pad
                        if int(actual_pad) != expected_pad:
                            raise ValueError(f'Unexpected padding: {source}')
                        value = float(row['ns_per_call']) / 1e6
                        if not math.isfinite(value) or value <= 0:
                            raise ValueError(f'Invalid timing: {source}')
                        key = (layout, order, row['mode'])
                        if row['trial'] in trial_ids[key]:
                            raise ValueError(f'Duplicate trial: {source}, {key}')
                        trial_ids[key].add(row['trial'])
                        groups[key].append(value)
                for order in orders:
                    for mode in modes:
                        base = groups['SHD', order, mode]
                        padded = groups['SHD_PAD', order, mode]
                        if len(base) != 10 or len(padded) != 10:
                            raise ValueError(f'Expected 10 trials per group: {source}, {order}, {mode}')
                        b, p = statistics.median(base), statistics.median(padded)
                        records.append(dict(S=size, H=8, D=128, padding_bytes=pad,
                                            run=run, loop_order=order, mode=mode,
                                            baseline_ms=b, padded_ms=p, ratio=p / b,
                                            source=str(source.resolve())))

    args.out.mkdir(parents=True, exist_ok=True)
    with (args.out / 'paired_summary.csv').open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(records[0]))
        writer.writeheader()
        writer.writerows(records)

    colors = {64: '#0072B2', 128: '#D55E00', 256: '#009E73'}
    markers = {1: 'o', 2: 's', 3: '^'}
    titles = {'hsd': 'h → s → d', 'shd': 's → h → d'}
    for metric in ('ratio', 'padded_ms'):
        fig, axes = plt.subplots(2, 2, figsize=(11, 7), sharex=True, sharey='row')
        for i, mode in enumerate(modes):
            for j, order in enumerate(orders):
                ax = axes[i, j]
                subset = [r for r in records if r['mode'] == mode and r['loop_order'] == order]
                for pad in pads:
                    medians = []
                    for size in sizes:
                        selected = [r for r in subset if r['padding_bytes'] == pad and r['S'] == size]
                        medians.append(statistics.median(r[metric] for r in selected))
                        for r in selected:
                            ax.scatter(size, r[metric], color=colors[pad], marker=markers[r['run']],
                                       s=27, alpha=0.7, zorder=3)
                    ax.plot(sizes, medians, color=colors[pad], label=f'{pad} B')
                if metric == 'ratio':
                    ax.axhline(1, color='0.4', linestyle='--', linewidth=1)
                else:
                    # Nine distinct matched controls per S; do not treat them as one run.
                    control = [statistics.median(r['baseline_ms'] for r in subset if r['S'] == s) for s in sizes]
                    ax.plot(sizes, control, color='0.35', linestyle='--', label='0 B (control median)')
                    ax.scatter([r['S'] for r in subset], [r['baseline_ms'] for r in subset],
                               color='0.5', marker='x', s=18, alpha=0.5)
                    ax.set_ylim(bottom=0)
                ax.set_title(f'{mode} | {titles[order]}')
                ax.set_xscale('log', base=2)
                ax.set_xticks(sizes, [str(s) for s in sizes])
                ax.grid(alpha=0.2)
                if j == 0:
                    ax.set_ylabel('SHD_PAD / matched SHD' if metric == 'ratio' else 'Time (ms)')
                if i == 1:
                    ax.set_xlabel('Sequence length S')
        handles, labels = axes[0, 0].get_legend_handles_labels()
        fig.legend(handles, labels, loc='upper center', ncol=len(labels), bbox_to_anchor=(0.5, 0.95))
        fig.suptitle('Padding and sequence length | H=8, D=128, score layout HS')
        fig.text(0.5, 0.02, 'Points: per-run medians of 10 trials (○ run 1, □ run 2, △ run 3).\n'
                 'Lines: median across 3 runs. Ratios use controls from the same file; pipeline is measured directly.',
                 ha='center', fontsize=9)
        fig.tight_layout(rect=(0, 0.08, 1, 0.9))
        name = 'padding_size_ratio' if metric == 'ratio' else 'padding_size_time'
        for extension in ('png', 'svg'):
            fig.savefig(args.out / f'{name}.{extension}', dpi=180)
        plt.close(fig)
    file_count = len(sizes) * len(pads) * len(runs)
    print(
        f'Read {file_count} files; wrote {len(records)} paired comparisons '
        f'to {args.out.resolve()}'
    )


if __name__ == '__main__':
    main()
