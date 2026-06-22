# #07 — Mastery adapter (§14)

**Status:** open · **Deps:** none · **Parallel-safe:** yes · **Size:** M

## Context
`core/mastery/Mastery` is tested: `MasteryEffectiveness(accountUnlocked, charLevel)` — the dual-key
(account unlock × character skill, either alone inert; same anti-P2W principle as §1/§7). Needs an
account-unlock layer, a character-level layer, and a consumer.

## Scope
- Define the mastery systems list (what an account can unlock) — start with 1–2 concrete masteries.
- Persistence: `account_mastery` (account, mastery_id, unlocked) + `character_mastery`
  (guid, mastery_id, level). SQL in `pending_db_auth` + `pending_db_characters`.
- Adapter: `MasteryMgr` — load/save both layers; `Effectiveness(account, guid, masteryId)` calls the
  core dual-key.
- A consumer: pick one effect the effectiveness scales (e.g. a small gathering/craft efficiency
  bonus) so the value is observable; surface in `.branding info`.

> **Selection economy is its own issue (#17, ARCHITECTURE.md §14.13).** The Insight unlock currency,
> the gold tuition switch fee, the post-cap-XP→active-school redirect, and the Prestige graduation
> title (`reachedPrestige` → `Player::SetTitle`) live in #17, not here. This issue stays the
> account-unlock × char-level *effectiveness* adapter; #17 consumes it for school selection.

## Acceptance
- Standard DoD (incl. codestyle-sql). Account-unlock-only and char-level-only both yield 0 effect;
  both present scales it (mirror the core tests in-world).

## Touch points
`src/Mastery*.*` (new), both `pending_db_*` SQL. Independent.
