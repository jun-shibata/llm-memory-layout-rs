"""Generate, compile and benchmark six qK or twelve qK+softmax schedules."""
import argparse
import csv
from dataclasses import asdict
import datetime
import hashlib
import io
import itertools
import json
from pathlib import Path
import platform
import random
import shlex
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from layout_lab.spec import QKProblem, Schedule
from layout_lab.codegen import generate_cpp

def capture(cmd):
    r=subprocess.run(cmd,text=True,capture_output=True)
    if r.returncode:
        raise RuntimeError(f'{shlex.join(cmd)}\n{r.stderr}')
    return r.stdout

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--s',type=int,default=128)
    p.add_argument('--h',type=int,default=8)
    p.add_argument('--d',type=int,default=128)
    p.add_argument('--stage',choices=['qk','qk-softmax'],default='qk')
    p.add_argument('--trials',type=int,default=10)
    p.add_argument('--target-ms',type=int,default=20)
    p.add_argument('--seed',type=int,default=0)
    p.add_argument('--order-seed',type=int,default=0)
    p.add_argument('--padding-bytes',type=int,default=128)
    p.add_argument('--cxx',default='clang++')
    p.add_argument('--flags',default='-std=c++17 -O3 -march=native')
    p.add_argument('--out',required=True,type=Path)
    a=p.parse_args()
    problem=QKProblem(a.s,a.h,a.d,softmax=a.stage=='qk-softmax')
    try:
        problem.validate()
        if min(a.trials,a.target_ms)<=0 or not 0<=a.seed<=2**32-1:
            raise ValueError('trials/target-ms must be positive; seed must be uint32')
        schedules=[Schedule(k,o,z,a.padding_bytes if k=='SHD_PAD' else 0)
                   for k,o,z in itertools.product(['SHD','HSD','SHD_PAD'],['hsd','shd'],['HS','SH'] if problem.softmax else ['HS'])]
        for s in schedules:s.validate()
    except ValueError as e:p.error(str(e))
    flags=shlex.split(a.flags)
    if any(f.startswith(('-Ofast','-ffast-math','-funsafe-math','-ffinite-math','-fassociative-math','-ffp-model=fast')) for f in flags):
        p.error('Relaxed FP flags are unsupported: validation shares the translation unit')
    out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    generated=out/'generated';generated.mkdir()
    meta={'status':'running','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),
          'platform':platform.platform(),'compiler':capture([a.cxx,'--version']),
          'arguments':{k:str(v) if isinstance(v,Path) else v for k,v in vars(a).items()},
          'problem':asdict(problem),'commands':[], 'source_hashes':{},
          'timing':'one candidate per process; repeated buffers; stage timings are diagnostic, pipeline timed directly',
          'softmax_input':'original scores restored outside every timed softmax-only call; copy warms input'}
    def save(): (out/'metadata.json').write_text(json.dumps(meta,indent=2)+'\n')
    save()
    try:
        for schedule in schedules:
            source=generate_cpp(problem,schedule,generated/(schedule.name+'.cpp'))
            meta['source_hashes'][source.name]=hashlib.sha256(source.read_bytes()).hexdigest()
            cmd=[a.cxx,*flags,str(source),'-o',str(generated/schedule.name)]
            meta['commands'].append(cmd);capture(cmd)
        jobs=list(itertools.product(schedules,['qk','softmax','pipeline'] if problem.softmax else ['qk']))
        random.Random(a.order_seed).shuffle(jobs)
        with (out/'raw.csv').open('w',newline='') as f:
            writer=None
            for schedule,mode in jobs:
                print(schedule.name,mode,flush=True)
                cmd=[str(generated/schedule.name),*map(str,[a.s,a.h,a.d,a.trials,a.target_ms,a.seed]),mode]
                meta['commands'].append(cmd);save()
                rows=list(csv.DictReader(io.StringIO(capture(cmd))))
                if len(rows)!=a.trials:raise RuntimeError('Unexpected number of measurements')
                if writer is None:
                    writer=csv.DictWriter(f,fieldnames=list(rows[0]));writer.writeheader()
                writer.writerows(rows);f.flush()
        meta['status']='complete'
    except Exception as e:
        meta.update(status='failed',error=str(e));raise
    finally:save()
    print(out/'raw.csv')

if __name__=='__main__':
    main()
