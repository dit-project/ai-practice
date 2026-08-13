"""재현성을 위한 시드 고정 (1권 11.6절 참조)"""
import os
import random
import numpy as np


def set_seed(seed=42, deterministic=False):
    """무작위성이 개입하는 모든 곳의 시드를 고정한다.

    1권 11.6절에서 다룬 세 곳을 모두 다룬다.
      1) 가중치 초기화
      2) 데이터 셔플
      3) 샘플링

    deterministic=True 로 하면 GPU 연산 순서까지 고정하지만 느려진다.
    """
    random.seed(seed)
    np.random.seed(seed)
    os.environ["PYTHONHASHSEED"] = str(seed)

    try:
        import torch
        torch.manual_seed(seed)
        if torch.cuda.is_available():
            torch.cuda.manual_seed_all(seed)
        if deterministic:
            torch.backends.cudnn.deterministic = True
            torch.backends.cudnn.benchmark = False
    except ImportError:
        pass

    return seed
