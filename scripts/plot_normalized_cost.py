"""Normalize paired_summary.csv timings by S; requires matplotlib."""
import argparse
import csv
import math
import statistics as st
from collections import defaultdict
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--input', type=Path, required=True)
    p.add_argument('--out', type=Path, required=True)
    a = p.parse_args()
    with a.input.open(newline='') as f:
        rows = list(csv.DictReader(f))
    groups = defaultdict(list)
    output = []
    seen = set()
    for r in rows:
        s, pad, run = int(r['S']), int(r['padding_bytes']), int(r['run'])
        if s <= 0 or (int(r['H']), int(r['D'])) != (8, 128):
            raise ValueError('Expected positive S and fixed H=8, D=128')
        key = (r['mode'], r['loop_order'], s, pad, run)
        if key in seen:
            raise ValueError(f'Duplicate comparison: {key}')
        seen.add(key)
        for layout, col in [('SHD', 'baseline_ms'), ('SHD_PAD', 'padded_ms')]:
            ms = float(r[col])
            if not math.isfinite(ms) or ms <= 0:
                raise ValueError(f'Invalid timing: {key}')
            cost = ms * 1000 / s
            # Baselines remain matched to their original padding experiment.
            groups[r['mode'], r['loop_order'], pad, layout, s].append(cost)
            output.append(dict(S=s, H=8, D=128, run=run,
                comparison_padding_bytes=pad, layout=layout,
                physical_padding_bytes=0 if layout == 'SHD' else pad,
                mode=r['mode'], loop_order=r['loop_order'],
                median_ms=ms, us_per_token=cost, source=r.get('source', '')))
    if not output:
        raise ValueError('No data')
    a.out.mkdir(parents=True, exist_ok=True)
    with (a.out/'normalized_cost.csv').open('w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=list(output[0])); w.writeheader(); w.writerows(output)
    pads = sorted({int(r['padding_bytes']) for r in rows})
    colors = dict(zip(pads, ['#0072B2', '#D55E00', '#009E73']))
    fig, axes = plt.subplots(2, 2, figsize=(12, 8), sharex=True, sharey='row')
    summary = []
    for i, mode in enumerate(('qk', 'pipeline')):
        for j, order in enumerate(('hsd', 'shd')):
            ax = axes[i,j]
            for pad in pads:
                for layout in ('SHD', 'SHD_PAD'):
                    sizes = sorted(k[4] for k in groups if k[:4] == (mode, order, pad, layout))
                    medians = []
                    for s in sizes:
                        vals = groups[mode, order, pad, layout, s]
                        median = st.median(vals); medians.append(median)
                        summary.append(dict(mode=mode, loop_order=order, comparison_padding_bytes=pad,
                            layout=layout, S=s, n_runs=len(vals), median_us_per_token=median,
                            min_us_per_token=min(vals), max_us_per_token=max(vals)))
                        ax.scatter([s]*len(vals), vals, color=colors[pad],
                                   marker='o' if layout=='SHD_PAD' else 'x', s=18, alpha=.5)
                    ax.plot(sizes, medians, color=colors[pad],
                        linestyle='-' if layout=='SHD_PAD' else '--',
                        label=f'{pad} B' if layout=='SHD_PAD' else f'0 B control for {pad} B')
            ax.set_title(f'{mode} | {" → ".join(order)}')
            ax.set_xscale('log', base=2)
            sizes = sorted({int(r['S']) for r in rows})
            ax.set_xticks(sizes, [str(s) for s in sizes], rotation=45)
            ax.set_ylim(bottom=0)
            ax.grid(alpha=.2)
            if j==0: ax.set_ylabel('Time / S (µs per token, all 8 heads)')
            if i==1: ax.set_xlabel('Sequence length S')
    handles, labels = axes[0,0].get_legend_handles_labels()
    fig.legend(handles, labels, loc='upper center', bbox_to_anchor=(.5,.95), ncol=3, fontsize=9)
    fig.suptitle('Normalized processing cost | H=8, D=128, score layout HS')
    fig.text(.5,.015,'Points: run medians / S. Lines: medians across runs. Dashed controls retain their original experiment pairing.',ha='center',fontsize=9)
    fig.tight_layout(rect=(0,.05,1,.85))
    for ext in ('png','svg'): fig.savefig(a.out/f'normalized_cost.{ext}',dpi=180)
    plt.close(fig)
    with (a.out/'normalized_summary.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(summary[0]));w.writeheader();w.writerows(summary)
    for r in summary:
        if r['loop_order']=='hsd' and r['layout']=='SHD_PAD':
            print(r['mode'],r['comparison_padding_bytes'],r['S'],round(r['median_us_per_token'],4))
    print(f'Outputs: {a.out.resolve()}')


if __name__=='__main__':
    main()
