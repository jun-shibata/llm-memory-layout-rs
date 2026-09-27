"""Generate one C++ benchmark from a shared computation definition."""
from pathlib import Path
from .spec import QKProblem, Schedule

def generate_cpp(problem: QKProblem, schedule: Schedule, output):
    problem.validate()
    schedule.validate()
    address = {
        'SHD': '(s*H+h)*D+d',
        'HSD': '(h*S+s)*D+d',
        'SHD_PAD': 's*(H*D+PAD)+h*D+d',
    }[schedule.k_layout]
    loops = ('for(size_t h = 0; h < H; ++h) for(size_t s = 0; s < S; ++s)'
             if schedule.loop_order == 'hsd' else
             'for(size_t s = 0; s < S; ++s) for(size_t h = 0; h < H; ++h)')
    source = Path(__file__).with_name('templates').joinpath('benchmark.cpp').read_text()
    replacements = {
        'K_INDEX': address, 'SCORE_INDEX': 'h*S+s' if schedule.score_layout == 'HS' else 's*H+h',
        'LOOPS': loops, 'PADDING': str(schedule.padding_bytes//4),
        'SOFTMAX': 'true' if problem.softmax else 'false', 'NAME': schedule.name,
    }

    for key, value in replacements.items():
        source = source.replace('@'+key+'@', value)
    output = Path(output)
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(source)
    return output