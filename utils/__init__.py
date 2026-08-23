"""2권 실습 공통 유틸리티

사용법:
    import sys
    sys.path.insert(0, str(프로젝트_루트))
    from utils import set_seed, get_device, setup_korean_font
"""
from .verify import (verify_gradient, verify_against_book,
                     softmax, cosine_similarity)
from .common import set_seed, get_device
from .viz import setup_korean_font

__all__ = [
    "verify_gradient", "verify_against_book", "softmax", "cosine_similarity",
    "set_seed", "get_device", "setup_korean_font",
]
