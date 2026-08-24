#!/usr/bin/env bash
# ============================================================
# 『검산하는 인공지능』 환경 설치 스크립트
#
#   사용법:  bash setup.sh
#
#   하는 일:
#     1) Python 버전 확인
#     2) 가상환경 생성·활성화 안내
#     3) PyTorch 설치 (CUDA 여부 자동 판별)
#     4) 나머지 패키지 설치
#     5) 설치 결과 요약
#
#   주의: Windows 는 Git Bash 또는 WSL 에서 실행하세요.
#         PowerShell 을 쓴다면 원고 1장의 수동 절차를 따르세요.
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[정보]${NC} $1"; }
warn()  { echo -e "${YELLOW}[주의]${NC} $1"; }
error() { echo -e "${RED}[오류]${NC} $1"; }

echo "============================================================"
echo "  『검산하는 인공지능』 환경 설치"
echo "============================================================"
echo

# ---------- 1) Python 확인 ----------
info "1/5  Python 확인"

if command -v python3 &> /dev/null; then
    PY=python3
elif command -v python &> /dev/null; then
    PY=python
else
    error "Python 을 찾을 수 없습니다."
    echo "     https://www.python.org/downloads/windows/ 에서 3.13 을 설치하세요."
    echo "     설치 시 'Add python.exe to PATH' 를 반드시 체크하세요. (원고 1.4절)"
    exit 1
fi

PY_VER=$($PY -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
echo "     Python $PY_VER 감지"

MAJOR=$(echo "$PY_VER" | cut -d. -f1)
MINOR=$(echo "$PY_VER" | cut -d. -f2)

if [ "$MAJOR" -lt 3 ] || { [ "$MAJOR" -eq 3 ] && [ "$MINOR" -lt 10 ]; }; then
    error "Python 3.10 이상이 필요합니다. (권장 3.13)"
    exit 1
fi

if [ "$MINOR" -ge 14 ]; then
    warn "Python 3.14 이상입니다. 일부 패키지의 휠이 아직 없을 수 있습니다."
    warn "문제가 생기면 3.13 사용을 권합니다. (원고 1.4절)"
fi
echo

# ---------- 2) 가상환경 ----------
info "2/5  가상환경 확인"

if [ -n "$VIRTUAL_ENV" ]; then
    echo "     이미 활성화됨: $VIRTUAL_ENV"
else
    if [ ! -d "venv" ]; then
        echo "     가상환경을 만듭니다..."
        $PY -m venv venv
        echo "     생성 완료: ./venv"
    else
        echo "     기존 가상환경 발견: ./venv"
    fi

    warn "가상환경이 활성화되지 않았습니다. 아래를 실행한 뒤 이 스크립트를 다시 돌리세요."
    echo
    echo "     Windows (Git Bash) :  source venv/Scripts/activate"
    echo "     Windows (cmd)      :  venv\\Scripts\\activate"
    echo "     Linux / macOS      :  source venv/bin/activate"
    echo
    exit 0
fi
echo

# ---------- 3) PyTorch ----------
info "3/5  PyTorch 설치"

$PY -m pip install --upgrade pip --quiet

if $PY -c "import torch" 2>/dev/null; then
    TORCH_VER=$($PY -c "import torch; print(torch.__version__)")
    echo "     이미 설치됨: torch $TORCH_VER"

    if $PY -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>/dev/null; then
        echo "     CUDA 사용 가능"
    else
        warn "CUDA 를 쓸 수 없습니다."
        if echo "$TORCH_VER" | grep -q "cpu"; then
            warn "  CPU 전용 버전이 설치되어 있습니다."
            warn "  GPU 를 쓰려면 재설치하세요 (원고 1.10절 참조)."
        fi
    fi
else
    if command -v nvidia-smi &> /dev/null; then
        echo "     NVIDIA GPU 감지 — CUDA 버전을 설치합니다"
        echo "     (약 2.5GB, 몇 분 걸립니다)"
        $PY -m pip install torch torchvision torchaudio \
            --index-url https://download.pytorch.org/whl/cu128
    else
        warn "NVIDIA GPU 를 찾지 못했습니다 — CPU 버전을 설치합니다"
        echo "     이 책의 대부분(1~31장)은 CPU 로 실행 가능합니다."
        $PY -m pip install torch torchvision torchaudio \
            --index-url https://download.pytorch.org/whl/cpu
    fi
fi
echo

# ---------- 4) 나머지 패키지 ----------
info "4/5  나머지 패키지 설치"

if [ -f "requirements.txt" ]; then
    $PY -m pip install -r requirements.txt --quiet
    echo "     requirements.txt 설치 완료"
else
    error "requirements.txt 를 찾을 수 없습니다."
    echo "     저장소 루트에서 실행했는지 확인하세요."
    exit 1
fi
echo

# ---------- 5) .env ----------
info "5/5  설정 파일 확인"

if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
    echo "     .env 생성 완료 (.env.example 복사)"
    warn "API 키를 쓰려면 .env 를 열어 값을 채우세요. (21장 1절)"
elif [ -f ".env" ]; then
    echo "     .env 이미 존재"
fi

mkdir -p data/samples outputs
echo "     data/, outputs/ 폴더 준비 완료"
echo

# ---------- 요약 ----------
echo "============================================================"
info "설치 완료"
echo "============================================================"
echo
$PY - <<'PYEOF'
import importlib

packages = [
    ("numpy", "필수"), ("matplotlib", "필수"), ("sklearn", "필수"),
    ("torch", "필수"), ("torchvision", "11장~"),
    ("transformers", "19장~"), ("sentence_transformers", "22장~"),
    ("chromadb", "23장"), ("peft", "25장"),
    ("openai", "21장"), ("dotenv", "21장"), ("gymnasium", "13장"),
]

ok, missing = [], []
for name, where in packages:
    try:
        mod = importlib.import_module(name)
        ver = getattr(mod, "__version__", "?")
        ok.append((name, ver, where))
    except ImportError:
        missing.append((name, where))

print(f"  설치됨 {len(ok)}개 / 미설치 {len(missing)}개")
print()
for name, ver, where in ok:
    print(f"    [OK]   {name:<24}{ver:<14}{where}")
if missing:
    print()
    for name, where in missing:
        print(f"    [없음] {name:<24}{'':<14}{where}")

try:
    import torch
    print()
    print(f"  PyTorch  : {torch.__version__}")
    print(f"  CUDA     : {torch.cuda.is_available()}")
    if torch.cuda.is_available():
        print(f"  GPU      : {torch.cuda.get_device_name(0)}")
        mem = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print(f"  VRAM     : {mem:.1f} GB")
except ImportError:
    pass
PYEOF

echo
echo "============================================================"
echo "  다음 단계"
echo "============================================================"
echo
echo "  1) 환경 점검 노트북 실행"
echo "       jupyter notebook setup_check.ipynb"
echo "     (또는 VS Code 에서 setup_check.ipynb 열기)"
echo
echo "  2) 첫 실습 시작"
echo "       part1/01_setup_environment.ipynb"
echo
echo "  문제가 생기면 원고 1장 '자주 겪는 문제와 해결' 을 참조하세요."
echo
