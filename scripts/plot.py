"""Summarize raw.csv and plot medians with interquartile ranges. Requires matplotlib."""
import argparse
import csv
from collections import defaultdict
from pathlib import Path
import statistics

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('csv', type=Path)
    p.add_argument('--out', type=Path)
    a = p.parse_args()
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    out = a.out or a.csv.parent/'figures'
    out.mkdir(parents=True, exist_ok=True)
    groups = defaultdict(list)
    with a.csv.open(newline='') as f:
        for r in csv.DictReader(f):
            key = (int(r['H']), int(r['D']), int(r['head_start']), int(r['heads_processed']), int(r['S']), r['layout'])
            groups[key].append(float(r['ns_per_call'])/1000)
    if not groups: p.error('CSV contains no measurements')
    summary = {}
    with (out/'summary.csv').open('w', newline='') as f:
        w = csv.writer(f)
        w.writerow(['H','D','head_start','heads_processed','S','layout','samples','median_us','q1_us','q3_us'])
        for key, values in sorted(groups.items()):
            median = statistics.median(values)
            q1, _, q3 = statistics.quantiles(values, n=4, method='inclusive') if len(values)>1 else [median]*3
            summary[key] = (median,q1,q3)
            w.writerow([*key,len(values),median,q1,q3])
    for h,d,head,count in sorted({k[:4] for k in groups}):
        fig, ax = plt.subplots(figsize=(7,4.5))
        for layout in ['SHD','HSD','DSH']:
            series = sorted((k[4],v) for k,v in summary.items() if k[:4]==(h,d,head,count) and k[5]==layout)
            if not series: continue
            x=[s for s,_ in series]; y=[v[0] for _,v in series]
            ax.errorbar(x,y,yerr=[[v[0]-v[1] for _,v in series],[v[2]-v[0] for _,v in series]], marker='o',capsize=3,label=layout)
        ax.set(xscale='log', yscale='log', xlabel='Sequence length S', ylabel='Time per call (microseconds)',
               title=f'qK dot: H={h}, D={d}, head={head}, count={count}\nRepeated buffer; median and IQR')
        ax.grid(True,which='both',alpha=.2); ax.legend(); fig.tight_layout()
        fig.savefig(out/f'h{h}_d{d}_head{head}_count{count}.png',dpi=160)
        plt.close(fig)
    print(out)

if __name__ == '__main__':
    main()