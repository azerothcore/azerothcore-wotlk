import pytest

from invasion_authoring.geometry import ReferencePoint
from invasion_authoring.model import (
    Calibration,
    EventDef,
    EventType,
    Formation,
    Invasion,
    Path,
    Project,
    Spawn,
    Waypoint,
)


def _sample_project() -> Project:
    path = Path(
        local_id=1,
        name="north wave",
        waypoints=[
            Waypoint(x=-100.0, y=200.0, z=10.0, orientation=1.5, delay_ms=0, move_type=0),
            Waypoint(x=-120.0, y=240.0, z=11.0),
        ],
    )
    spawns = [
        Spawn(local_id=1, template_id=299, x=-100.0, y=200.0, z=10.0, movement_type=2, path_local_id=1),
        Spawn(local_id=2, template_id=299, x=-101.0, y=201.0, z=10.0, movement_type=2, path_local_id=1),
        Spawn(local_id=3, template_id=11502, x=-90.0, y=190.0, z=10.0, is_boss=True, movement_type=0),
    ]
    formation = Formation(name="pack", leader_local_id=1, member_local_ids=[2])
    calib = Calibration(
        image_path="elwynn.png",
        refs=[
            ReferencePoint(px=100.0, py=100.0, wx=0.0, wy=0.0),
            ReferencePoint(px=300.0, py=200.0, wx=-200.0, wy=400.0),
        ],
    )
    inv = Invasion(
        name="Elwynn Invasion",
        event=EventDef(zone_id=12, event_type=EventType.INVASION, goal=100),
        calibration=calib,
        spawns=spawns,
        paths=[path],
        formations=[formation],
    )
    return Project(name="demo", db_host="localhost", db_schema="acore_world", guid_base=90_000_000, invasions=[inv])


def test_json_round_trip_preserves_everything():
    proj = _sample_project()
    restored = Project.from_dict(proj.to_dict())
    assert restored == proj


def test_to_dict_includes_schema_version():
    d = _sample_project().to_dict()
    assert d["schema_version"] == Project.SCHEMA_VERSION


def test_event_type_serializes_as_int():
    d = _sample_project().to_dict()
    assert d["invasions"][0]["event"]["event_type"] == 0


def test_event_type_rejects_out_of_range():
    with pytest.raises(ValueError):
        EventDef(zone_id=12, event_type=9)


def test_calibration_builds_affine():
    proj = _sample_project()
    aff = proj.invasions[0].calibration.affine()
    wx, wy = aff.pixel_to_world(100.0, 100.0)
    assert abs(wx) < 1e-6 and abs(wy) < 1e-6


def test_calibration_optional():
    inv = Invasion(name="x", event=EventDef(zone_id=1, event_type=EventType.ELITE_HUNT))
    assert inv.calibration is None
    restored = Project.from_dict(
        Project(name="p", db_host="h", db_schema="s", guid_base=1, invasions=[inv]).to_dict()
    )
    assert restored.invasions[0].calibration is None
