# #14 — XP-source balance regression sim (§8.5)

**Status:** open · **Deps:** none (code) · **BLOCKED on design input** · **Parallel-safe:** yes · **Size:** M

## Context
§8.5 sets a target XP mix — **Questing 45% · Professions 25% · Exploration 20% · Discoveries 10%** —
enforced as a deterministic regression test so tuning can't silently make questing obsolete. This is
the mechanical guard behind the §9.7 "don't remove structured content" warning.

## Blocked on
A **representative play-session profile** (how much time/activity a typical player spends per source)
is required to compute shares against. This is a tuning artifact the owner must sanity-check — see
ARCHITECTURE.md §8.5 / Open Questions. Do not invent it silently.

## Scope (once the profile is agreed)
- Pure: a `core/economy/BalanceShares` aggregation (per-source totals → normalized shares).
- Test: feed the agreed profile through the XP sources **at production rates** (§10.1) and assert
  each share is within tolerance of target, with `share(Questing)` the largest. Fails if profession/
  discovery tuning drifts.
- Run the sim at the configured 5x/7x baseline (not 1x) — the ratio is rate-coupled (Risk #2).
- **Prestige-pacing assertion (§14.13.6):** the *same* representative profile drives the post-cap
  XP→Proficiency rate. Add a second assertion that **time-to-Prestige for one school stays within
  tolerance of ~3 months** (and unlock ~1 month) for that profile — so the §14.13.6 pacing contract is
  CI-gated, not a hope. Shares the profile artifact below.

## Acceptance
- Standard DoD. The regression test is part of the standalone GoogleTest suite and is deterministic.

## Touch points
`src/core/economy/BalanceShares.*` (new, pure), `tests/economy/`. Needs the owner's profile first.
