"""검증 도구 — 05장, 11장에서 만든 것"""
import numpy as np


def verify_gradient(loss_fn, grad_fn, params, h=1e-5, tol=1e-4, verbose=True):
    """수치 미분으로 그래디언트 구현이 맞는지 확인 (05장 5절)"""
    analytic = np.asarray(grad_fn(params), dtype=float)
    numeric = np.zeros_like(analytic)
    params = np.asarray(params, dtype=float)

    for i in range(len(params)):
        p_plus = params.copy();  p_plus[i] += h
        p_minus = params.copy(); p_minus[i] -= h
        numeric[i] = (loss_fn(p_plus) - loss_fn(p_minus)) / (2 * h)

    diff = np.abs(analytic - numeric).max()
    passed = diff < tol

    if verbose:
        print(f"  수식 유도 : {analytic.round(6)}")
        print(f"  수치 미분 : {numeric.round(6)}")
        print(f"  최대 차이 : {diff:.2e}  -> {'통과' if passed else '실패'}")
    return passed


def verify_against_book(actual, expected, label, tol=1e-3, verbose=True):
    """이론편 손계산 값과 대조 (05장 5절)"""
    actual = np.atleast_1d(np.asarray(actual, dtype=float))
    expected = np.atleast_1d(np.asarray(expected, dtype=float))
    passed = np.allclose(actual, expected, atol=tol)

    if verbose:
        mark = "통과" if passed else "실패"
        print(f"  [{mark}] {label}")
        print(f"         계산값 {actual.round(4)}  /  이론편 값 {expected.round(4)}")
    return passed


def softmax(x, axis=-1):
    """수치적으로 안정된 소프트맥스 (20장 4절)"""
    x_shifted = x - x.max(axis=axis, keepdims=True)
    e = np.exp(x_shifted)
    return e / e.sum(axis=axis, keepdims=True)


def cosine_similarity(a, b):
    """코사인 유사도 (27장 2절)"""
    return float(np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b)))
