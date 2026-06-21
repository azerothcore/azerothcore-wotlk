"""Affine calibration between canvas pixels and WoW world (X/Y) coordinates.

Pure module (no Qt / no DB). The forward transform maps image pixels to world coords::

    wx = a*px + b*py + c
    wy = d*px + e*py + f

Two reference points yield an axis-aligned mapping (independent x/y scale, no rotation); three
yield a full affine (rotation / flip / shear). Both directions are exact inverses, verified by
round-trip tests.
"""

from __future__ import annotations

from dataclasses import dataclass

# Affine forward coefficients: (a, b, c, d, e, f).
Coeffs = tuple[float, float, float, float, float, float]

_EPS = 1e-9


class CalibrationError(ValueError):
    """Raised when reference points are insufficient or degenerate."""


@dataclass(frozen=True)
class ReferencePoint:
    """A correspondence between an image pixel and a world coordinate."""

    px: float
    py: float
    wx: float
    wy: float


@dataclass(frozen=True)
class Affine:
    """An affine pixel->world transform with its analytic inverse."""

    coeffs: Coeffs

    @classmethod
    def from_coeffs(cls, coeffs: Coeffs) -> Affine:
        return cls(tuple(float(c) for c in coeffs))  # type: ignore[arg-type]

    @classmethod
    def from_reference_points(cls, refs: list[ReferencePoint]) -> Affine:
        if len(refs) < 2:
            raise CalibrationError("at least two reference points are required")
        if len(refs) == 2:
            return cls._from_two(refs[0], refs[1])
        return cls._from_three(refs[0], refs[1], refs[2])

    @classmethod
    def _from_two(cls, p: ReferencePoint, q: ReferencePoint) -> Affine:
        dpx = p.px - q.px
        dpy = p.py - q.py
        if abs(dpx) < _EPS or abs(dpy) < _EPS:
            raise CalibrationError("two-point calibration needs distinct x and y pixel values")
        ax = (p.wx - q.wx) / dpx
        ay = (p.wy - q.wy) / dpy
        cx = p.wx - ax * p.px
        cy = p.wy - ay * p.py
        return cls((ax, 0.0, cx, 0.0, ay, cy))

    @classmethod
    def _from_three(cls, p: ReferencePoint, q: ReferencePoint, r: ReferencePoint) -> Affine:
        # Solve [px py 1] * [a;b;c] = wx and the same for wy.
        m = [
            [p.px, p.py, 1.0],
            [q.px, q.py, 1.0],
            [r.px, r.py, 1.0],
        ]
        det = _det3(m)
        if abs(det) < _EPS:
            raise CalibrationError("three reference points must not be collinear")
        a, b, c = _solve3(m, [p.wx, q.wx, r.wx], det)
        d, e, f = _solve3(m, [p.wy, q.wy, r.wy], det)
        return cls((a, b, c, d, e, f))

    def pixel_to_world(self, px: float, py: float) -> tuple[float, float]:
        a, b, c, d, e, f = self.coeffs
        return (a * px + b * py + c, d * px + e * py + f)

    def world_to_pixel(self, wx: float, wy: float) -> tuple[float, float]:
        a, b, c, d, e, f = self.coeffs
        det = a * e - b * d
        if abs(det) < _EPS:
            raise CalibrationError("degenerate transform cannot be inverted")
        # Invert the 2x2 linear part, then back out the translation.
        ia = e / det
        ib = -b / det
        ic = -d / det
        idd = a / det
        tx = wx - c
        ty = wy - f
        return (ia * tx + ib * ty, ic * tx + idd * ty)


def _det3(m: list[list[float]]) -> float:
    return (
        m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
        - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
        + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
    )


def _solve3(m: list[list[float]], rhs: list[float], det: float) -> tuple[float, float, float]:
    # Cramer's rule.
    cols = []
    for i in range(3):
        mi = [row[:] for row in m]
        for r in range(3):
            mi[r][i] = rhs[r]
        cols.append(_det3(mi) / det)
    return (cols[0], cols[1], cols[2])
