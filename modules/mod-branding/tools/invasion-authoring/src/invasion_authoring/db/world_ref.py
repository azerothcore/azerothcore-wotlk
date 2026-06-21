"""Read-only reference reads against ``acore_world``.

The GUI uses this to search creature templates, resolve a zone's map, seed the GUID allocator from
``max(creature.guid)``, and overlay existing spawns for context. It is injected behind the
:class:`IWorldRef` protocol so the rest of the app (and tests) never touch a live DB —
:class:`FakeWorldRef` stands in for unit tests.

The PyMySQL adapter issues read-only ``SELECT``s with parameterized queries; ``PyMySQL`` is imported
lazily so the pure core and headless tests need no DB driver installed.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Protocol, runtime_checkable


class WorldRefError(RuntimeError):
    """Raised when the live DB cannot be reached or queried."""


@dataclass(frozen=True)
class CreatureTemplate:
    entry: int
    name: str
    subname: str = ""
    minlevel: int = 0
    maxlevel: int = 0
    rank: int = 0


@dataclass(frozen=True)
class ExistingSpawn:
    guid: int
    entry: int
    x: float
    y: float
    z: float


@runtime_checkable
class IWorldRef(Protocol):
    def search_creature_templates(self, name_like: str, limit: int = 50) -> list[CreatureTemplate]: ...
    def get_creature_template(self, entry: int) -> CreatureTemplate | None: ...
    def zone_map(self, zone_id: int) -> int | None: ...
    def max_creature_guid(self) -> int: ...
    def existing_spawns_in_zone(self, zone_id: int, limit: int = 500) -> list[ExistingSpawn]: ...


class FakeWorldRef:
    """In-memory :class:`IWorldRef` for tests and offline use."""

    def __init__(
        self,
        templates: list[CreatureTemplate] | None = None,
        zone_maps: dict[int, int] | None = None,
        max_guid: int = 0,
        spawns: dict[int, list[ExistingSpawn]] | None = None,
    ) -> None:
        self._templates = list(templates or [])
        self._zone_maps = dict(zone_maps or {})
        self._max_guid = int(max_guid)
        self._spawns = dict(spawns or {})

    def search_creature_templates(self, name_like: str, limit: int = 50) -> list[CreatureTemplate]:
        needle = name_like.lower()
        hits = [t for t in self._templates if needle in t.name.lower()]
        return hits[:limit]

    def get_creature_template(self, entry: int) -> CreatureTemplate | None:
        return next((t for t in self._templates if t.entry == entry), None)

    def zone_map(self, zone_id: int) -> int | None:
        return self._zone_maps.get(zone_id)

    def max_creature_guid(self) -> int:
        return self._max_guid

    def existing_spawns_in_zone(self, zone_id: int, limit: int = 500) -> list[ExistingSpawn]:
        return self._spawns.get(zone_id, [])[:limit]


@dataclass
class DbConfig:
    host: str = "localhost"
    port: int = 3306
    user: str = "acore"
    password: str = ""
    schema: str = "acore_world"


class WorldRef:
    """PyMySQL-backed read-only :class:`IWorldRef`. Connects lazily on first use."""

    def __init__(self, config: DbConfig) -> None:
        self._config = config
        self._conn = None  # type: ignore[var-annotated]

    def _connection(self):
        if self._conn is not None:
            return self._conn
        try:
            import pymysql  # local import: optional dependency
        except ImportError as exc:  # pragma: no cover - exercised only without the extra installed
            raise WorldRefError("PyMySQL is not installed (install the 'db' extra)") from exc
        try:
            self._conn = pymysql.connect(
                host=self._config.host,
                port=self._config.port,
                user=self._config.user,
                password=self._config.password,
                database=self._config.schema,
                cursorclass=pymysql.cursors.DictCursor,
                read_default_group=None,
                autocommit=True,
            )
        except Exception as exc:  # pragma: no cover - network dependent
            raise WorldRefError(f"cannot connect to {self._config.host}/{self._config.schema}: {exc}") from exc
        return self._conn

    def _query(self, sql: str, args: tuple = ()) -> list[dict]:
        conn = self._connection()
        try:
            with conn.cursor() as cur:
                cur.execute(sql, args)
                return list(cur.fetchall())
        except Exception as exc:  # pragma: no cover - network dependent
            raise WorldRefError(f"query failed: {exc}") from exc

    def search_creature_templates(self, name_like: str, limit: int = 50) -> list[CreatureTemplate]:
        rows = self._query(
            "SELECT `entry`, `name`, `subname`, `minlevel`, `maxlevel`, `rank` "
            "FROM `creature_template` WHERE `name` LIKE %s ORDER BY `entry` LIMIT %s",
            (f"%{name_like}%", int(limit)),
        )
        return [_row_to_template(r) for r in rows]

    def get_creature_template(self, entry: int) -> CreatureTemplate | None:
        rows = self._query(
            "SELECT `entry`, `name`, `subname`, `minlevel`, `maxlevel`, `rank` "
            "FROM `creature_template` WHERE `entry` = %s",
            (int(entry),),
        )
        return _row_to_template(rows[0]) if rows else None

    def zone_map(self, zone_id: int) -> int | None:
        rows = self._query(
            "SELECT `map` FROM `creature` WHERE `zoneId` = %s LIMIT 1",
            (int(zone_id),),
        )
        return int(rows[0]["map"]) if rows else None

    def max_creature_guid(self) -> int:
        rows = self._query("SELECT MAX(`guid`) AS `m` FROM `creature`")
        value = rows[0]["m"] if rows else None
        return int(value) if value is not None else 0

    def existing_spawns_in_zone(self, zone_id: int, limit: int = 500) -> list[ExistingSpawn]:
        rows = self._query(
            "SELECT `guid`, `id1`, `position_x`, `position_y`, `position_z` "
            "FROM `creature` WHERE `zoneId` = %s LIMIT %s",
            (int(zone_id), int(limit)),
        )
        return [
            ExistingSpawn(
                guid=int(r["guid"]),
                entry=int(r["id1"]),
                x=float(r["position_x"]),
                y=float(r["position_y"]),
                z=float(r["position_z"]),
            )
            for r in rows
        ]


def _row_to_template(r: dict) -> CreatureTemplate:
    return CreatureTemplate(
        entry=int(r["entry"]),
        name=r.get("name") or "",
        subname=r.get("subname") or "",
        minlevel=int(r.get("minlevel") or 0),
        maxlevel=int(r.get("maxlevel") or 0),
        rank=int(r.get("rank") or 0),
    )
