"""Analyze five S=3584, H=8, D=128, padding=64 repeat runs.

Requires matplotlib. Standard-library statistics use inclusive quartiles.
No observations are removed. Ratios are ratios of within-run medians.
"""
import argparse
import csv
import math
import statistics as st
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


def write_csv(path, rows):
    with path.open('w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    runs = range(1, 6)
    orders = ('hsd', 'shd')
    modes = ('qk', 'pipeline')
    layouts = ('SHD', 'SHD_PAD')
    data, summaries, ratios = {}, [], []
    for run in runs:
        path = args.root / f'generated-softmax-s3584-p64-recheck-run{run}' / 'raw.csv'
        with path.open(newline='') as f:
            rows = list(csv.DictReader(f, skipinitialspace=True))
        for order in orders:
            for mode in modes:
                for layout in layouts:
                    schedule = f'{layout}_{order}_HS_p{64 if layout == "SHD_PAD" else 0}'
                    group = [r for r in rows if r['schedule'] == schedule and r['mode'] == mode]
                    if len(group) != 10:
                        raise ValueError(f'{path}: {schedule}/{mode}: expected 10 trials, got {len(group)}')
                    trials = [int(r['trial']) for r in group]
                    if len(set(trials)) != 10:
                        raise ValueError(f'{path}: duplicate trial IDs in {schedule}/{mode}')
                    for r in group:
                        if tuple(int(r[k]) for k in ('S', 'H', 'D', 'seed')) != (3584, 8, 128, 0):
                            raise ValueError(f'{path}: unexpected shape or input seed')
                    group.sort(key=lambda r: int(r['trial']))
                    values = [float(r['ns_per_call']) / 1e6 for r in group]
                    if any(not math.isfinite(v) or v <= 0 for v in values):
                        raise ValueError(f'{path}: invalid timing')
                    median = st.median(values)
                    q1, _, q3 = st.quantiles(values, n=4, method='inclusive')
                    data[run, order, mode, layout] = (group, values)
                    summaries.append(dict(run=run, loop_order=order, mode=mode,
                        layout=layout, n=len(values), median_ms=median,
                        q1_ms=q1, q3_ms=q3, iqr_ms=q3-q1,
                        iqr_percent=100*(q3-q1)/median, min_ms=min(values), max_ms=max(values),
                        source=str(path.resolve())))
                base = st.median(data[run, order, mode, 'SHD'][1])
                padded = st.median(data[run, order, mode, 'SHD_PAD'][1])
                ratios.append(dict(run=run, loop_order=order, mode=mode,
                    baseline_ms=base, padded_ms=padded, ratio=padded/base,
                    change_percent=100*(padded/base-1)))

    args.out.mkdir(parents=True, exist_ok=True)
    write_csv(args.out/'timing_summary.csv', summaries)
    write_csv(args.out/'paired_ratios.csv', ratios)
    colors = {'SHD': '#0072B2', 'SHD_PAD': '#D55E00'}
    order_titles = {'hsd': 'h → s → d', 'shd': 's → h → d'}

    def save(fig, name):
        for ext in ('png', 'svg'):
            fig.savefig(args.out/f'{name}.{ext}', dpi=180)
        plt.close(fig)

    # Absolute times: retain all observations, including potential outliers.
    fig, axes = plt.subplots(2, 2, figsize=(12, 8))
    for i, mode in enumerate(modes):
        for j, order in enumerate(orders):
            ax = axes[i, j]
            for layout, offset in [('SHD', -.18), ('SHD_PAD', .18)]:
                values = [data[r, order, mode, layout][1] for r in runs]
                positions = [r+offset for r in runs]
                box = ax.boxplot(values, positions=positions, widths=.28,
                    patch_artist=True, showfliers=False, manage_ticks=False)
                for b in box['boxes']:
                    b.set_facecolor(colors[layout]); b.set_alpha(.25)
                for pos, vals in zip(positions, values):
                    ax.scatter([pos+(k-4.5)*.012 for k in range(10)], vals,
                               color=colors[layout], s=15, alpha=.65)
                ax.plot([], [], color=colors[layout], label=layout)
            ax.set(title=f'{mode} | {order_titles[order]}', xlabel='Run', ylabel='Time (ms)', xticks=list(runs))
            ax.grid(axis='y', alpha=.2)
            ax.legend()
    fig.suptitle('S=3584, H=8, D=128, scores HS | padding 0 vs 64 B')
    fig.text(.5, .01, 'Boxes: Q1–Q3; whiskers: 1.5 IQR. All 10 observations shown. Panel scales differ.', ha='center', fontsize=9)
    fig.tight_layout(rect=(0,.04,1,.95))
    save(fig, 'timing_distributions')

    fig, axes = plt.subplots(2, 2, figsize=(11, 7), sharey=True)
    for i, mode in enumerate(modes):
        for j, order in enumerate(orders):
            ax = axes[i,j]
            vals = [r['ratio'] for r in ratios if r['mode']==mode and r['loop_order']==order]
            ax.plot(list(runs), vals, 'o-', color='#0072B2')
            ax.axhline(1, color='0.4', linestyle='--')
            ax.set(title=f'{mode} | {order_titles[order]}', xlabel='Run',
                   ylabel='SHD_PAD median / SHD median', xticks=list(runs))
            ax.grid(alpha=.2)
    fig.suptitle('Within-run ratios of medians (not paired trial ratios)')
    fig.tight_layout(rect=(0,0,1,.95))
    save(fig, 'paired_ratios')

    for mode in modes:
        fig, axes = plt.subplots(2, 5, figsize=(16, 6), sharey='row')
        for i, order in enumerate(orders):
            for j, run in enumerate(runs):
                ax = axes[i,j]
                for layout in layouts:
                    group, vals = data[run, order, mode, layout]
                    ax.plot([int(r['trial']) for r in group], vals, 'o-',
                            color=colors[layout], markersize=3, label=layout)
                ax.set_title(f'{order_titles[order]} | run {run}')
                ax.set_xlabel('Trial ID')
                if j == 0:
                    ax.set_ylabel('Time (ms)')
                    ax.legend(fontsize=8)
                ax.grid(alpha=.2)
        fig.suptitle(f'{mode}: trial progression within each separately measured configuration')
        fig.tight_layout(rect=(0,0,1,.94))
        save(fig, f'trial_progression_{mode}')

    report = ['# Padding repeat-run summary', '',
        'S=3584, H=8, D=128, score layout HS, padding 64 bytes.',
        'Five runs × ten trials per configuration. No observations removed.', '',
        '| Mode | Order | Median ratio across runs | Min–max ratio |',
        '|---|---|---:|---:|']
    for mode in modes:
        for order in orders:
            vals = [r['ratio'] for r in ratios if r['mode']==mode and r['loop_order']==order]
            report.append(f'| {mode} | {order} | {st.median(vals):.4f} | {min(vals):.4f}–{max(vals):.4f} |')
    report += ['', 'Ratios compare medians from the same run. Min–max ranges are not confidence intervals.',
        'Inspect timing_summary.csv for baseline and padded timings separately.',
        'Trial IDs belong to separate measurement blocks; matching IDs are not simultaneous pairs.',
        'These plots describe variability; they do not identify its cause or establish statistical significance.',
        'CSV files alone do not verify compiler flags, measurement order, or machine conditions; retain metadata.json.']
    (args.out/'summary.md').write_text('\n'.join(report)+'\n')
    print('\n'.join(report))
    print(f'\nOutputs: {args.out.resolve()}')


if __name__ == '__main__':
    main()
