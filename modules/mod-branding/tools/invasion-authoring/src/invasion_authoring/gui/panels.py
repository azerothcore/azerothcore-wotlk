"""Dock panels: event-def editor, selected-item properties, creature-template search."""

from __future__ import annotations

from PySide6.QtCore import Qt, Signal
from PySide6.QtWidgets import (
    QCheckBox,
    QComboBox,
    QDoubleSpinBox,
    QFormLayout,
    QHBoxLayout,
    QLabel,
    QLineEdit,
    QListWidget,
    QListWidgetItem,
    QPushButton,
    QSpinBox,
    QVBoxLayout,
    QWidget,
)

from ..db import IWorldRef
from ..model import EventType, Invasion, Spawn, SpawnTier, Waypoint

_EVENT_LABELS = [
    ("Invasion", EventType.INVASION),
    ("Resource Surge", EventType.RESOURCE_SURGE),
    ("Elite Hunt", EventType.ELITE_HUNT),
    ("Profession Anomaly", EventType.PROFESSION_ANOMALY),
]
_MOVEMENT_LABELS = [("Idle / boss", 0), ("Random", 1), ("Waypoint path", 2)]


def _int_spin(maximum: int, value: int) -> QSpinBox:
    box = QSpinBox()
    box.setRange(0, maximum)
    box.setValue(value)
    return box


def _float_spin(value: float) -> QDoubleSpinBox:
    box = QDoubleSpinBox()
    box.setRange(-1_000_000.0, 1_000_000.0)
    box.setDecimals(4)
    box.setValue(value)
    return box


class EventDefPanel(QWidget):
    """Edits the branding_event_def fields + map id for the current invasion."""

    changed = Signal()

    def __init__(self, parent=None) -> None:
        super().__init__(parent)
        self._inv: Invasion | None = None
        self._building = False

        self._name = QLineEdit()
        self._zone = _int_spin(99999, 0)
        self._map = _int_spin(9999, 0)
        self._type = QComboBox()
        for label, _ in _EVENT_LABELS:
            self._type.addItem(label)
        self._goal = _int_spin(10_000_000, 100)
        self._active = _int_spin(86400, 1800)
        self._cooldown = _int_spin(604800, 3600)

        form = QFormLayout(self)
        form.addRow("Name:", self._name)
        form.addRow("Zone id:", self._zone)
        form.addRow("Map id:", self._map)
        form.addRow("Event type:", self._type)
        form.addRow("Goal (containment):", self._goal)
        form.addRow("Active seconds:", self._active)
        form.addRow("Cooldown seconds:", self._cooldown)

        self._name.textChanged.connect(self._apply)
        for w in (self._zone, self._map, self._goal, self._active, self._cooldown):
            w.valueChanged.connect(self._apply)
        self._type.currentIndexChanged.connect(self._apply)

    def set_invasion(self, inv: Invasion | None) -> None:
        self._inv = inv
        self._building = True
        if inv is not None:
            self._name.setText(inv.name)
            self._zone.setValue(inv.event.zone_id)
            self._map.setValue(inv.map_id)
            self._type.setCurrentIndex(int(inv.event.event_type))
            self._goal.setValue(inv.event.goal)
            self._active.setValue(inv.event.active_seconds)
            self._cooldown.setValue(inv.event.cooldown_seconds)
        self.setEnabled(inv is not None)
        self._building = False

    def _apply(self) -> None:
        if self._building or self._inv is None:
            return
        self._inv.name = self._name.text()
        self._inv.event.zone_id = self._zone.value()
        self._inv.map_id = self._map.value()
        self._inv.event.event_type = _EVENT_LABELS[self._type.currentIndex()][1]
        self._inv.event.goal = self._goal.value()
        self._inv.event.active_seconds = self._active.value()
        self._inv.event.cooldown_seconds = self._cooldown.value()
        self.changed.emit()


class PropertiesPanel(QWidget):
    """Edits the currently selected spawn or waypoint."""

    changed = Signal()

    def __init__(self, parent=None) -> None:
        super().__init__(parent)
        self._target = None
        self._inv: Invasion | None = None
        self._building = False
        self._layout = QVBoxLayout(self)
        self._placeholder = QLabel("Select a spawn or waypoint to edit.")
        self._placeholder.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self._layout.addWidget(self._placeholder)
        self._form_host: QWidget | None = None

    def set_invasion(self, inv: Invasion | None) -> None:
        # The spawn form's tier selector is populated from this invasion's tiers.
        self._inv = inv

    def set_target(self, target) -> None:
        self._target = target
        self._rebuild()

    def refresh(self) -> None:
        # Re-show the current target (e.g. after the tier list changed).
        self._rebuild()

    def _clear_form(self) -> None:
        if self._form_host is not None:
            self._form_host.setParent(None)
            self._form_host.deleteLater()
            self._form_host = None

    def _rebuild(self) -> None:
        self._clear_form()
        self._placeholder.setVisible(self._target is None)
        if self._target is None:
            return
        self._building = True
        host = QWidget()
        form = QFormLayout(host)
        if isinstance(self._target, Spawn):
            self._build_spawn_form(form)
        elif isinstance(self._target, Waypoint):
            self._build_waypoint_form(form)
        self._layout.addWidget(host)
        self._form_host = host
        self._building = False

    def _build_spawn_form(self, form: QFormLayout) -> None:
        s: Spawn = self._target
        self._template = _int_spin(10_000_000, s.template_id)
        self._x = _float_spin(s.x)
        self._y = _float_spin(s.y)
        self._z = _float_spin(s.z)
        self._o = _float_spin(s.orientation)
        self._spawntime = _int_spin(86400, s.spawntimesecs)
        self._move = QComboBox()
        for label, _ in _MOVEMENT_LABELS:
            self._move.addItem(label)
        self._move.setCurrentIndex(next((i for i, (_, v) in enumerate(_MOVEMENT_LABELS) if v == s.movement_type), 0))
        self._boss = QCheckBox()
        self._boss.setChecked(s.is_boss)
        # §2.5.3 tier selector: options are the invasion's tiers, or a single implicit base tier.
        self._tier = QComboBox()
        tiers = self._inv.tiers if self._inv and self._inv.tiers else []
        if tiers:
            for i, t in enumerate(tiers):
                self._tier.addItem(f"{i}: {t.name} (>= {t.min_participants})")
        else:
            self._tier.addItem("0: base")
        self._tier.setCurrentIndex(min(s.tier, self._tier.count() - 1))
        form.addRow("Template entry:", self._template)
        form.addRow("World X:", self._x)
        form.addRow("World Y:", self._y)
        form.addRow("World Z:", self._z)
        form.addRow("Orientation:", self._o)
        form.addRow("Spawn time (s):", self._spawntime)
        form.addRow("Movement:", self._move)
        form.addRow("Boss:", self._boss)
        form.addRow("Spawn tier:", self._tier)
        self._template.valueChanged.connect(self._apply_spawn)
        for w in (self._x, self._y, self._z, self._o, self._spawntime):
            w.valueChanged.connect(self._apply_spawn)
        self._move.currentIndexChanged.connect(self._apply_spawn)
        self._boss.toggled.connect(self._apply_spawn)
        self._tier.currentIndexChanged.connect(self._apply_spawn)

    def _apply_spawn(self) -> None:
        if self._building:
            return
        s: Spawn = self._target
        s.template_id = self._template.value()
        s.x = self._x.value()
        s.y = self._y.value()
        s.z = self._z.value()
        s.orientation = self._o.value()
        s.spawntimesecs = self._spawntime.value()
        s.movement_type = _MOVEMENT_LABELS[self._move.currentIndex()][1]
        s.is_boss = self._boss.isChecked()
        s.tier = self._tier.currentIndex()
        self.changed.emit()

    def _build_waypoint_form(self, form: QFormLayout) -> None:
        w: Waypoint = self._target
        self._x = _float_spin(w.x)
        self._y = _float_spin(w.y)
        self._z = _float_spin(w.z)
        self._o = _float_spin(w.orientation)
        self._delay = _int_spin(600000, w.delay_ms)
        self._mtype = _int_spin(9, w.move_type)
        form.addRow("World X:", self._x)
        form.addRow("World Y:", self._y)
        form.addRow("World Z:", self._z)
        form.addRow("Orientation:", self._o)
        form.addRow("Delay (ms):", self._delay)
        form.addRow("Move type:", self._mtype)
        for ww in (self._x, self._y, self._z, self._o, self._delay, self._mtype):
            ww.valueChanged.connect(self._apply_waypoint)

    def _apply_waypoint(self) -> None:
        if self._building:
            return
        w: Waypoint = self._target
        w.x = self._x.value()
        w.y = self._y.value()
        w.z = self._z.value()
        w.orientation = self._o.value()
        w.delay_ms = self._delay.value()
        w.move_type = self._mtype.value()
        self.changed.emit()


class TiersPanel(QWidget):
    """Edits the §2.5.3 additive spawn tiers of the current invasion.

    The base tier (min 0) is always up; reinforcement tiers layer in as the enrolled crowd crosses
    their threshold. Spawns are assigned to a tier in the Properties panel. An empty tier list means a
    single implicit base tier holds every spawn (the pre-crowd-scaling behaviour).
    """

    changed = Signal()

    def __init__(self, parent=None) -> None:
        super().__init__(parent)
        self._inv: Invasion | None = None
        self._building = False

        self._list = QListWidget()
        self._add = QPushButton("Add tier")
        self._remove = QPushButton("Remove tier")
        self._name = QLineEdit()
        self._min = _int_spin(100000, 0)
        self._goal = _int_spin(10_000_000, 0)

        layout = QVBoxLayout(self)
        layout.addWidget(QLabel("Additive spawn tiers (base always up; reinforcements by headcount):"))
        layout.addWidget(self._list)
        buttons = QHBoxLayout()
        buttons.addWidget(self._add)
        buttons.addWidget(self._remove)
        layout.addLayout(buttons)
        form = QFormLayout()
        form.addRow("Name:", self._name)
        form.addRow("Min participants:", self._min)
        form.addRow("Goal contribution:", self._goal)
        layout.addLayout(form)

        self._add.clicked.connect(self._add_tier)
        self._remove.clicked.connect(self._remove_tier)
        self._list.currentRowChanged.connect(self._load_selected)
        self._name.textChanged.connect(self._apply)
        self._min.valueChanged.connect(self._apply)
        self._goal.valueChanged.connect(self._apply)

    def set_invasion(self, inv: Invasion | None) -> None:
        self._inv = inv
        self._refresh_list()
        self.setEnabled(inv is not None)

    def _label(self, i: int, t: SpawnTier) -> str:
        return f"{i}: {t.name}  (>= {t.min_participants}, +{t.goal_contribution})"

    def _refresh_list(self) -> None:
        self._building = True
        self._list.clear()
        if self._inv is not None:
            for i, t in enumerate(self._inv.tiers):
                self._list.addItem(self._label(i, t))
        self._building = False
        self._load_selected(self._list.currentRow())

    def _selected_tier(self) -> SpawnTier | None:
        if self._inv is None:
            return None
        row = self._list.currentRow()
        return self._inv.tiers[row] if 0 <= row < len(self._inv.tiers) else None

    def _load_selected(self, _row: int) -> None:
        t = self._selected_tier()
        for w in (self._name, self._min, self._goal):
            w.setEnabled(t is not None)
        if t is None:
            return
        self._building = True
        self._name.setText(t.name)
        self._min.setValue(t.min_participants)
        self._goal.setValue(t.goal_contribution)
        self._building = False

    def _apply(self) -> None:
        if self._building:
            return
        t = self._selected_tier()
        if t is None:
            return
        t.name = self._name.text()
        t.min_participants = self._min.value()
        t.goal_contribution = self._goal.value()
        row = self._list.currentRow()
        self._list.item(row).setText(self._label(row, t))
        self.changed.emit()

    def _add_tier(self) -> None:
        if self._inv is None:
            return
        idx = len(self._inv.tiers)
        name = "base" if idx == 0 else f"tier {idx}"
        min_participants = 0 if idx == 0 else idx * 5
        self._inv.tiers.append(SpawnTier(name=name, min_participants=min_participants, goal_contribution=0))
        self._refresh_list()
        self._list.setCurrentRow(idx)
        self.changed.emit()

    def _remove_tier(self) -> None:
        if self._inv is None:
            return
        row = self._list.currentRow()
        if not 0 <= row < len(self._inv.tiers):
            return
        del self._inv.tiers[row]
        # Keep spawn tier indices valid: those on the removed tier fall back to base, higher shift down.
        for s in self._inv.spawns:
            if s.tier == row:
                s.tier = 0
            elif s.tier > row:
                s.tier -= 1
        self._refresh_list()
        self.changed.emit()


class CreatureSearchPanel(QWidget):
    """Search creature_template (live DB) and pick the active spawn template."""

    templateChosen = Signal(int)

    def __init__(self, parent=None) -> None:
        super().__init__(parent)
        self._ref: IWorldRef | None = None
        self._search = QLineEdit()
        self._search.setPlaceholderText("Search creature name…")
        self._results = QListWidget()
        self._status = QLabel("Not connected — type an entry id directly in Properties.")
        self._status.setWordWrap(True)

        layout = QVBoxLayout(self)
        layout.addWidget(self._search)
        layout.addWidget(self._results)
        layout.addWidget(self._status)

        self._search.returnPressed.connect(self._run_search)
        self._results.itemDoubleClicked.connect(self._chosen)

    def set_world_ref(self, ref: IWorldRef | None) -> None:
        self._ref = ref
        self._status.setText("Connected." if ref else "Not connected.")

    def _run_search(self) -> None:
        if self._ref is None:
            self._status.setText("Connect to acore_world to search (Database → Connect).")
            return
        self._results.clear()
        try:
            hits = self._ref.search_creature_templates(self._search.text().strip(), limit=100)
        except Exception as exc:  # pragma: no cover - network dependent
            self._status.setText(f"Search failed: {exc}")
            return
        for t in hits:
            label = f"{t.entry} — {t.name}" + (f" <{t.subname}>" if t.subname else "")
            item = QListWidgetItem(label)
            item.setData(Qt.ItemDataRole.UserRole, t.entry)
            self._results.addItem(item)
        self._status.setText(f"{len(hits)} result(s). Double-click to use as active template.")

    def _chosen(self, item: QListWidgetItem) -> None:
        self.templateChosen.emit(int(item.data(Qt.ItemDataRole.UserRole)))
