# #23 — Heroic-tier pure core + currency reward term (§2.4.2/§2.4.3)

**Status:** open · **Epic:** #22 · **Deps:** §2.2 `RewardScale` (extend in place) · **Parallel-safe:** yes (worktree) · **Size:** M

## Context
The heroic overlay (§2.4) is a stat/reward **scalar** that composes onto §2.1/§2.2. All decision logic
is pure and DI-injected — no AzerothCore headers. This issue ships that core and the
currency-specific reward reduction.

## Scope
- **Pure core** `src/core/scaling/heroic/Heroic.{h,cpp}` + `IHeroicConfig`:
  - `SelectedDifficulty { Normal, Heroic }`, `HeroicContext { selected, nativeHeroicMap, maxLevel }`.
  - `double HeroicHealthMul(ctx, cfg)` / `HeroicDamageMul(ctx, cfg)` — **`1.0`** when `Normal` *or*
    `nativeHeroicMap` (never double-scale engine heroic); `> 1.0` only for the overlay path.
  - `uint8_t HeroicLevelTarget(ctx, cfg)` — `maxLevel` when the overlay engages, else unchanged.
  - `uint8_t HeroicTierBonus(ctx, cfg)` — `0` when `Normal`.
- **Extend §2.2 `RewardScale`** with `double currencyMul` (§2.4.3). Currency reduction is **steeper**
  than item reduction: with `r = groupSize/contentSize`, item quantity ∝ `r^0.5` (floor `0.5`),
  `currencyMul` ∝ `r^1.0` (floor `0.05`). Exponents/floors come from `IHeroicConfig`.
- **Tests** `tests/heroic/HeroicTest.cpp` (red→green), asserting the §2.4.5 invariants:
  monotonic-in-difficulty; `currencyMul ≤ item-quantity-fraction` for `r<1`; bounded muls
  (completability under combined small-group + heroic); native-heroic deference (`mul == 1.0`);
  determinism. (CMake globs — no edit.)

## Acceptance
Standard DoD. Core has **no** AzerothCore include. All §2.4.5 invariants covered by GoogleTests on
the standalone fast loop. `currencyMul` provably steeper than gear reduction across the `r ∈ (0,1]`
range.

## Touch points
New `src/core/scaling/heroic/*`, `tests/heroic/*`, the §2.2 `RewardScale` definition + its existing
group-size tests (extend, keep green).
