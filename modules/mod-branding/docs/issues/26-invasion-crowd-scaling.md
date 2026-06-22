# #26 — Invasion crowd scaling (§2.5)

**Status:** complete (`-fsyntax-only` + pytest/ruff + codestyle verified) — dynamic health re-scale + GUI tier-editing are noted refinements · **Deps:** §2.2 group-size core (done, pure); **#10 event-spawn-wiring (merged)**; **#12 persistence (merged)** · **Size:** L

## Progress
- **Pure core** (`src/core/branding/scaling/Invasion*`) — `CrowdTracker`, `ActiveSpawnTiers`/`ReconcileSpawnTiers`, `LiveContainmentGoal`, `InvasionTrashMul`; 18 GoogleTests. **Done.**
- **26a** — `branding_event_spawn` schema (`min_participants`/`goal_contribution`/PK); `InvasionScalingConfig` + conf; EventMgr enrolled roster + decayed-peak `CrowdTracker` + `ParticipantCount`/`EffectiveHeadcount`/`SampleCrowds`; `.branding event status` readout. **Done.**
- **26b** — `EventScheduler` multi-tier reconcile (hysteresis) + live containment goal (`EventMgr::SetGoal`). **Done.**
- **26c** — `InvasionScalingMgr` + `UnitScript` (damage) + `AllCreatureScript` (health): an invasion creature's OUTGOING damage scales by crowd live per hit (boss via §2.2 `EncounterDamageMul`, trash via `InvasionTrashMul`); max health is scaled at spawn (`OnCreatureAddWorld`, snapshot, boss via `EncounterHealthMul`). **Done.**
- **Authoring-tool emitter** (Python) — `SpawnTier` model + `Spawn.tier`; emitter writes the new `branding_event_spawn` columns and one manual spawn group + mapping row **per tier**; the generated SQL passes `codestyle-sql.py`. 41 pytest green, ruff clean. **Done.**
- **Incidental fix** — production `ScalingConfig` was abstract (missing the §2.4.3 currency dials the interface declared); implemented so the worldserver build links. Surfaced by `-fsyntax-only`; module CI runs no full build.
- **Noted refinements (not blocking)** — (1) dynamic health re-scale as the crowd changes (currently a spawn snapshot per §2.3 Risk #4); (2) GUI tier-assignment UI (the model + emitter support tiers; projects can author them via the `.invasion` JSON today).

## Context
Open-world invasions (§9.1 `EventType::Invasion`) have a **fluctuating** population, unlike the
fixed-roster instances §2.2 was written for. So they scale differently (§2.5): the **primary** lever
is spawn **count** (more enrolled players → more mobs), and per-mob difficulty is **asymmetric** —
trash scales gently so a lone straggler can still fight one, while the boss takes the full §2.2
encounter scaling. §2.2's `EncounterHealthMul`/`RewardScaleForGroup` core exists and is unit-tested
but is **wired to nothing yet**; this issue is its first live consumer (boss side).

Decisions taken (owner, design conversation): **both levers, asymmetric**; headcount = **enrolled
participants, decayed peak**; spawn growth = **threshold-gated additive groups**.

## Scope
- **Pure core** `src/core/scaling/invasion/` (TDD, red→green on the standalone target):
  - `IInvasionScalingConfig` (DI): `IntendedInvasionSize`, `CrowdDecaySeconds`, `TrashMaxMul`,
    `TrashExponent`, `TierReleaseMargin`.
  - `CrowdTracker` — decayed-peak headcount over the trailing `CrowdDecaySeconds` window.
  - `ActiveSpawnTiers(thresholds, headcount)` — monotonic active-tier set (additive layering).
  - `InvasionTrashMul(headcount, cfg)` — gentle bounded trash health/damage curve; boss reuses §2.2.
- **Data** (`pending_db_world`): extend `branding_event_spawn` with `min_participants` and
  `goal_contribution`; allow multiple rows per `(zone_id, event_type)`.
- **EventMgr** (#12 touch): per-zone enrolled roster keyed by `ObjectGuid`, `ParticipantCount(zoneId)`,
  drop on leave/logout/event-end; own a `CrowdTracker` per active event.
- **EventScheduler** (#10 touch): load the multi-row spawn table; each tick reconcile active tiers
  with hysteresis (spawn newly-crossed, despawn below `threshold − TierReleaseMargin`); recompute the
  live containment goal as the sum of active tiers' `goal_contribution`.
- **Creature stat hook**: reuse `MasteryEnemyMgr::InActiveInvasion` to gate; classify boss
  (`isWorldBoss`/`IsDungeonBoss`/elite mini-boss) vs trash; apply §2.5.1 mul (boss → §2.2 core).
- **Authoring tool**: emit the new columns + per-tier reinforcement groups (see its SPEC §7).
- **Conf**: the `IInvasionScalingConfig` knobs in `mod_branding.conf.dist`.

## Acceptance
Standard DoD (incl. codestyle-cpp + codestyle-sql). §2.5.5 invariants GoogleTested in the pure core
(straggler-completable, monotonic spawns, capped crowd, reward-stays-§9). End-to-end: an invasion
with two reinforcement tiers spawns only the base camp for a solo player (trash ≈ baseline, boss
scaled), layers in reinforcements as a raid arrives, despawns them (without flapping) as the crowd
thins, and its containment goal tracks the live spawn volume.

## Touch points
New `src/core/scaling/invasion/*` + tests; `EventMgr.*` (roster/`CrowdTracker`),
`EventScheduler.*` (multi-row reconcile), a creature-stat adapter TU, §2.2 `EncounterHealthMul`
(boss reuse), `branding_event_spawn` SQL (`pending_db_world`), `conf/mod_branding.conf.dist`,
`mod_branding_loader.cpp` (register), `ARCHITECTURE.md` §2.5 (done), `tools/invasion-authoring/SPEC.md`.
Extends the **already-merged** #10 single-group wiring (`EventScheduler` reads
`SELECT zone_id, event_type, group_id, map_id FROM branding_event_spawn` today) and the #12
EventMgr persistence — both are in `master`, so this is an in-place extension, not a coordination.
