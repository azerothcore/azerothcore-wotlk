# #04 — Catalyst stacking adapter (§7.9 / Slice 4)

**Status:** open · **Deps:** #03 (effect application) · **Parallel-safe:** after #03 · **Size:** M

## Context
`core/catalyst/CatalystStacking` (`CatalystStackWeight`, `RaidCatalystMultiplier`) is tested: 1st
specialist full, 2nd reduced, 3rd+ heavy, bounded `[1, MaxRaidMul]`, non-increasing in rank. It
needs to be applied to a raid.

## Scope
- Raid scan: for a player's group/raid, count same-role branded allies and assign each a **rank**
  (stable ordering — e.g. by GUID) so `CatalystStackWeight(rank)` is deterministic per encounter.
- Feed the rank into the §7.9 `RaidMultiplier` applied by the effect layer (#03) — i.e. the
  RaidWindow effect's magnitude is scaled by the catalyst weight.
- **Snapshot timing (Risk #4 / `GroupSize_SnapshotAtGrant_NotPull`):** sample the same-role count at
  effect-apply time (or averaged), NOT at pull/enroll, so stacking can't be gamed. Reference
  mod-autobalance's exploit (study, do not import — §2.3).

## Acceptance
- Standard DoD. A core test already covers the curve; add an integration/seam test for the
  rank-assignment + snapshot-timing rule.
- Manual verify: 1 branded specialist = full raid effect; a 2nd of the same role visibly reduced.

## Touch points
`src/Catalyst*.*` (new), consumes #03's effect layer + group APIs. Depends on #03 landing first.
