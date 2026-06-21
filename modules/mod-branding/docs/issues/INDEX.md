# mod-branding — Work Backlog (for parallel development)

Each file in this directory is a self-contained issue an agent can pick up independently. The module
is built so this is safe: **pure cores** (`src/core/<system>/`, no AzerothCore deps, GoogleTest) and
**thin adapters** (`src/`, one feature per translation unit, registered via `mod_branding_loader`).

See [../ARCHITECTURE.md](../ARCHITECTURE.md) for the full spec. Section refs (§N) point there.

## Done (do not re-do)

- Pure cores for all 9 slices — 87 GoogleTests (`tests/`, standalone fast loop).
- Adapters wired + compile-verified: proficiency XP, discovery XP, zone downscaling, dynamic events
  (scoring/guardrails/containment/tier), reward claim (diversity + account ceiling), reward delivery
  (inventory + mail fallback), `.branding` command surface.
- SQL: `character_branding`, `account_brand_knowledge`.

## Standard Definition of Done (every issue)

1. **Spec first** — update `ARCHITECTURE.md` if behaviour changes.
2. **TDD** — pure logic goes in `src/core/<system>/` with failing GoogleTests first (red→green) on
   the standalone target; adapters stay thin.
3. **Compile-verify** — `cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON` then
   `g++ -fsyntax-only` each touched adapter TU with its `compile_commands.json` flags.
4. **Purity** — nothing under `src/core/` may include an AzerothCore header.
5. **Lint** — `apps/codestyle/codestyle-cpp.py` and (if SQL) `codestyle-sql.py` clean.
6. **No raw `Player*`/`Creature*` stored past a call** — key caches by `ObjectGuid`.
7. Conventional commit; do not push without owner sign-off.

## Dependency graph

```
  (independent — start any time, in parallel)
   #01 knowledge-unlock      #06 vault-adapter       #08 allegiance-adapter
   #09 economy-crafting      #10 event-spawner       #11 zone-bracket-table
   #12 persistence-layer     #13 world-spawn-content  #14 xp-balance-sim*
   #15 full-build-ci         #07 mastery-adapter

  (chain — effect application stack)
   #02 active-brand-loadout ─▶ #03 effect-application ─┬▶ #04 catalyst-adapter
                                                       └▶ #05 item-branding-adapter
```

`*` #14 needs a design decision (play-session profile) before it can be finalized — see the issue.

## Suggested parallel batches

- **Batch A (no deps, highest leverage):** #01 knowledge-unlock, #02 active-brand-loadout,
  #12 persistence-layer, #11 zone-bracket-table.
- **Batch B (independent features):** #06 vault, #07 mastery, #08 allegiance, #09 economy.
- **Batch C (after #02→#03):** #04 catalyst, #05 item-branding.
- **Batch D (content/infra, anytime):** #10 event-spawner, #13 world-spawn-content, #15 full-build-ci.
- **Needs design input:** #14 xp-balance-sim.

## Cross-cutting note

`#10 event-spawner`, `#12 persistence-layer`, and `#04/#05` all touch `EventMgr`/`ProficiencyMgr`.
To avoid merge churn, persistence (#12) should land first or coordinate; the others add new files
where possible rather than editing the managers.
