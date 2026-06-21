"""The editing canvas: a calibrated map view for placing spawns and drawing waypoint paths.

The scene works in image-pixel space (1 scene unit = 1 background pixel). A :class:`Calibration`
supplies the affine pixel<->world mapping; without one the canvas treats scene coords as world
coords 1:1 so the tool is still usable before calibrating.

Interaction modes:

* **select** — pan the view, click to select, drag items to move them (model syncs on release).
* **spawn**  — left-click drops a creature spawn using the current template.
* **path**   — left-click appends a waypoint to the active path (the drawn polyline grows live).
"""

from __future__ import annotations

from PySide6.QtCore import QPointF, Qt, Signal
from PySide6.QtGui import QBrush, QColor, QPainter, QPainterPath, QPen, QPixmap
from PySide6.QtWidgets import (
    QGraphicsEllipseItem,
    QGraphicsPathItem,
    QGraphicsPixmapItem,
    QGraphicsScene,
    QGraphicsView,
)

from ..geometry import Affine
from ..model import MOVEMENT_WAYPOINT, Invasion, Spawn, Waypoint

MODE_SELECT = "select"
MODE_SPAWN = "spawn"
MODE_PATH = "path"

_SPAWN_R = 6.0
_WP_R = 4.0


class MapCanvas(QGraphicsView):
    changed = Signal()
    selectionChanged = Signal(object)  # selected model object (Spawn | Waypoint) or None

    def __init__(self, parent=None) -> None:
        self._scene = QGraphicsScene()
        super().__init__(self._scene, parent)
        self.setRenderHint(QPainter.RenderHint.Antialiasing)
        self.setMouseTracking(True)

        self._invasion: Invasion | None = None
        self._affine: Affine | None = None
        self._mode = MODE_SELECT
        self._template_id = 1
        self._z_default = 0.0
        self._active_path_local: int | None = None
        self._next_spawn_local = 1
        self._next_path_local = 1
        self._bg_item: QGraphicsPixmapItem | None = None
        self._set_drag_for_mode()

    # ---- configuration -------------------------------------------------------------------
    def set_invasion(self, inv: Invasion | None) -> None:
        self._invasion = inv
        self._affine = None
        if inv and inv.calibration and len(inv.calibration.refs) >= 2:
            try:
                self._affine = inv.calibration.affine()
            except Exception:
                self._affine = None
        self._next_spawn_local = max([s.local_id for s in inv.spawns], default=0) + 1 if inv else 1
        self._next_path_local = max([p.local_id for p in inv.paths], default=0) + 1 if inv else 1
        self._active_path_local = inv.paths[-1].local_id if inv and inv.paths else None
        self.rebuild()

    def set_template(self, entry: int) -> None:
        self._template_id = int(entry)

    def set_default_z(self, z: float) -> None:
        self._z_default = float(z)

    def set_mode(self, mode: str) -> None:
        self._mode = mode
        self._set_drag_for_mode()

    def active_path_local(self) -> int | None:
        return self._active_path_local

    def start_new_path(self, name: str = "path") -> int:
        assert self._invasion is not None
        from ..model import Path

        local = self._next_path_local
        self._next_path_local += 1
        self._invasion.paths.append(Path(local_id=local, name=name))
        self._active_path_local = local
        self.rebuild()
        self.changed.emit()
        return local

    def _set_drag_for_mode(self) -> None:
        if self._mode == MODE_SELECT:
            self.setDragMode(QGraphicsView.DragMode.ScrollHandDrag)
        else:
            self.setDragMode(QGraphicsView.DragMode.NoDrag)

    # ---- coordinate mapping --------------------------------------------------------------
    def _scene_to_world(self, pt: QPointF) -> tuple[float, float]:
        if self._affine is None:
            return (pt.x(), pt.y())
        return self._affine.pixel_to_world(pt.x(), pt.y())

    def _world_to_scene(self, wx: float, wy: float) -> QPointF:
        if self._affine is None:
            return QPointF(wx, wy)
        px, py = self._affine.world_to_pixel(wx, wy)
        return QPointF(px, py)

    # ---- rendering -----------------------------------------------------------------------
    def rebuild(self) -> None:
        self._scene.clear()
        self._bg_item = None
        if self._invasion is None:
            return
        calib = self._invasion.calibration
        if calib and calib.image_path:
            pix = QPixmap(calib.image_path)
            if not pix.isNull():
                self._bg_item = self._scene.addPixmap(pix)
                self._bg_item.setZValue(-100)
                self.setSceneRect(self._bg_item.boundingRect())

        for path in self._invasion.paths:
            self._draw_path(path.local_id, path.waypoints)
        for spawn in self._invasion.spawns:
            self._draw_spawn(spawn)

    def _draw_spawn(self, spawn: Spawn) -> None:
        pos = self._world_to_scene(spawn.x, spawn.y)
        item = QGraphicsEllipseItem(-_SPAWN_R, -_SPAWN_R, 2 * _SPAWN_R, 2 * _SPAWN_R)
        item.setPos(pos)
        color = QColor(220, 60, 60) if spawn.is_boss else QColor(70, 130, 220)
        item.setBrush(QBrush(color))
        item.setPen(QPen(QColor(20, 20, 20), 1.0))
        item.setFlag(QGraphicsEllipseItem.GraphicsItemFlag.ItemIsSelectable, True)
        item.setFlag(QGraphicsEllipseItem.GraphicsItemFlag.ItemIsMovable, self._mode == MODE_SELECT)
        item.setData(0, "spawn")
        item.setData(1, spawn.local_id)
        item.setToolTip(f"spawn {spawn.local_id} (entry {spawn.template_id})")
        self._scene.addItem(item)

    def _draw_path(self, path_local: int, waypoints: list[Waypoint]) -> None:
        if not waypoints:
            return
        painter_path = QPainterPath()
        first = self._world_to_scene(waypoints[0].x, waypoints[0].y)
        painter_path.moveTo(first)
        for wp in waypoints[1:]:
            painter_path.lineTo(self._world_to_scene(wp.x, wp.y))
        line = QGraphicsPathItem(painter_path)
        active = path_local == self._active_path_local
        line.setPen(QPen(QColor(40, 180, 90) if active else QColor(120, 120, 120), 2.0, Qt.PenStyle.DashLine))
        line.setZValue(-10)
        self._scene.addItem(line)

        for idx, wp in enumerate(waypoints, start=1):
            node = QGraphicsEllipseItem(-_WP_R, -_WP_R, 2 * _WP_R, 2 * _WP_R)
            node.setPos(self._world_to_scene(wp.x, wp.y))
            node.setBrush(QBrush(QColor(40, 180, 90)))
            node.setPen(QPen(QColor(20, 20, 20), 1.0))
            node.setFlag(QGraphicsEllipseItem.GraphicsItemFlag.ItemIsSelectable, True)
            node.setFlag(QGraphicsEllipseItem.GraphicsItemFlag.ItemIsMovable, self._mode == MODE_SELECT)
            node.setData(0, "wp")
            node.setData(1, path_local)
            node.setData(2, idx - 1)
            node.setToolTip(f"path {path_local} point {idx}")
            self._scene.addItem(node)

    # ---- interaction ---------------------------------------------------------------------
    def mousePressEvent(self, event) -> None:
        if self._invasion is None or event.button() != Qt.MouseButton.LeftButton:
            super().mousePressEvent(event)
            return
        scene_pos = self.mapToScene(event.position().toPoint())
        if self._mode == MODE_SPAWN:
            self._place_spawn(scene_pos)
            return
        if self._mode == MODE_PATH:
            self._place_waypoint(scene_pos)
            return
        super().mousePressEvent(event)
        self._emit_selection()

    def mouseReleaseEvent(self, event) -> None:
        super().mouseReleaseEvent(event)
        if self._mode == MODE_SELECT and event.button() == Qt.MouseButton.LeftButton:
            if self._sync_moved_items():
                self.changed.emit()

    def keyPressEvent(self, event) -> None:
        if event.key() in (Qt.Key.Key_Delete, Qt.Key.Key_Backspace):
            if self._delete_selected():
                self.rebuild()
                self.changed.emit()
                return
        super().keyPressEvent(event)

    def _place_spawn(self, scene_pos: QPointF) -> None:
        assert self._invasion is not None
        wx, wy = self._scene_to_world(scene_pos)
        spawn = Spawn(
            local_id=self._next_spawn_local,
            template_id=self._template_id,
            x=wx,
            y=wy,
            z=self._z_default,
        )
        self._next_spawn_local += 1
        self._invasion.spawns.append(spawn)
        self.rebuild()
        self.changed.emit()

    def _place_waypoint(self, scene_pos: QPointF) -> None:
        assert self._invasion is not None
        if self._active_path_local is None:
            self.start_new_path()
        path = self._path(self._active_path_local)
        if path is None:
            return
        wx, wy = self._scene_to_world(scene_pos)
        path.waypoints.append(Waypoint(x=wx, y=wy, z=self._z_default))
        self.rebuild()
        self.changed.emit()

    def _sync_moved_items(self) -> bool:
        assert self._invasion is not None
        moved = False
        for item in self._scene.items():
            kind = item.data(0)
            if kind == "spawn":
                spawn = self._spawn(item.data(1))
                if spawn is None:
                    continue
                wx, wy = self._scene_to_world(item.scenePos())
                if (spawn.x, spawn.y) != (wx, wy):
                    spawn.x, spawn.y = wx, wy
                    moved = True
            elif kind == "wp":
                path = self._path(item.data(1))
                if path is None:
                    continue
                idx = item.data(2)
                if 0 <= idx < len(path.waypoints):
                    wx, wy = self._scene_to_world(item.scenePos())
                    wp = path.waypoints[idx]
                    if (wp.x, wp.y) != (wx, wy):
                        wp.x, wp.y = wx, wy
                        moved = True
        return moved

    def _delete_selected(self) -> bool:
        assert self._invasion is not None
        removed = False
        for item in self._scene.selectedItems():
            kind = item.data(0)
            if kind == "spawn":
                spawn = self._spawn(item.data(1))
                if spawn is not None:
                    self._invasion.spawns.remove(spawn)
                    removed = True
            elif kind == "wp":
                path = self._path(item.data(1))
                idx = item.data(2)
                if path is not None and 0 <= idx < len(path.waypoints):
                    del path.waypoints[idx]
                    removed = True
        return removed

    def _emit_selection(self) -> None:
        sel = self._scene.selectedItems()
        if not sel:
            self.selectionChanged.emit(None)
            return
        item = sel[0]
        if item.data(0) == "spawn":
            self.selectionChanged.emit(self._spawn(item.data(1)))
        elif item.data(0) == "wp":
            path = self._path(item.data(1))
            idx = item.data(2)
            if path is not None and 0 <= idx < len(path.waypoints):
                self.selectionChanged.emit(path.waypoints[idx])

    # ---- model lookup --------------------------------------------------------------------
    def _spawn(self, local_id) -> Spawn | None:
        if self._invasion is None:
            return None
        return next((s for s in self._invasion.spawns if s.local_id == local_id), None)

    def _path(self, local_id):
        if self._invasion is None:
            return None
        return next((p for p in self._invasion.paths if p.local_id == local_id), None)

    def mark_pathfollowers(self) -> None:
        """Set MovementType=waypoint and link active-path spawns; a convenience for the toolbar."""
        if self._invasion is None or self._active_path_local is None:
            return
        for spawn in self._invasion.spawns:
            if spawn.path_local_id == self._active_path_local:
                spawn.movement_type = MOVEMENT_WAYPOINT
        self.changed.emit()
