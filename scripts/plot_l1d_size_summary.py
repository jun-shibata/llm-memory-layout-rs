"""Plot normalized Instruments batch summaries. Requires matplotlib."""
import argparse
import csv
import math
import statistics as st
from collections import defaultdict
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    configs = {
        'SHD_hsd_HS_p0': ('SHD | h → s → d', '#0072B2', '-'),
        'SHD_PAD_hsd_HS_p128': ('SHD_PAD | h → s → d', '#D55E00', '-'),
        'SHD_shd_HS_p0': ('SHD | s → h → d', '#0072B2', '--'),
        'SHD_PAD_shd_HS_p128': ('SHD_PAD | s → h → d', '#D55E00', '--'),
    }
    metrics = [
        ('us_per_token', 'qK time / token', 'µs / token'),
        ('Cycles per token', 'CPU cycles / token', 'Cycles / token'),
        ('L1D Cache Load Misses per token', 'L1D cache load misses / token', 'Events / token'),
        ('L1D TLB Misses per token', 'L1D TLB misses / token', 'Events / token'),
    ]
    groups = defaultdict(list)
    seen = set()
    with args.input.open(newline='') as f:
        for row in csv.DictReader(f):
            size = int(row['S'])
            name = row['name']
            if name not in configs or size <= 0:
                raise ValueError(f'Unexpected configuration: {name}, S={size}')
            trial = int(row['trial'])
            key = (size, name, trial)
            if key in seen:
                raise ValueError(f'Duplicate batch: {key}')
            seen.add(key)
            for field, _, _ in metrics:
                row[field] = float(row[field])
                if not math.isfinite(row[field]) or row[field] < 0:
                    raise ValueError(f'Invalid {field}: {key}')
            row['trial'] = trial
            groups[size, name].append(row)
    sizes = sorted({s for s, _ in groups})
    if not sizes:
        raise ValueError('No data')
    for size in sizes:
        for name in configs:
            group = groups[size, name]
            if len(group) != 5 or len({r['run'] for r in group}) != 1:
                raise ValueError(f'Expected five batches from one trace run: {size}, {name}')
            group.sort(key=lambda r: r['trial'])

    args.out.mkdir(parents=True, exist_ok=True)
    summary = []
    fig, axes = plt.subplots(2, 2, figsize=(12, 8))
    for ax, (field, title, ylabel) in zip(axes.flat, metrics):
        for name, (label, color, style) in configs.items():
            medians = []
            for size in sizes:
                values = [r[field] for r in groups[size, name]]
                medians.append(st.median(values))
                summary.append(dict(S=size, name=name, metric=field, n_batches=len(values),
                    median=st.median(values), minimum=min(values), maximum=max(values)))
                ax.scatter([size]*len(values), values, color=color, alpha=.5, s=24,
                           marker='o' if style == '-' else 'x', zorder=3)
            ax.plot(sizes, medians, color=color, linestyle=style, linewidth=1.8, label=label)
        ax.set_title(title)
        ax.set_ylabel(ylabel)
        ax.set_xlabel('Sequence length S')
        ax.set_xscale('log', base=2)
        ax.set_xticks(sizes, [str(s) for s in sizes])
        ax.set_ylim(bottom=0)
        ax.grid(alpha=.2)
    legend = [Line2D([0], [0], color=c, linestyle=ls, marker='o' if ls=='-' else 'x', label=label)
              for label,c,ls in configs.values()]
    fig.legend(handles=legend, loc='upper center', bbox_to_anchor=(.5,.95), ncol=2, fontsize=9)
    fig.suptitle('L1D Miss Sampling | H=8, D=128, scores HS | padding 0 / 128 B')
    fig.text(.5,.015,
        'Points: five MeasuredBatch intervals per condition. Lines: medians (connections are visual guides).\n'
        'One token includes all 8 heads. Events are normalized counter estimates, not sample counts.\n'
        'Five intervals belong to one process per condition; they are not independent process runs.',
        ha='center',fontsize=9)
    fig.tight_layout(rect=(0,.105,1,.85))
    for ext in ('png','svg'):
        fig.savefig(args.out/f'l1d_size_comparison.{ext}',dpi=180)
    plt.close(fig)
    with (args.out/'plot_summary.csv').open('w',newline='') as f:
        writer=csv.DictWriter(f,fieldnames=list(summary[0]))
        writer.writeheader();writer.writerows(summary)
    print(f'Validated {len(seen)} batches across {len(sizes)} sizes; saved figures to {args.out.resolve()}')


if __name__=='__main__':
    main()
