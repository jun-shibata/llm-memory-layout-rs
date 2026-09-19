"""Build and run fixed-head KV layout experiments. Python standard library only."""
import argparse
import csv
import datetime
import io
import itertools
import json
import os
from pathlib import Path
import platform
import shlex
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

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--s', nargs='+', type=int, default=[128, 1024, 8192, 32768])
    p.add_argument('--h', nargs='+', type=int, default=[1, 8, 32])
    p.add_argument('--d', nargs='+', type=int, default=[64, 128])
    p.add_argument('--trials', type=int, default=10)
    p.add_argument('--target-ms', type=int, default=20)
    p.add_argument('--seed', type=int, default=0)
    p.add_argument('--cxx', default=os.environ.get('CXX', 'clang++'))
    p.add_argument('--flags', default='-std=c++17 -O3 -march=native')
    p.add_argument('--out', type=Path, default=ROOT/'results'/datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f'))
    a = p.parse_args()
    if min(a.s+a.h+a.d+[a.trials, a.target_ms]) <= 0 or not 0 <= a.seed <= 2**32-1:
        p.error('Shapes, trials and target-ms must be positive; seed must be uint32.')
    a.out = a.out.resolve()
    a.out.mkdir(parents=True, exist_ok=False)
    executable = a.out/'benchmark'
    command = [a.cxx, *shlex.split(a.flags), str(ROOT/'src/kv_layout/benchmark.cpp'), '-o', str(executable)]
    metadata = {'status': 'running', 'started_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
                'platform': platform.platform(), 'machine': platform.machine(), 'processor': platform.processor(),
                'python': sys.version, 'compiler': capture([a.cxx, '--version']), 'build_command': command,
                'arguments': {k: str(v) if isinstance(v, Path) else v for k,v in vars(a).items()},
                'threads': 1, 'cache_mode': 'repeated_buffer', 'atol': 1e-4, 'rtol': 1e-4,
                'timing_scope': 'qK dot only; excludes allocation, packing and validation', 'commands': []}
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
    try:
        subprocess.run(command, check=True)
        with (a.out/'raw.csv').open('w', newline='') as f:
            writer = None
            for s,h,d in itertools.product(a.s,a.h,a.d):
                cmd = [str(executable), *map(str,[s,h,d,h//2,a.trials,a.target_ms,a.seed])]
                print(f'S={s} H={h} D={d}', flush=True)
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
    print(a.out/'raw.csv')

if __name__ == '__main__':
    main()