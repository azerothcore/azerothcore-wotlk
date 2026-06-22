# #19 — Gold tuition & active-school switch (§14.13.2)

**Status:** open · **Epic:** #17 · **Deps:** `LoadoutMgr::SetActiveBrand` (present), Knowledge gate (present) · **Parallel-safe:** yes (worktree) · **Size:** M

## Context
§14.13.2: one **active school** at a time; switching costs an **escalating gold tuition**. Re-selecting
an already-known school is **gold-only, Proficiency retained** (per-school rows persist). A never-known
school requires the Insight unlock first (#18).

## Scope
- **Pure core** `src/core/branding/selection/Tuition.{h,cpp}` + `ISelectionConfig`:
  - `uint64_t TuitionCost(uint32_t recentSwitches, ISelectionConfig const&)` — escalating
    (`base * factor^recentSwitches`, **capped**), base for first switch. Monotonic non-decreasing,
    bounded; deterministic.
- **Tests** `tests/selection/TuitionTest.cpp` (red→green): first-switch = base, escalation, cap,
  determinism.
- **Adapter** `src/SelectionMgr.{h,cpp}` (or extend the loadout path): `.branding school select <school>`:
  1. gate on account Knowledge (`CanEarnProficiency` via existing mgr); if **not** unlocked → reject
     with a message pointing at Insight (#18) — do **not** charge.
  2. if unlocked → compute `TuitionCost(recentSwitches)`, charge gold (`Player::ModifyMoney`, fail if
     insufficient), `LoadoutMgr::SetActiveBrand`, bump the per-char recent-switch counter.
  - **Proficiency is never wiped** (per-school rows already persist) — retention is the default.
- **SQL** `pending_db_characters`: `character_branding_switch (guid, recent_switches, last_switch_unix)`
  (or add columns) — counter decays after `SwitchDecayDays`.
- **Command**: `schoolCommandTable { "select" }` under `.branding`.
- **Conf**: `Branding.Selection.Enable`, `TuitionBase`, `TuitionFactor`, `TuitionCap`, `SwitchDecayDays`.

## Acceptance
Standard DoD. Re-select known school = gold-only, Proficiency intact, escalating tuition; never-known
school rejected (no charge) until Insight-unlocked. Tuition curve GoogleTested.
