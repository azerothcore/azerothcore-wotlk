"""Headless smoke test for the PySide6 GUI (offscreen). Skipped if PySide6 is not installed."""

import os

import pytest

pytest.importorskip("PySide6")
os.environ.setdefault("QT_QPA_PLATFORM", "offscreen")

from PySide6.QtCore import QPointF  # noqa: E402
from PySide6.QtWidgets import QApplication  # noqa: E402

from invasion_authoring.gui.canvas import MODE_PATH, MODE_SPAWN, MapCanvas  # noqa: E402
from invasion_authoring.gui.main_window import MainWindow  # noqa: E402
from invasion_authoring.model import Spawn  # noqa: E402
from invasion_authoring.sql import emit_sql  # noqa: E402


@pytest.fixture(scope="module")
def app():
    instance = QApplication.instance() or QApplication([])
    yield instance


def test_main_window_constructs(app):
    win = MainWindow()
    assert win._current_invasion() is not None
    win.close()


def test_place_spawn_and_waypoints_then_export(app):
    win = MainWindow()
    canvas: MapCanvas = win._canvas
    inv = win._current_invasion()
    inv.event.zone_id = 12

    canvas.set_mode(MODE_SPAWN)
    canvas.set_template(299)
    canvas._place_spawn(QPointF(10.0, 20.0))
    canvas._place_spawn(QPointF(15.0, 25.0))

    canvas.set_mode(MODE_PATH)
    canvas._place_waypoint(QPointF(10.0, 20.0))
    canvas._place_waypoint(QPointF(40.0, 60.0))

    assert len(inv.spawns) == 2
    assert len(inv.paths) == 1
    assert len(inv.paths[0].waypoints) == 2

    sql = emit_sql(win._project, win._build_allocator())
    assert "INSERT INTO `creature`" in sql
    assert "INSERT INTO `waypoint_data`" in sql
    win.close()


def test_add_and_remove_invasion(app):
    win = MainWindow()
    win._add_invasion()
    assert len(win._project.invasions) == 2
    win._remove_invasion()
    assert len(win._project.invasions) == 1
    win.close()


def test_tiers_panel_adds_and_edits_tiers(app):
    win = MainWindow()
    inv = win._current_invasion()
    tiers = win._tiers

    tiers._add_tier()  # first add -> base (min 0)
    tiers._add_tier()  # second -> reinforcement
    assert len(inv.tiers) == 2
    assert inv.tiers[0].min_participants == 0

    # Edit the second tier's threshold + goal via the panel fields.
    tiers._list.setCurrentRow(1)
    tiers._min.setValue(8)
    tiers._goal.setValue(250)
    assert inv.tiers[1].min_participants == 8
    assert inv.tiers[1].goal_contribution == 250
    win.close()


def test_removing_tier_fixes_up_spawn_indices(app):
    win = MainWindow()
    inv = win._current_invasion()
    tiers = win._tiers
    tiers._add_tier()
    tiers._add_tier()  # tiers: [0, 1]

    inv.spawns.append(Spawn(local_id=1, template_id=1, x=0.0, y=0.0, z=0.0, tier=1))
    tiers._list.setCurrentRow(0)
    tiers._remove_tier()  # removing tier 0 -> the spawn on tier 1 shifts down to 0

    assert len(inv.tiers) == 1
    assert inv.spawns[0].tier == 0
    win.close()


def test_spawn_tier_selector_assigns_tier(app):
    win = MainWindow()
    inv = win._current_invasion()
    win._tiers._add_tier()
    win._tiers._add_tier()  # two tiers available

    spawn = Spawn(local_id=1, template_id=299, x=0.0, y=0.0, z=0.0)
    inv.spawns.append(spawn)
    win._props.set_invasion(inv)
    win._props.set_target(spawn)

    win._props._tier.setCurrentIndex(1)  # assign to the reinforcement tier
    assert spawn.tier == 1
    win.close()
