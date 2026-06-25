# #14 — XP-source balance regression sim (§8.5)

**Status:** in progress · **Deps:** none (code) · **UNBLOCKED** (profile + curve ratified 2026-06-25) · **Parallel-safe:** yes · **Size:** M

## Context
§8.5 sets a target XP mix — **Questing 45% · Professions 25% · Exploration 20% · Discoveries 10%** —
enforced as a deterministic regression test so tuning can't silently make questing obsolete. This is
the mechanical guard behind the §9.7 "don't remove structured content" warning.

## Resolved design input (owner-ratified — was the blocker)
- **Prestige rank curve = geometric.** `rankCost(n) = RankBaseXp × RankGrowth^(n-1)`, **+1%/rank**
  (`RankGrowth = 1.01`), **50 ranks**, base `RankBaseXp = 1,670,800` (the live 3.3.5a level-79→80 XP
  requirement). Full ladder ≈ **107.7M** Proficiency-XP. Replaces the old power-law `BaseXp × n^Exponent`
  (§7.4). Prestige = hitting max Proficiency level, so this *is* the §7.4 curve.
- **Redirect = 1:1, no separate prestige multiplier.** Post-cap player XP → Proficiency XP at 1:1, so the
  prestige track inherits the §10.1 per-source rates as-is. Pacing is shaped by the rank curve, not a
  throttled stream (§14.13.3).
- **Representative play-session profile.** ≈ **1.20M XP/day** at production rates, split
  Questing 538k · Professions 299k · Exploration 239k · Discoveries 120k → `107.7M ÷ 1.20M ≈ 90 days`.
  The sim is the arbiter; re-tuning the profile re-derives both shares and pacing.
- **Invasions:** sub-max → normal leveling XP; containment grants quest-equivalent XP at **quest-rate
  ×5/×7** (`InvasionRate == QuestRate`), folded into the **Questing** bucket (§8.5, §10.1).
- **Anti-leech (§9.3 guardrail 3): config-gated, default OFF in v1** — v1 allows flat AFK-split; gate code
  + Risk #7 tests ship now, enforcement flips on later via config.

## Scope
- Pure: a `core/branding/economy/BalanceShares` aggregation (per-source totals → normalized shares,
  `Largest()`). `XpSource = { Questing, Professions, Exploration, Discoveries }`.
- Test (`tests/economy/BalanceSimTest.cpp`): feed the ratified profile through the XP sources **at
  production rates** (§10.1) and assert each share is within tolerance of target, with `share(Questing)`
  the largest — `BalanceSim_HoldsAtProductionRates` (5x/7x, not 1x; Risk #2).
- **Prestige-pacing assertion (§14.13.6):** `BalanceSim_TimeToPrestige_NearThreeMonths` —
  `XpForLevel(MaxLevel) ÷ dailyProficiencyXp` within tolerance of ~90 days for the same profile.

## Acceptance
- Standard DoD. The regression tests are part of the standalone GoogleTest suite and are deterministic.

## Touch points
`src/core/branding/economy/BalanceShares.*` (new, pure), `tests/economy/BalanceSimTest.cpp`,
`tests/economy/BalanceSharesTest.cpp`. Curve change: `core/branding/common/Config.h`,
`core/branding/proficiency/Proficiency.cpp`, `src/BrandingConfig.*`, `tests/fakes/FakeConfig.h`.
