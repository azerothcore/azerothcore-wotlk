# mod-branding — Work Backlog (for parallel development)

Each file in this directory is a self-contained issue an agent can pick up independently. The module
is built so this is safe: **pure cores** (`src/core/<system>/`, no AzerothCore deps, GoogleTest) and
**thin adapters** (`src/`, one feature per translation unit, registered via `mod_branding_loader`).

See [../ARCHITECTURE.md](../ARCHITECTURE.md) for the full spec. Section refs (§N) point there.

## Done (do not re-do)

- Pure cores for all 9 slices — 87+ GoogleTests (`tests/`, standalone fast loop).
- Adapters wired + compile-verified: proficiency XP, discovery XP, zone downscaling, dynamic events
  (scoring/guardrails/containment/tier), reward claim (diversity + account ceiling), reward delivery
  (inventory + mail fallback), allegiance, economy/crafting, item-branding, effects, catalyst, addon
  protocol, vault, the **mastery stack** (`MasteryMgr`/`MasteryCombat`/`MasteryEnemy`/`MasteryLoadout`),
  loadout (`SetActiveBrand`), and the `.branding` command surface incl. `knowledge grant/list`.
- SQL: `character_branding`, `account_brand_knowledge`, mastery + allegiance + economy tables.

> **Re #01 / #07:** effectively in place — `MasteryMgr` is wired (#07) and `.branding knowledge grant`
> exists (#01's bootstrap). The §14.13 *economy* unlock path is the remaining work, tracked under the
> #17 epic below, **not** by re-doing #01/#07.

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
                                                       ├▶ #05 item-branding-adapter
                                                       └▶ #16 exotic-brand-schools (enum/spec groundwork done; flavour needs #03)

  (selection economy — #17 epic, children parallel-safe in worktrees)
   #17 ─┬▶ #18 insight-currency        (pure DR core + InsightMgr + kill hooks)
        ├▶ #19 tuition-school-switch    (pure tuition curve + .branding school select)
        ├▶ #20 postcap-xp-redirect      (OnPlayerGiveXP → active-school Proficiency)
        └▶ #21 prestige-titles          (max Proficiency → Player::SetTitle)
   shared integration files only: mod_branding_loader.cpp, BrandingCommandScript.cpp, conf .dist

  (heroic overlay — #22 epic, extends §2.2/§2.4; reference autobalance, do NOT import per §2.3)
   #22 ─┬▶ #23 heroic-tier-core        (pure HeroicContext muls + RewardScale.currencyMul)
        ├▶ #24 heroic-overlay-adapter   (read SELECTED difficulty, encounter scale, snapshot, exceptions) ◀ needs #23
        ├▶ #25 heroic-reward-modifiers   (BumpTier + currencyMul exposure; decoupled from EventMgr)       ◀ needs #23
        └▶ #26 instanced-boss-reward     (OnPlayerCreatureKill -> per-player currency grant)              ◀ needs #25

  (economy content — fills the #09 loop; #27 server-data, #29 client-coupled)
   #09 economy-crafting ─▶ #27 branded-item-content   (item_template + branding_recipe mirror + bind + upgrade curve; no client patch)
                            └▶ #29 native-profession-crafting  (Spell.dbc craft spells + skill_line_ability + BoP patterns + MPQ) ◀ needs #27

  (invasion crowd scaling — #28, extends §2.2; first live consumer of the §2.2 boss core)
   #10 event-spawner ─┐
   #12 persistence   ─┴▶ #28 invasion-crowd-scaling (pure CrowdTracker/ActiveSpawnTiers/trash curve;
                                                     EventMgr roster; multi-row branding_event_spawn)
```

`*` #14 needs a design decision (play-session profile) before it can be finalized — see the issue.

## Suggested parallel batches

- **Batch A (no deps, highest leverage):** #01 knowledge-unlock, #02 active-brand-loadout,
  #12 persistence-layer, #11 zone-bracket-table.
- **Batch B (independent features):** #06 vault, #07 mastery, #08 allegiance, #09 economy.
- **Batch C (after #02→#03):** #04 catalyst, #05 item-branding.
- **Batch D (content/infra, anytime):** #10 event-spawner, #13 world-spawn-content, #15 full-build-ci,
  #27 branded-item-content (server data; #09's loader is shipped). #29 native-profession-crafting is
  client-coupled (Spell.dbc/MPQ) — schedule after #27.
- **Batch E (groundwork done, flavour after #03):** #16 exotic-brand-schools.
- **Batch F (selection economy, after #01+#07):** #17 mastery-selection-economy.
- **Batch G (heroic overlay):** #23 heroic-tier-core first (pure), then #24 + #25 in parallel worktrees.
- **Batch H (invasion crowd scaling):** #28 — **complete**: pure `src/core/branding/scaling/Invasion*`,
  EventMgr roster + EventScheduler multi-tier reconcile, `InvasionScalingMgr` live damage + dynamic
  health, the authoring-tool `SpawnTier` emitter, and the GUI tier editor.
- **Needs design input:** #14 xp-balance-sim; #17 has open *[DEFAULT]* decisions (title path, tuition curve).

## Cross-cutting note

`#10 event-spawner`, `#12 persistence-layer`, and `#04/#05` all touch `EventMgr`/`ProficiencyMgr`.
To avoid merge churn, persistence (#12) should land first or coordinate; the others add new files
where possible rather than editing the managers.

**Naming/vocabulary framework (GitHub #35 → `ARCHITECTURE.md` §16):** the economy/branding cluster
(#04 catalyst, #05 item-branding, #06 vault, #09 economy) shares one canonical vocabulary and naming
convention. Read §16 before adding resources, tables, config keys, or player strings. Settled there:
resources are item-entry-backed (§16.3, not a currency table); "Catalyst" means **only** the raid
stacking-DR mechanic (§16.2); progression nouns are Knowledge / Proficiency Level / Brand Rank;
tables follow `branding_<noun>` (world def) vs `<entity>_branding[_detail]` (per-entity state).
