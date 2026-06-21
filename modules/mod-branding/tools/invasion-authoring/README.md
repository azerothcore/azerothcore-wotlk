# Invasion Authoring Tool

A Qt6 (PySide6) visual editor for authoring **ambient invasions** for the `mod-branding` module.

Load a calibrated zone image, **draw waypoint paths** for mob-style moving invasions, drop idle boss
spawns, pick creature templates from a live (read-only) `acore_world` connection, and export a
codestyle-clean `rev_*.sql` for `data/sql/updates/pending_db_world/`.

See [SPEC.md](SPEC.md) for the full specification and [the module architecture](../../docs/ARCHITECTURE.md)
(§9.1) for how invasions fit the event model.

## Quick start

```bash
cd modules/mod-branding/tools/invasion-authoring
uv sync                 # create venv + install deps
uv run pytest           # run the pure-core tests
uv run ruff check       # lint
uv run invasion-authoring   # launch the GUI
```

## Layout

```
src/invasion_authoring/
  model/      project / invasion dataclasses + JSON (de)serialization
  geometry/   pixel <-> world affine calibration (pure)
  guid/       custom-GUID range allocation (pure)
  sql/        rev_*.sql emitter (pure, codestyle-clean)
  db/         read-only acore_world reference reader (IWorldRef + PyMySQL impl)
  gui/        PySide6 main window, canvas, waypoint drawing, panels
tests/        mirrors the pure packages (TDD)
```

The pure core (`model`, `geometry`, `guid`, `sql`) has no Qt or DB dependency and is fully
unit-tested headless. The GUI and DB reader are thin adapters injected at the boundaries.

## Output

A single `rev_<timestamp>.sql` per export writing: `branding_event_def`, `creature`,
`waypoint_data`, `creature_addon`, `creature_formations`, a manual `spawn_group_template` +
`spawn_group`, and the `branding_event_spawn` table that links the event to its group (consumed by
`EventScheduler`). Validate with:

```bash
python ../../../../apps/codestyle/codestyle-sql.py
```
