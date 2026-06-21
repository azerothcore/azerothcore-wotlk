"""Headless smoke test for the PySide6 GUI (offscreen). Skipped if PySide6 is not installed."""

import os

import pytest

pytest.importorskip("PySide6")
os.environ.setdefault("QT_QPA_PLATFORM", "offscreen")

from PySide6.QtCore import QPointF  # noqa: E402
from PySide6.QtWidgets import QApplication  # noqa: E402

from invasion_authoring.gui.canvas import MODE_PATH, MODE_SPAWN, MapCanvas  # noqa: E402
from invasion_authoring.gui.main_window import MainWindow  # noqa: E402
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
