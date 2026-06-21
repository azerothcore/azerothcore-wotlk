import re

import pytest

from invasion_authoring.guid import GuidAllocator
from invasion_authoring.model import (
    EventDef,
    EventType,
    Formation,
    Invasion,
    Path,
    Project,
    Spawn,
    Waypoint,
)
from invasion_authoring.sql import emit_sql


def _project() -> Project:
    path = Path(
        local_id=1,
        name="wave",
        waypoints=[
            Waypoint(x=-100.0, y=200.0, z=10.0, orientation=1.5),
            Waypoint(x=-120.0, y=240.0, z=11.0, delay_ms=2000, move_type=1),
        ],
    )
    spawns = [
        Spawn(local_id=1, template_id=299, x=-100.0, y=200.0, z=10.0, movement_type=2, path_local_id=1),
        Spawn(local_id=2, template_id=299, x=-101.0, y=201.0, z=10.0, movement_type=2, path_local_id=1),
        Spawn(local_id=3, template_id=11502, x=-90.0, y=190.0, z=10.0, is_boss=True, movement_type=0),
    ]
    inv = Invasion(
        name="Elwynn Invasion",
        event=EventDef(zone_id=12, event_type=EventType.INVASION, goal=150, active_seconds=1800, cooldown_seconds=3600),
        map_id=0,
        spawns=spawns,
        paths=[path],
        formations=[Formation(name="pack", leader_local_id=1, member_local_ids=[2], follow_dist=2.0)],
    )
    return Project(name="demo", guid_base=90_000_000, invasions=[inv])


def _lint_basics(text: str) -> None:
    lines = text.split("\n")
    assert text.endswith("\n"), "file must end with a newline"
    assert not text.endswith("\n\n"), "no trailing blank line"
    assert "\t" not in text, "no tabs"
    assert ";;" not in text, "no double semicolons"
    for ln in lines:
        assert ln == ln.rstrip(" "), f"trailing whitespace: {ln!r}"
    # No two consecutive blank lines.
    assert "\n\n\n" not in text
    # Every INSERT is immediately preceded by a line containing DELETE (comments skipped).
    prev = ""
    for ln in lines:
        if ln.strip().startswith("--"):
            continue
        if "INSERT" in ln:
            assert "DELETE" in prev, f"INSERT without preceding DELETE: prev={prev!r}"
        prev = ln


def test_emits_create_table_innodb():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "CREATE TABLE IF NOT EXISTS `branding_event_spawn`" in sql
    assert re.search(r"ENGINE\s*=\s*InnoDB", sql)


def test_passes_codestyle_basics():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    _lint_basics(sql)


def test_event_def_row():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "DELETE FROM `branding_event_def` WHERE `zone_id` = 12 AND `event_type` = 0;" in sql
    assert "(12, 0, 150, 1800, 3600);" in sql


def test_creature_rows_use_allocated_guids():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "INSERT INTO `creature`" in sql
    # Three spawns -> guids 90000000..90000002.
    assert "DELETE FROM `creature` WHERE `guid` IN (90000000, 90000001, 90000002);" in sql
    assert sql.count("\n(90000000, 299, 0, 12,") == 1


def test_waypoint_data_emitted_for_path():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "INSERT INTO `waypoint_data`" in sql
    # Two waypoints, points 1 and 2 of the path.
    assert re.search(r"INSERT INTO `waypoint_data`.*VALUES", sql, re.DOTALL)


def test_creature_addon_links_pathfollowers_only():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "INSERT INTO `creature_addon`" in sql
    # Two path-followers (local 1,2) get addon rows; the boss (local 3) does not.
    addon_block = sql.split("INSERT INTO `creature_addon`")[1].split(";")[0]
    assert addon_block.count("\n(") == 2


def test_creature_formations_leader_and_members():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "INSERT INTO `creature_formations`" in sql


def test_spawn_group_is_manual_and_holds_all_members():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    # Manual-spawn group template (flag 4) so creatures never auto-spawn on grid load.
    assert "INSERT INTO `spawn_group_template`" in sql
    template_block = sql.split("INSERT INTO `spawn_group_template`")[1].split(";")[0]
    assert template_block.rstrip().endswith(", 4)")
    # Membership: one spawn_group row per creature (3), spawnType 0 (creature).
    members = sql.split("INSERT INTO `spawn_group`")[1].split(";")[0]
    assert members.count("\n(") == 3
    assert ", 0, 90000000)" in members


def test_branding_event_spawn_maps_event_to_group_and_map():
    sql = emit_sql(_project(), GuidAllocator(base=90_000_000))
    assert "DELETE FROM `branding_event_spawn` WHERE `zone_id` = 12 AND `event_type` = 0;" in sql
    block = sql.split("INSERT INTO `branding_event_spawn`")[1]
    # Exactly one mapping row: (zone, type, group_id, map_id). group_id is allocated after the
    # 3 guids (90000000-02) and 1 path id (90000003) -> 90000004; map_id 0.
    assert block.split(";")[0].count("\n(") == 1
    assert "(12, 0, 90000004, 0);" in sql


def test_boss_only_invasion_skips_path_tables():
    inv = Invasion(
        name="Boss",
        event=EventDef(zone_id=1519, event_type=EventType.ELITE_HUNT),
        spawns=[Spawn(local_id=1, template_id=39, x=1.0, y=2.0, z=3.0, is_boss=True)],
    )
    sql = emit_sql(Project(name="p", invasions=[inv]), GuidAllocator(base=90_000_000))
    assert "INSERT INTO `waypoint_data`" not in sql
    assert "INSERT INTO `creature_addon`" not in sql
    assert "INSERT INTO `creature_formations`" not in sql
    _lint_basics(sql)


def test_float_coordinates_round_trip_cleanly():
    inv = Invasion(
        name="Coords",
        event=EventDef(zone_id=1, event_type=EventType.INVASION),
        spawns=[Spawn(local_id=1, template_id=1, x=-8949.95, y=-132.493, z=83.5312, orientation=0.66)],
    )
    sql = emit_sql(Project(name="p", invasions=[inv]), GuidAllocator(base=90_000_000))
    assert "-8949.95" in sql
    assert "1e" not in sql.lower()  # no scientific notation


def test_empty_project_raises():
    with pytest.raises(ValueError):
        emit_sql(Project(name="empty", invasions=[]), GuidAllocator(base=90_000_000))
