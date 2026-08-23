"""한글 폰트 설정 — 03장에서 만든 것"""
import platform


def setup_korean_font(verbose=False):
    """matplotlib 한글 폰트를 설정한다 (03장 1절)"""
    import matplotlib.pyplot as plt
    import matplotlib.font_manager as fm

    candidates = {
        "Windows": ["Malgun Gothic", "NanumGothic", "Gulim"],
        "Darwin":  ["AppleGothic", "NanumGothic"],
        "Linux":   ["NanumGothic", "Noto Sans CJK KR", "Noto Sans CJK JP"],
    }

    available = {f.name for f in fm.fontManager.ttflist}
    chosen = None
    for name in candidates.get(platform.system(), []):
        if name in available:
            chosen = name
            break

    if chosen:
        plt.rcParams["font.family"] = chosen
        plt.rcParams["axes.unicode_minus"] = False
        if verbose:
            print(f"한글 폰트: {chosen}")
    elif verbose:
        print("한글 폰트를 찾지 못했습니다. 그래프 라벨이 깨질 수 있습니다.")

    return chosen
