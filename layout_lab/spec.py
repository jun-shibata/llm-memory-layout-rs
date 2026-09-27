"""Declarative problems and schedule definitions for the minimal layout API."""
from dataclasses import dataclass

@dataclass(frozen=True)
class QKProblem:
    S: int
    H: int
    D: int
    dtype: str = 'float32'
    softmax: bool = False

    def validate(self):
        if any(type(x) is not int or x <= 0 for x in (self.S, self.H, self.D)):
            raise ValueError('S, H, D must be positive integers')
        if self.dtype != 'float32':
            raise ValueError('Only float32 is supported')

@dataclass(frozen=True)
class Schedule:
    k_layout: str = 'SHD'
    loop_order: str = 'hsd'
    score_layout: str = 'HS'
    padding_bytes: int = 0

    def validate(self):
        if self.k_layout not in ('SHD', 'HSD', 'SHD_PAD'):
            raise ValueError('Invalid K layout')
        if self.loop_order not in ('hsd', 'shd') or self.score_layout not in ('HS', 'SH'):
            raise ValueError('Invalid loop order or score layout')
        if type(self.padding_bytes) is not int or self.padding_bytes < 0 or self.padding_bytes % 4:
            raise ValueError('Padding must be a nonnegative multiple of 4 bytes')
        if (self.k_layout == 'SHD_PAD') != (self.padding_bytes > 0):
            raise ValueError('Positive padding is required only for SHD_PAD')
    
    @property
    def name(self):
        return f'{self.k_layout}_{self.loop_order}_{self.score_layout}_p{self.padding_bytes}'