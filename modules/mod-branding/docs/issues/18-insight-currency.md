# #18 — Insight currency (Knowledge-unlock economy, §14.13.1)

**Status:** open · **Epic:** #17 · **Deps:** existing knowledge-unlock path (#01, present) · **Parallel-safe:** yes (worktree) · **Size:** L

## Context
§14.13.1 defines **Insight**: a per-`(account, school)` **non-tradeable DB point counter** (§16.3
exception — *not* an item, *not* a currency table). Spending the unlock threshold writes the permanent
`account_brand_knowledge` row (reuse the existing unlock path). Earned from kills with **account-wide
diminishing returns**.

## Scope
- **Pure core** `src/core/branding/insight/Insight.{h,cpp}` + `IInsightConfig`:
  - `double InsightForKill(SourceRank rank, uint32_t priorThisWindow, IInsightConfig const&)` —
    raid boss ≈ `1.0`; dungeon boss DR'd (`0.5, 0.25, …`, heroic > normal); generic mote tiny.
    **Non-increasing** in `priorThisWindow`, bounded ≥ 0, fractional allowed.
  - `bool UnlockReached(double points, IInsightConfig const&)` — threshold (default ~30–40).
  - DR window decays via injected clock (mirror §7.4 BrandXp DR).
- **Tests** `tests/insight/InsightTest.cpp` (red→green): DR monotonic non-increasing, account-wide
  window, threshold reached, fractional accrual, determinism. (CMake globs — no edit.)
- **Adapter** `src/InsightMgr.{h,cpp}` (+ `InsightConfig`): per-`(account, school)` fractional cache
  keyed by **account id**; load/save; `Earn(account, school, rank)` applies the core DR (window is
  **account-wide**, reuse the Slice 3 `AccountCeiling` if it fits); on `UnlockReached` → write the
  permanent Knowledge row via the existing unlock path and refresh `ProficiencyMgr`'s mask.
- **Hooks** `src/InsightScripts.cpp`: creature-kill hook → amount by `Creature` rank
  (`isWorldBoss`/`GetCreatureTemplate()->rank`); **school resolution** = config-mappable (default by
  creature/zone) — full boss→school *data* table is deferred. Trash → very-low-rate generic **mote**
  feeding the active/wildcard school.
- **Command** `.branding insight` (list per-school points; `grant` debug) — new `insightCommandTable`.
- **SQL** `pending_db_auth`: `account_insight (account, school, points, window_start, window_units)`.
- **Conf**: `Branding.Insight.Enable`, thresholds, DR factors, mote chance, window seconds.

## Acceptance
Standard DoD. Insight provably non-tradeable (DB only). Account-wide DR (no alt-farm). Reaching
threshold unlocks the permanent Knowledge row once (idempotent). Core DR/threshold GoogleTested.
