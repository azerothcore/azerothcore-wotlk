"""Authoring domain model.

A :class:`Project` holds one or more :class:`Invasion`s. Each invasion binds an :class:`EventDef`
(the ``branding_event_def`` row) to a set of :class:`Spawn`s, :class:`Path`s (drawn waypoints) and
:class:`Formation`s, plus an optional image :class:`Calibration`. Everything serializes to plain
JSON-compatible dicts so projects save to ``.invasion`` files and survive a round-trip exactly.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import IntEnum

from ..geometry import Affine, ReferencePoint


class EventType(IntEnum):
    """Mirrors ``branding_event_def.event_type`` / ``Branding::EventType``."""

    INVASION = 0
    RESOURCE_SURGE = 1
    ELITE_HUNT = 2
    PROFESSION_ANOMALY = 3


# Creature MovementType values (AzerothCore ``creature.MovementType``).
MOVEMENT_IDLE = 0
MOVEMENT_RANDOM = 1
MOVEMENT_WAYPOINT = 2


@dataclass
class Waypoint:
    """One ``waypoint_data`` point."""

    x: float
    y: float
    z: float
    orientation: float = 0.0
    delay_ms: int = 0
    move_type: int = 0  # 0 walk, 1 run, 2 land, 3 takeoff

    def to_dict(self) -> dict:
        return {
            "x": self.x,
            "y": self.y,
            "z": self.z,
            "orientation": self.orientation,
            "delay_ms": self.delay_ms,
            "move_type": self.move_type,
        }

    @classmethod
    def from_dict(cls, d: dict) -> Waypoint:
        return cls(
            x=d["x"],
            y=d["y"],
            z=d["z"],
            orientation=d.get("orientation", 0.0),
            delay_ms=d.get("delay_ms", 0),
            move_type=d.get("move_type", 0),
        )


@dataclass
class Path:
    """A drawn waypoint path; ``local_id`` is referenced by spawns within an invasion."""

    local_id: int
    name: str
    waypoints: list[Waypoint] = field(default_factory=list)

    def to_dict(self) -> dict:
        return {"local_id": self.local_id, "name": self.name, "waypoints": [w.to_dict() for w in self.waypoints]}

    @classmethod
    def from_dict(cls, d: dict) -> Path:
        return cls(
            local_id=d["local_id"],
            name=d["name"],
            waypoints=[Waypoint.from_dict(w) for w in d.get("waypoints", [])],
        )


@dataclass
class Spawn:
    """A single creature spawn (``creature`` row)."""

    local_id: int
    template_id: int  # creature_template entry -> creature.id1
    x: float
    y: float
    z: float
    orientation: float = 0.0
    spawntimesecs: int = 120
    movement_type: int = MOVEMENT_IDLE
    path_local_id: int | None = None
    is_boss: bool = False

    def to_dict(self) -> dict:
        return {
            "local_id": self.local_id,
            "template_id": self.template_id,
            "x": self.x,
            "y": self.y,
            "z": self.z,
            "orientation": self.orientation,
            "spawntimesecs": self.spawntimesecs,
            "movement_type": self.movement_type,
            "path_local_id": self.path_local_id,
            "is_boss": self.is_boss,
        }

    @classmethod
    def from_dict(cls, d: dict) -> Spawn:
        return cls(
            local_id=d["local_id"],
            template_id=d["template_id"],
            x=d["x"],
            y=d["y"],
            z=d["z"],
            orientation=d.get("orientation", 0.0),
            spawntimesecs=d.get("spawntimesecs", 120),
            movement_type=d.get("movement_type", MOVEMENT_IDLE),
            path_local_id=d.get("path_local_id"),
            is_boss=d.get("is_boss", False),
        )


@dataclass
class Formation:
    """A ``creature_formations`` group: a leader and members moving together."""

    name: str
    leader_local_id: int
    member_local_ids: list[int] = field(default_factory=list)
    follow_dist: float = 2.0
    follow_angle: float = 0.0
    group_ai: int = 0

    def to_dict(self) -> dict:
        return {
            "name": self.name,
            "leader_local_id": self.leader_local_id,
            "member_local_ids": list(self.member_local_ids),
            "follow_dist": self.follow_dist,
            "follow_angle": self.follow_angle,
            "group_ai": self.group_ai,
        }

    @classmethod
    def from_dict(cls, d: dict) -> Formation:
        return cls(
            name=d["name"],
            leader_local_id=d["leader_local_id"],
            member_local_ids=list(d.get("member_local_ids", [])),
            follow_dist=d.get("follow_dist", 2.0),
            follow_angle=d.get("follow_angle", 0.0),
            group_ai=d.get("group_ai", 0),
        )


@dataclass
class EventDef:
    """The ``branding_event_def`` row for an invasion."""

    zone_id: int
    event_type: EventType
    goal: int = 100
    active_seconds: int = 1800
    cooldown_seconds: int = 3600

    def __post_init__(self) -> None:
        # Accept a raw int too, but reject out-of-range values.
        self.event_type = EventType(int(self.event_type))

    def to_dict(self) -> dict:
        return {
            "zone_id": self.zone_id,
            "event_type": int(self.event_type),
            "goal": self.goal,
            "active_seconds": self.active_seconds,
            "cooldown_seconds": self.cooldown_seconds,
        }

    @classmethod
    def from_dict(cls, d: dict) -> EventDef:
        return cls(
            zone_id=d["zone_id"],
            event_type=EventType(d["event_type"]),
            goal=d.get("goal", 100),
            active_seconds=d.get("active_seconds", 1800),
            cooldown_seconds=d.get("cooldown_seconds", 3600),
        )


@dataclass
class Calibration:
    """Image-to-world calibration for the canvas backdrop."""

    image_path: str
    refs: list[ReferencePoint] = field(default_factory=list)

    def affine(self) -> Affine:
        return Affine.from_reference_points(self.refs)

    def to_dict(self) -> dict:
        return {
            "image_path": self.image_path,
            "refs": [{"px": r.px, "py": r.py, "wx": r.wx, "wy": r.wy} for r in self.refs],
        }

    @classmethod
    def from_dict(cls, d: dict) -> Calibration:
        return cls(
            image_path=d["image_path"],
            refs=[ReferencePoint(px=r["px"], py=r["py"], wx=r["wx"], wy=r["wy"]) for r in d.get("refs", [])],
        )


@dataclass
class Invasion:
    """One authored invasion."""

    name: str
    event: EventDef
    map_id: int = 0
    calibration: Calibration | None = None
    spawns: list[Spawn] = field(default_factory=list)
    paths: list[Path] = field(default_factory=list)
    formations: list[Formation] = field(default_factory=list)

    def to_dict(self) -> dict:
        return {
            "name": self.name,
            "event": self.event.to_dict(),
            "map_id": self.map_id,
            "calibration": self.calibration.to_dict() if self.calibration else None,
            "spawns": [s.to_dict() for s in self.spawns],
            "paths": [p.to_dict() for p in self.paths],
            "formations": [f.to_dict() for f in self.formations],
        }

    @classmethod
    def from_dict(cls, d: dict) -> Invasion:
        calib = d.get("calibration")
        return cls(
            name=d["name"],
            event=EventDef.from_dict(d["event"]),
            map_id=d.get("map_id", 0),
            calibration=Calibration.from_dict(calib) if calib else None,
            spawns=[Spawn.from_dict(s) for s in d.get("spawns", [])],
            paths=[Path.from_dict(p) for p in d.get("paths", [])],
            formations=[Formation.from_dict(f) for f in d.get("formations", [])],
        )


@dataclass
class Project:
    """Top-level authoring document, persisted as a ``.invasion`` JSON file."""

    SCHEMA_VERSION = 1

    name: str
    db_host: str = "localhost"
    db_schema: str = "acore_world"
    guid_base: int = 90_000_000
    invasions: list[Invasion] = field(default_factory=list)

    def to_dict(self) -> dict:
        return {
            "schema_version": self.SCHEMA_VERSION,
            "name": self.name,
            "db_host": self.db_host,
            "db_schema": self.db_schema,
            "guid_base": self.guid_base,
            "invasions": [i.to_dict() for i in self.invasions],
        }

    @classmethod
    def from_dict(cls, d: dict) -> Project:
        version = d.get("schema_version", 1)
        if version != cls.SCHEMA_VERSION:
            raise ValueError(f"unsupported project schema_version {version}")
        return cls(
            name=d["name"],
            db_host=d.get("db_host", "localhost"),
            db_schema=d.get("db_schema", "acore_world"),
            guid_base=d.get("guid_base", 90_000_000),
            invasions=[Invasion.from_dict(i) for i in d.get("invasions", [])],
        )
