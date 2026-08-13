"""GPU 메모리 관련 도우미"""
import gc

try:
    import torch
    _HAS_TORCH = True
except ImportError:
    _HAS_TORCH = False


def gpu_status(tag=""):
    """현재 GPU 메모리 사용량을 출력한다."""
    if not _HAS_TORCH:
        print(f"{tag} PyTorch 미설치")
        return
    if not torch.cuda.is_available():
        print(f"{tag} GPU 없음")
        return
    alloc = torch.cuda.memory_allocated() / 1024**3
    reserved = torch.cuda.memory_reserved() / 1024**3
    total = torch.cuda.get_device_properties(0).total_memory / 1024**3
    print(f"{tag} 할당 {alloc:.2f}GB / 예약 {reserved:.2f}GB / 전체 {total:.1f}GB")


def gpu_clear():
    """사용하지 않는 GPU 메모리를 반환한다.

    모델 변수를 del 한 뒤 호출해야 효과가 있다.
    """
    gc.collect()
    if _HAS_TORCH and torch.cuda.is_available():
        torch.cuda.empty_cache()
        torch.cuda.reset_peak_memory_stats()


def gpu_peak():
    """이번 실행에서 최대로 쓴 GPU 메모리를 GB로 반환한다."""
    if not _HAS_TORCH or not torch.cuda.is_available():
        return 0.0
    return torch.cuda.max_memory_allocated() / 1024**3
