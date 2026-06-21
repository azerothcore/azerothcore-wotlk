import math

import pytest

from invasion_authoring.geometry import Affine, CalibrationError, ReferencePoint


def _approx(a, b, tol=1e-4):
    return math.isclose(a[0], b[0], abs_tol=tol) and math.isclose(a[1], b[1], abs_tol=tol)


def test_two_point_axis_aligned_round_trip():
    # Two reference points with independent x/y scale, no rotation.
    refs = [
        ReferencePoint(px=100.0, py=100.0, wx=0.0, wy=0.0),
        ReferencePoint(px=300.0, py=200.0, wx=-200.0, wy=400.0),
    ]
    aff = Affine.from_reference_points(refs)

    # Reference points map exactly.
    assert _approx(aff.pixel_to_world(100.0, 100.0), (0.0, 0.0))
    assert _approx(aff.pixel_to_world(300.0, 200.0), (-200.0, 400.0))

    # Inverse round-trips an arbitrary point.
    wx, wy = aff.pixel_to_world(220.0, 175.0)
    px, py = aff.world_to_pixel(wx, wy)
    assert _approx((px, py), (220.0, 175.0))


def test_three_point_full_affine_handles_rotation():
    # A 90-degree-rotation-ish mapping that two-point (axis-aligned) cannot represent.
    refs = [
        ReferencePoint(px=0.0, py=0.0, wx=0.0, wy=0.0),
        ReferencePoint(px=10.0, py=0.0, wx=0.0, wy=10.0),
        ReferencePoint(px=0.0, py=10.0, wx=-10.0, wy=0.0),
    ]
    aff = Affine.from_reference_points(refs)
    assert _approx(aff.pixel_to_world(10.0, 10.0), (-10.0, 10.0))
    # Round-trip.
    px, py = aff.world_to_pixel(*aff.pixel_to_world(5.0, 7.0))
    assert _approx((px, py), (5.0, 7.0))


def test_two_coincident_x_rejected():
    refs = [
        ReferencePoint(px=100.0, py=100.0, wx=0.0, wy=0.0),
        ReferencePoint(px=100.0, py=200.0, wx=10.0, wy=20.0),
    ]
    with pytest.raises(CalibrationError):
        Affine.from_reference_points(refs)


def test_collinear_three_points_rejected():
    refs = [
        ReferencePoint(px=0.0, py=0.0, wx=0.0, wy=0.0),
        ReferencePoint(px=1.0, py=1.0, wx=1.0, wy=1.0),
        ReferencePoint(px=2.0, py=2.0, wx=2.0, wy=2.0),
    ]
    with pytest.raises(CalibrationError):
        Affine.from_reference_points(refs)


def test_requires_at_least_two_points():
    with pytest.raises(CalibrationError):
        Affine.from_reference_points([ReferencePoint(px=0.0, py=0.0, wx=0.0, wy=0.0)])


def test_serialization_round_trip():
    refs = [
        ReferencePoint(px=100.0, py=100.0, wx=0.0, wy=0.0),
        ReferencePoint(px=300.0, py=200.0, wx=-200.0, wy=400.0),
    ]
    aff = Affine.from_reference_points(refs)
    restored = Affine.from_coeffs(aff.coeffs)
    assert _approx(restored.pixel_to_world(220.0, 175.0), aff.pixel_to_world(220.0, 175.0))
