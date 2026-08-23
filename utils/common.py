"""재현성 도구 — 15장 참조"""
import random
import numpy as np


def set_seed(seed=42, verbose=False):
    """모든 난수 생성기의 시드를 고정한다 (이론편 11.6절)"""
    random.seed(seed)
    np.random.seed(seed)

    try:
        import torch
        torch.manual_seed(seed)
        if torch.cuda.is_available():
            torch.cuda.manual_seed_all(seed)
    except ImportError:
        pass

    if verbose:
        print(f"시드 고정: {seed}")
    return seed


def get_device(verbose=True):
    """사용 가능한 장치를 돌려준다 (01장)"""
    try:
        import torch
        device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        if verbose:
            if device.type == "cuda":
                name = torch.cuda.get_device_name(0)
                mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
                print(f"장치: {device} ({name}, {mem:.1f}GB)")
            else:
                print(f"장치: {device}")
        return device
    except ImportError:
        if verbose:
            print("PyTorch 미설치 — CPU 로 진행")
        return "cpu"
