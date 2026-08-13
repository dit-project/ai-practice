# 실습으로 배우는 인공지능

**『이론으로 배우는 인공지능』(1권)의 실습 편**

실습 44개 · 코드셀 702개 · 그래프 146개 · **전량 실행 검증 완료**

---

## 빠른 시작

```bash
# 1) 저장소 받기
git clone https://github.com/dit-project/ai-practice.git
cd ai-practice

# 2) 환경 자동 설치 (가상환경 생성 → 활성화 → 재실행)
bash setup.sh

# 3) API 키 입력 (25장 이후 실습용, 선택)
cp .env.example .env

# 4) 환경 점검
jupyter notebook setup_check.ipynb
```

> Git 을 쓰지 않는다면 **Code** → **Download ZIP** 으로 받아도 된다.
> 이후 갱신 내용은 `git pull` 로 받을 수 있다.

> **Windows**: Git Bash 또는 WSL 에서 `setup.sh` 를 실행하세요.
> PowerShell 을 쓴다면 원고 1장의 수동 절차를 따르면 됩니다.

**설치가 끝나면 `setup_check.ipynb` 를 먼저 실행**하세요.
Python·패키지·GPU·한글 폰트를 한 번에 점검하고, 문제가 있으면 해결 방법을 알려줍니다.

---

## 실행 환경

| 항목 | 값 |
|---|---|
| 운영체제 | Windows 11 (Linux·macOS 도 동일하게 동작) |
| Python | 3.10 이상 (3.13·3.14 동작 확인) |
| PyTorch | 2.x (CUDA 버전은 공식 사이트에서 생성) |
| GPU | 8GB VRAM 기준 (**없어도 1~41장 실행 가능**) |
| 편집기 | VS Code |

**GPU가 없어도 대부분의 실습이 가능합니다.** 각 장의 모델 크기와 학습량을
CPU에서 몇 분 안에 끝나도록 조정했습니다.

---

## 저장소 구조

```
ai-practice/
├── setup.sh              환경 자동 설치
├── setup_check.ipynb     환경 점검 (실습 전 실행)
├── requirements.txt      패키지 목록
├── .env.example          API 키 양식
├── part1/  01~06장       환경과 기초 도구
├── part2/  07~11장       머신러닝과 신경망
├── part3/  12~15장       딥러닝 학습 기법
├── part4/  16~19장       딥러닝 아키텍처
├── part5/  20~25장       Transformer와 LLM
├── part6/  26~33장       검색·RAG·파인튜닝
├── part7/  34~41장       정렬·Agent·운영
├── part8/  42~44장       종합 프로젝트
├── utils/                공통 함수 (42장에서 생성)
├── data/                 데이터셋 저장 위치
└── manuscript/           인쇄용 원고
```

---

## 전체 목차

### 제1부 — 환경과 기초 도구 (1~6장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 1 | `01_setup_environment` | — | 설치·검증, 사양별 가능 범위 |
| 2 | `02_numpy_basics` | 4장 | 1권 손계산 5개 검증 |
| 3 | `03_matplotlib_visualization` | 4~5장 | PCA 97.67%, 경사하강 6스텝 |
| 4 | `04_linear_regression_numpy` | 8장 | **일부러 발산시켜 표준화 체득** |
| 5 | `05_claude_code_vibe_coding` | — | AI 코드 검증 도구 |
| 6 | `06_data_preprocessing` | 8.1·8.5절 | **데이터 누수 6유형** |

### 제2부 — 머신러닝과 신경망 (7~11장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 7 | `07_sklearn_supervised` | 8~9장 | 정확도 0.970 / 무의미 분류기 0.910 |
| 8 | `08_sklearn_unsupervised_eval` | 9장 | K-Means 직접구현 = sklearn |
| 9 | `09_tree_ensemble` | 9.4~9.5절 | **지니 0.32, 앙상블의 조건** |
| 10 | `10_perceptron_mlp_numpy` | 10장 | **XOR 실패 재현 → 해결** |
| 11 | `11_backprop_numpy` ★ | 10.4절 | **17개 항목 3중 검증** |

### 제3부 — 딥러닝 학습 기법 (12~15장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 12 | `12_pytorch_basics` | 10~11장 | autograd = 손계산 일치 |
| 13 | `13_optimizers` | 11.1절 | **Adam 편향보정 손계산** |
| 14 | `14_regularization` | 11.3·11.6절 | **BatchNorm ±1.3416** |
| 15 | `15_cnn_practice` | 12장 | 합성곱 (0, −210) |

### 제4부 — 딥러닝 아키텍처 (16~19장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 16 | `16_rnn_lstm_practice` | 13장 | LSTM c=0.924, h=0.462 |
| 17 | `17_reinforcement_learning` | 14장 | Q값 0→5.0→2.25 |
| 18 | `18_autoencoder_vae` | 15장 | 재파라미터화 4개 값 |
| 19 | `19_gan_diffusion` | 16장 | 노이즈 누적표 검증 |

### 제5부 — Transformer와 LLM (20~25장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 20 | `20_attention_from_scratch` ★ | 17·18.3절 | **α=(0.401, 0.198, 0.401)** |
| 21 | `21_transformer_encoder` | 18장 | PE·Residual·LayerNorm 실험 |
| 22 | `22_transformer_decoder` | 18장 | 마스킹, 전체 모델 학습 |
| 23 | `23_huggingface_basics` | 19~20장 | GPT-2 내부 = 우리 구현 |
| 24 | `24_generation_and_chatml` | 20장 | 온도 0.972/0.782/0.526 |
| 25 | `25_llm_api` | 20·22장 | API 키 발급, 비용 계산 |

### 제6부 — 검색·RAG·파인튜닝 (26~33장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 26 | `26_tokenizer_training` | 20.2절 | **BPE 직접 구현, 한국어 78% 절감** |
| 27 | `27_embedding_search` | 20~21장 | 코사인 0.995/0.070 |
| 28 | `28_rag_pipeline` | 21장 | 검색 실패의 영향 실험 |
| 29 | `29_advanced_rag` | 21.4절 | **재순위화 MRR +0.225** |
| 30 | `30_transfer_learning` | 12.5절 | **0.05% 파라미터로 학습** |
| 31 | `31_sft_practice` | 22장 | 손실 마스킹 구현 |
| 32 | `32_lora_qlora` ★ | 22장 | **0.39%, 555배 절감** |
| 33 | `33_quantization` | 22.5절 | **8비트 +2.4% / 6비트 +1295%** |

### 제7부 — 정렬·Agent·운영 (34~41장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 34 | `34_dpo_alignment` ★ | 23장 | **DPO 손실 0.644** |
| 35 | `35_reasoning_cot` | 23.6절 | CoT 원리, Self-Consistency |
| 36 | `36_multimodal_clip` | 24장 | CLIP, 영상 토큰 94,080 |
| 37 | `37_ai_agent` | 25장 | 도구 호출·ReAct·안전장치 |
| 38 | `38_mcp_multiagent` | 25장 | JSON-RPC 직접 구현 |
| 39 | `39_evaluation` | 21.5·25.5절 | **LLM-as-Judge, 카파** |
| 40 | `40_deployment` | 25.5절 | **FastAPI·Docker 실제 구동** |
| 41 | `41_llm_serving` | 25.5절 | KV Cache·배치 실측 |

### 제8부 — 종합 프로젝트 (42~44장)

| # | 장 | 1권 대응 | 핵심 |
|---|---|---|---|
| 42 | `42_review` | 전체 | 복습 + `utils` 모듈 생성 |
| 43 | `43_project_doc_qa` | 20~23장 | **프로젝트 A — 문서 QA** |
| 44 | `44_project_analysis_agent` | 25장 | **프로젝트 B — 분석 Agent** |

> **42장을 먼저 실행**해야 합니다 (`utils` 모듈 생성).
> 43·44장은 서로 독립적이므로 관심 있는 쪽부터 해도 됩니다.

★ 1권과 2권을 잇는 핵심 장

---

## 장별 추가 설치

| 장 | 패키지 | 설치 명령 |
|---|---|---|
| 17 | gymnasium | `pip install gymnasium` |
| 23~ | transformers | `pip install transformers` |
| 25 | openai, python-dotenv | `pip install openai python-dotenv` |
| 27~ | sentence-transformers | `pip install sentence-transformers` |
| 28 | chromadb | `pip install chromadb` |
| 32 | peft | `pip install peft` |
| 36 | pillow | `pip install pillow` |
| 40 | fastapi, uvicorn | `pip install fastapi uvicorn` |

한 번에 설치하려면 `pip install -r requirements.txt`

---

## 다운로드하는 모델·데이터

| 장 | 이름 | 용량 | 방법 |
|---|---|---|---|
| 15, 18, 19 | FashionMNIST | 30MB | `torchvision` 자동 |
| 23, 24 | GPT-2 | 550MB | Hugging Face 자동 |
| 27~29 | 다국어 임베딩 | 470MB | Hugging Face 자동 |
| 29 | 재순위 모델 | 1.1GB | Hugging Face 자동 |
| 30 | ResNet-18 | 45MB | torchvision 자동 |
| 31~34 | DistilGPT-2 | 330MB | Hugging Face 자동 |
| 36 | CLIP | 600MB | Hugging Face 자동 |

**총 약 3GB.** 한 번 받으면 캐시에 저장되어 재사용됩니다.

---

## 1권과 대조할 수 있는 값들

1권의 "직접 계산해 보기"에서 손으로 구한 값을 이 책에서 코드로 확인합니다.
`assert` 문으로 자동 검증되므로, 값이 어긋나면 즉시 알 수 있습니다.

| 1권 절 | 값 | 이 책 |
|---|---|---|
| 4.2~4.4 | 행렬곱·고유값·SVD·PCA | 2·3장 |
| 8.2 | MSE = 0.18 | 4장 |
| 9.3 | 정확도 0.970 / 무의미 0.910 | 7장 |
| **9.4** | **지니 0 / 0.32 / 0.5** | **9장** |
| 10.3 | 시그모이드 도함수 0.25 | 10장 |
| **10.4** | **2-2-1 역전파 17개 항목** | **11장** ★ |
| **11.1** | **Adam 편향보정** | **13장** |
| **11.3** | **BatchNorm ±1.3416** | **14장** |
| 12.2 | 합성곱 (0, −210) | 15장 |
| 13.4 | LSTM c=0.924 | 16장 |
| 14.3 | Q값 0→5.0→2.25 | 17장 |
| 15.4 | 재파라미터화 4개 값 | 18장 |
| **18.3** | **Attention α=(0.401, 0.198, 0.401)** | **20장** ★ |
| **20.2** | **BPE (e+s 빈도 9 → est)** | **26장** |
| 20.5 | 온도별 확률 3개 | 24장 |
| 21.3 | 코사인 1.000/0.995/0.070 | 27장 |
| **22.4** | **LoRA 0.39% (256배)** | **32장** ★ |
| **22.5** | **양자화 [-127, -48, 0, 40, 111]** | **33장** |
| **23.3** | **DPO 손실 0.644** | **34장** ★ |
| 24.4 | 영상 토큰 94,080 | 36장 |

---

## 문제가 생기면

| 증상 | 해결 |
|---|---|
| `python` 명령을 찾을 수 없음 | PATH 미등록 — 원고 1장 참조 |
| `torch.cuda.is_available()` False | CPU 버전 설치됨 — 원고 1장 10절 |
| `ModuleNotFoundError` | `pip install -r requirements.txt` |
| VS Code 에서 import 실패 | 인터프리터를 venv 로 지정 |
| 그래프 한글이 네모 | 원고 3장 1절 폰트 설정 |
| `CUDA out of memory` | 배치 축소 — 원고 32장 9절 |

자세한 내용은 `setup_check.ipynb` 를 실행하거나 원고 1장을 참조하세요.
