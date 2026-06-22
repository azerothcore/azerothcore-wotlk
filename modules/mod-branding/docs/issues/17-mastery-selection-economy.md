# #17 — Mastery selection economy (Insight · tuition · post-cap XP · titles)

**Status:** open · **Deps:** #01 (Knowledge unlock), #07 (mastery effectiveness) · **Parallel-safe:** partial · **Size:** L

## Context
ARCHITECTURE.md §14.13 defines the acquisition spine for school selection:
**enroll → study → graduate**. The pieces (`account_brand_knowledge`, per-`(char, brand)` Proficiency,
`XpResult::reachedPrestige`, the §14.5 friction) all exist; nothing wires them into a player loop yet.

## Scope
- **Insight currency (§14.13.1):** a per-`(account, school)` **DB point counter** (NOT an item, NOT a
  currency table — §16.3 exception). Earn from raid bosses (~1/boss), dungeon bosses (heroic>normal,
  per-kill DR), and a very-low-rate generic world mote feeding the active/wildcard school. **DR is
  account-wide** (reuse the Slice 3 account ceiling). Spending the unlock threshold (~30–40, config)
  writes the permanent Knowledge row (#01).
- **Gold tuition (§14.13.2):** charge gold to switch the active school; escalating with recent switch
  frequency (anti-flip-flop). Re-selecting an already-known school is **gold-only, Proficiency
  retained**; a never-known school is Insight unlock + tuition, Proficiency starts at 0.
- **Post-cap XP redirect (§14.13.3):** adapter hooks the XP-gain path; at max player level, route XP
  into the **active** school's Proficiency only. Thin adapter over existing §7 core — no new pure logic.
- **Prestige title (§14.13.4):** on `reachedPrestige`, grant a per-character title via
  `Player::SetTitle`. **Decide the title path first:** repurpose spare `CharTitles.dbc` IDs (server-only,
  v1 default) vs custom DBC patch (literal "the Fire-Branded", client distribution cost). Capstone title
  for all-schools-maxed.
- **Commands:** `.branding school select <school>` / `.branding insight` (show per-school points) under
  the existing `.branding` tree; player strings use §16.1 nouns (Knowledge / Insight / tuition).

## Pure core (if any)
Most is adapter + DB. Add pure helpers only where logic is real and testable: Insight DR curve
(`InsightForKill(rank, recentInWindow, cfg)`), escalating tuition (`TuitionCost(recentSwitches, cfg)`),
unlock-threshold check. Write failing GoogleTests first (red→green) on the standalone target.

## Persistence
- `account_insight` (account, school, points) — `pending_db_auth`.
- Switch/tuition + post-cap accrual reuse `account_brand_knowledge` and `character_branding`.
- Title state derivable from `character_branding` (no new table needed for v1).

## Acceptance
- Standard DoD (incl. codestyle-sql). Account-wide DR holds across alts. Re-select known school is
  gold-only and retains Proficiency. Insight is provably non-tradeable. Mirror the §14.13 invariants
  in-world; pure DR/tuition curves covered by GoogleTests.
- **Pacing (§14.13.6):** unlock ≈1 month, Prestige ≈3 months on the active school. The numeric
  calibration of the post-cap XP→Proficiency rate is gated by the **#14 sim** against the shared
  play-session profile — keep that rate behind config so #14 can pin it.

## Touch points
`src/*` (new `InsightMgr.*`, tuition + post-cap hooks, title grant), `src/BrandingCommandScript.cpp`,
`src/core/branding/<...>` (DR/tuition helpers), `pending_db_auth` SQL. Coordinates with #01/#07.
