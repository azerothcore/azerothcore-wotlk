"""Main application window wiring the canvas, panels, DB reader and SQL export together."""

from __future__ import annotations

import time
from pathlib import Path

from PySide6.QtCore import Qt
from PySide6.QtGui import QAction, QActionGroup
from PySide6.QtWidgets import (
    QDockWidget,
    QFileDialog,
    QInputDialog,
    QListWidget,
    QMainWindow,
    QMessageBox,
    QToolBar,
)

from ..db import DbConfig, IWorldRef, WorldRef, WorldRefError
from ..guid import GuidAllocator
from ..model import EventDef, EventType, Invasion, Project
from ..sql import emit_sql
from ..storage import load_project, save_project
from .canvas import MODE_PATH, MODE_SELECT, MODE_SPAWN, MapCanvas
from .dialogs import CalibrationDialog, DbConnectDialog
from .panels import CreatureSearchPanel, EventDefPanel, PropertiesPanel, TiersPanel


def _find_pending_dir() -> Path:
    """Walk up from this file to find the repo's pending_db_world directory."""
    here = Path(__file__).resolve()
    for parent in here.parents:
        candidate = parent / "data" / "sql" / "updates" / "pending_db_world"
        if candidate.is_dir():
            return candidate
    return Path.home()


class MainWindow(QMainWindow):
    def __init__(self) -> None:
        super().__init__()
        self.setWindowTitle("Invasion Authoring — mod-branding")
        self.resize(1280, 820)

        self._project = Project(name="untitled")
        self._project.invasions.append(_new_invasion("Invasion 1"))
        self._current = 0
        self._project_path: Path | None = None
        self._world_ref: IWorldRef | None = None
        self._db_config = DbConfig()

        self._canvas = MapCanvas()
        self.setCentralWidget(self._canvas)

        self._invasion_list = QListWidget()
        self._event_panel = EventDefPanel()
        self._tiers = TiersPanel()
        self._props = PropertiesPanel()
        self._search = CreatureSearchPanel()

        self._build_docks()
        self._build_menu()
        self._build_toolbar()
        self._wire()
        self._refresh_invasion_list()
        self._select_invasion(0)

    # ---- construction --------------------------------------------------------------------
    def _build_docks(self) -> None:
        left = QDockWidget("Invasions", self)
        left.setWidget(self._invasion_list)
        self.addDockWidget(Qt.DockWidgetArea.LeftDockWidgetArea, left)

        event_dock = QDockWidget("Event", self)
        event_dock.setWidget(self._event_panel)
        self.addDockWidget(Qt.DockWidgetArea.LeftDockWidgetArea, event_dock)

        tiers_dock = QDockWidget("Spawn tiers", self)
        tiers_dock.setWidget(self._tiers)
        self.addDockWidget(Qt.DockWidgetArea.LeftDockWidgetArea, tiers_dock)

        search_dock = QDockWidget("Creatures", self)
        search_dock.setWidget(self._search)
        self.addDockWidget(Qt.DockWidgetArea.RightDockWidgetArea, search_dock)

        props_dock = QDockWidget("Properties", self)
        props_dock.setWidget(self._props)
        self.addDockWidget(Qt.DockWidgetArea.RightDockWidgetArea, props_dock)

    def _build_menu(self) -> None:
        file_menu = self.menuBar().addMenu("&File")
        file_menu.addAction(_act("New project", self, self._new_project, "Ctrl+N"))
        file_menu.addAction(_act("Open…", self, self._open, "Ctrl+O"))
        file_menu.addAction(_act("Save", self, self._save, "Ctrl+S"))
        file_menu.addAction(_act("Save as…", self, self._save_as, "Ctrl+Shift+S"))
        file_menu.addSeparator()
        file_menu.addAction(_act("Export SQL…", self, self._export_sql, "Ctrl+E"))
        file_menu.addSeparator()
        file_menu.addAction(_act("Quit", self, self.close, "Ctrl+Q"))

        inv_menu = self.menuBar().addMenu("&Invasion")
        inv_menu.addAction(_act("Add invasion", self, self._add_invasion))
        inv_menu.addAction(_act("Remove invasion", self, self._remove_invasion))
        inv_menu.addSeparator()
        inv_menu.addAction(_act("Calibrate image…", self, self._calibrate))
        inv_menu.addAction(_act("New path", self, self._new_path))

        db_menu = self.menuBar().addMenu("&Database")
        db_menu.addAction(_act("Connect…", self, self._connect_db))

    def _build_toolbar(self) -> None:
        bar = QToolBar("Tools", self)
        bar.setMovable(False)
        self.addToolBar(bar)

        self._mode_group = QActionGroup(self)
        self._mode_group.setExclusive(True)
        for label, mode in (("Select", MODE_SELECT), ("Place spawn", MODE_SPAWN), ("Draw path", MODE_PATH)):
            action = QAction(label, self, checkable=True)
            action.triggered.connect(lambda _checked, m=mode: self._canvas.set_mode(m))
            self._mode_group.addAction(action)
            bar.addAction(action)
            if mode == MODE_SELECT:
                action.setChecked(True)
        bar.addSeparator()
        bar.addAction(_act("New path", self, self._new_path))
        bar.addAction(_act("Export SQL", self, self._export_sql))

    def _wire(self) -> None:
        self._invasion_list.currentRowChanged.connect(self._select_invasion)
        self._event_panel.changed.connect(self._on_event_changed)
        self._tiers.changed.connect(self._on_tiers_changed)
        self._props.changed.connect(self._canvas.rebuild)
        self._canvas.changed.connect(self._on_canvas_changed)
        self._canvas.selectionChanged.connect(self._props.set_target)
        self._search.templateChosen.connect(self._canvas.set_template)
        self._search.templateChosen.connect(lambda e: self.statusBar().showMessage(f"Active template: {e}", 4000))

    # ---- invasion handling ---------------------------------------------------------------
    def _current_invasion(self) -> Invasion | None:
        if 0 <= self._current < len(self._project.invasions):
            return self._project.invasions[self._current]
        return None

    def _refresh_invasion_list(self) -> None:
        self._invasion_list.blockSignals(True)
        self._invasion_list.clear()
        for inv in self._project.invasions:
            self._invasion_list.addItem(f"{inv.name}  (zone {inv.event.zone_id})")
        self._invasion_list.setCurrentRow(self._current)
        self._invasion_list.blockSignals(False)

    def _select_invasion(self, row: int) -> None:
        if row < 0:
            return
        self._current = row
        inv = self._current_invasion()
        self._canvas.set_invasion(inv)
        self._event_panel.set_invasion(inv)
        self._tiers.set_invasion(inv)
        self._props.set_invasion(inv)
        self._props.set_target(None)

    def _on_event_changed(self) -> None:
        # Zone/name may have changed — refresh the list label without losing selection.
        row = self._current
        self._refresh_invasion_list()
        self._invasion_list.setCurrentRow(row)

    def _on_canvas_changed(self) -> None:
        self.statusBar().showMessage("Modified", 1500)

    def _on_tiers_changed(self) -> None:
        # The tier list drives the spawn properties' tier selector -- re-show it so options match.
        self._props.refresh()
        self.statusBar().showMessage("Tiers updated", 1500)

    def _add_invasion(self) -> None:
        n = len(self._project.invasions) + 1
        self._project.invasions.append(_new_invasion(f"Invasion {n}"))
        self._current = len(self._project.invasions) - 1
        self._refresh_invasion_list()
        self._select_invasion(self._current)

    def _remove_invasion(self) -> None:
        if len(self._project.invasions) <= 1:
            QMessageBox.information(self, "Invasion", "A project needs at least one invasion.")
            return
        del self._project.invasions[self._current]
        self._current = max(0, self._current - 1)
        self._refresh_invasion_list()
        self._select_invasion(self._current)

    def _calibrate(self) -> None:
        inv = self._current_invasion()
        if inv is None:
            return
        dlg = CalibrationDialog(inv.calibration, self)
        if dlg.exec() and dlg.result_calibration is not None:
            inv.calibration = dlg.result_calibration
            self._canvas.set_invasion(inv)

    def _new_path(self) -> None:
        if self._current_invasion() is None:
            return
        name, ok = QInputDialog.getText(self, "New path", "Path name:", text="wave")
        if ok:
            self._canvas.start_new_path(name or "path")
            self.statusBar().showMessage("New active path — switch to Draw path and click to add waypoints.", 5000)

    # ---- database ------------------------------------------------------------------------
    def _connect_db(self) -> None:
        dlg = DbConnectDialog(self._db_config, self)
        if not dlg.exec():
            return
        self._db_config = dlg.config()
        self._project.db_host = self._db_config.host
        self._project.db_schema = self._db_config.schema
        ref = WorldRef(self._db_config)
        try:
            ref.max_creature_guid()  # probe the connection eagerly
        except WorldRefError as exc:
            QMessageBox.warning(self, "Database", f"Could not connect:\n{exc}")
            return
        self._world_ref = ref
        self._search.set_world_ref(ref)
        self.statusBar().showMessage(f"Connected to {self._db_config.host}/{self._db_config.schema}", 5000)

    # ---- project I/O ---------------------------------------------------------------------
    def _new_project(self) -> None:
        self._project = Project(name="untitled")
        self._project.invasions.append(_new_invasion("Invasion 1"))
        self._project_path = None
        self._current = 0
        self._refresh_invasion_list()
        self._select_invasion(0)

    def _open(self) -> None:
        path, _ = QFileDialog.getOpenFileName(self, "Open project", "", "Invasion projects (*.invasion)")
        if not path:
            return
        try:
            self._project = load_project(path)
        except Exception as exc:
            QMessageBox.warning(self, "Open", f"Failed to load:\n{exc}")
            return
        if not self._project.invasions:
            self._project.invasions.append(_new_invasion("Invasion 1"))
        self._project_path = Path(path)
        self._current = 0
        self._refresh_invasion_list()
        self._select_invasion(0)

    def _save(self) -> None:
        if self._project_path is None:
            self._save_as()
            return
        save_project(self._project, self._project_path)
        self.statusBar().showMessage(f"Saved {self._project_path}", 4000)

    def _save_as(self) -> None:
        path, _ = QFileDialog.getSaveFileName(
            self, "Save project", "untitled.invasion", "Invasion projects (*.invasion)"
        )
        if not path:
            return
        self._project_path = Path(path)
        self._save()

    def _export_sql(self) -> None:
        if not self._project.invasions:
            QMessageBox.information(self, "Export", "Nothing to export.")
            return
        allocator = self._build_allocator()
        try:
            sql = emit_sql(self._project, allocator)
        except ValueError as exc:
            QMessageBox.warning(self, "Export", str(exc))
            return
        default = _find_pending_dir() / f"rev_{time.time_ns()}.sql"
        path, _ = QFileDialog.getSaveFileName(self, "Export SQL", str(default), "SQL (*.sql)")
        if not path:
            return
        Path(path).write_text(sql, encoding="utf-8")
        self.statusBar().showMessage(f"Exported {path}", 6000)
        QMessageBox.information(
            self,
            "Export",
            f"Wrote {path}\n\nValidate with:\n  python apps/codestyle/codestyle-sql.py",
        )

    def _build_allocator(self) -> GuidAllocator:
        floor = self._project.guid_base
        if self._world_ref is not None:
            try:
                return GuidAllocator.from_floor_and_db_max(floor, self._world_ref.max_creature_guid())
            except Exception:
                pass
        return GuidAllocator(base=floor)


def _new_invasion(name: str) -> Invasion:
    return Invasion(name=name, event=EventDef(zone_id=0, event_type=EventType.INVASION))


def _act(text: str, parent, slot, shortcut: str | None = None) -> QAction:
    action = QAction(text, parent)
    if shortcut:
        action.setShortcut(shortcut)
    action.triggered.connect(slot)
    return action


__all__ = ["MainWindow"]
