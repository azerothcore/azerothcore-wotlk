"""Pixel <-> world coordinate calibration (pure, no Qt)."""

from .affine import Affine, CalibrationError, ReferencePoint

__all__ = ["Affine", "CalibrationError", "ReferencePoint"]
