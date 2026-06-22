# Invasion Authoring Tool — Specification

Status: draft · Part of `mod-branding` · Tracks design §9.1 (region event triggers, spawns).

## 1. Purpose

A Qt6 desktop editor for authoring **ambient invasions** for `mod-branding`. The module's
`EventScheduler` (§9.1) auto-cycles events from `branding_event_def`, but currently reuses mobs
already standing in a zone. This tool lets a designer author an invasion's **own** content visually —
spawn anchors, boss spawns, and drawn **waypoint paths** — then export a codestyle-clean
`rev_*.sql` for `data/sql/updates/pending_db_world/`.

It also authors a manual-spawn `spawn_group` for the invasion and a `branding_event_spawn` row that
links an event `(zone_id, event_type)` to that group and its map, so `EventScheduler` spawns/despawns
the event's creatures on cycle (`Map::SpawnGroupSpawn`/`Despawn`). The group uses the
`SPAWNGROUP_FLAG_MANUAL_SPAWN` flag so the creatures never auto-appear on grid load.

## 2. Scope

In scope:
- Visual editor over a **calibrated per-zone image** (world X/Y ↔ pixels).
- Draw/edit **waypoint paths** (mob-style moving invasions) and place idle **boss** spawns.
- Pick creature templates from a **read-only live `acore_world`** connection.
- Save/load authoring projects (`.invasion`, JSON).
- Export one `rev_*.sql` writing: `branding_event_def`, `creature`, `waypoint_data`,
  `creature_addon`, `creature_formations`, `spawn_group_template`, `spawn_group`,
  `branding_event_spawn`.
- Non-colliding custom GUID allocation (reserve a high base from DB max).

Out of scope (follow-ups):
- C++ wiring of spawn-on-start / despawn-on-end in `EventScheduler`/`EventMgr`.
- Bundling WoW client map tiles (designer supplies zone images).

## 3. Domain model

- **Project**: name, target DB info (host/schema, no stored password), list of `Invasion`s.
- **Invasion**: bound to one `EventDef` `(zone_id, event_type, goal, active_seconds,
  cooldown_seconds)`; a `Calibration`; a list of `Tier`s (each owning its `Spawn`s); a list of
  `Path`s; a list of `Formation`s.
- **Tier** *(crowd-scaling, design §2.5.3)*: a named reinforcement layer with a `min_participants`
  threshold and a `goal_contribution`. Each tier exports one manual `spawn_group`; the base tier is
  `min_participants = 0` (always up while the event is active) and additive tiers layer on top as the
  enrolled crowd grows. `EventScheduler` spawns/despawns each tier's group by threshold and sums the
  active tiers' `goal_contribution` into the live containment goal. A single-tier (base only)
  invasion is the degenerate, pre-§2.5 case.
- **Calibration**: image path + reference points mapping pixel↔world; yields an affine transform.
- **Spawn**: belongs to one `Tier`; `creature_template` id (`id1`), world x/y/z, orientation,
  `spawntimesecs`, `MovementType` (0 idle/boss, 2 waypoint), optional `path_id`, optional `formation`
  membership. Boss/mini-boss spawns belong to the base tier (they stay singular; only their stats
  scale, per §2.5.1) — additive tiers carry trash reinforcements.
- **Path**: ordered `Waypoint`s `(x, y, z, orientation, delay_ms, move_type)`; owns a `path_id`.
- **Formation**: leader spawn + member spawns + follow params (angle, distance, group_ai).

## 4. EventType encoding

Matches `branding_event_def.event_type` / `Branding::EventType`:
`0=Invasion, 1=ResourceSurge, 2=EliteHunt, 3=ProfessionAnomaly`.

## 5. Coordinate calibration

WoW world coords are continuous floats per map. The canvas works in image pixels; calibration maps
pixel→world via an **affine transform**:
- **2-point** mode assumes the standard WoW axis convention (no rotation/shear, independent X/Y
  scale) — solvable from two non-coincident reference points.
- **3-point** mode solves a full affine (handles rotation/flip/shear).

The transform and its inverse are pure functions, unit-tested by round-trip.

## 6. GUID strategy

Custom spawns must not collide with current or future official GUIDs. The allocator reserves a base
≥ a configurable floor (default `90_000_000`) and ≥ `max(creature.guid)+1` read from the live DB,
then hands out contiguous, non-overlapping ids for creatures, waypoint paths and spawn groups. The
base is recorded in the project so re-exports are stable.

## 7. SQL output contract (must pass `apps/codestyle/codestyle-sql.py`)

- One `rev_<timestamp>.sql` per export (generated via `pending_db_world/create_sql.sh` naming).
- Every `INSERT` is immediately preceded (no blank line between) by a matching `DELETE`.
- All identifiers backticked; numeric values bare; InnoDB only for `CREATE TABLE`.
- 4-space indent, LF, no tabs, no trailing whitespace, no double blank lines, no `;;`, final newline.
- `creature_template` is never `DELETE`d (the codestyle "not_delete" set); the tool only references
  existing templates by id — it does not author templates.
- New `branding_event_spawn` created with `CREATE TABLE IF NOT EXISTS` + InnoDB. Per §2.5.3 it holds
  **multiple rows** per `(zone_id, event_type)` — one per tier — with `min_participants` and
  `goal_contribution` columns; the primary key is `(zone_id, event_type, group_id)`. The tool
  refreshes an invasion's rows with a single DELETE on `(zone_id, event_type)` immediately followed by
  the per-tier INSERTs. Each tier also writes its own `spawn_group_template` (flag `MANUAL_SPAWN`) and
  `spawn_group` membership rows for that tier's creatures.

## 8. Architecture

Pure core (no Qt) + thin PySide6 adapter, dependency-injected at the DB and GUID boundaries so all
logic is headless-testable. Packages: `model`, `geometry`, `guid`, `sql`, `db`, `gui`.

## 9. Tech & conventions

Python ≥ 3.11, `uv` + `pyproject.toml`, src/ layout, `tests/`, `ruff`, pytest, TDD. Deps: `PySide6`
(GUI), `PyMySQL` (read-only DB). Cross-platform (macOS/Linux/Windows).

## 10. Acceptance

- `uv run pytest` green; `uv run ruff check` clean.
- A generated sample `rev_*.sql` passes `python apps/codestyle/codestyle-sql.py`.
- GUI: calibrate a zone image, draw a path, drop a boss, export → valid SQL that loads into a test
  `acore_world` and the wave walks the drawn path in-game.
