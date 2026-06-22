# #25 — Heroic reward wiring (currency reduction + tier bonus) (§2.4.3/§9.4)

**Status:** open · **Epic:** #22 · **Deps:** #23 (heroic core, `RewardScale.currencyMul`) · **Parallel-safe:** yes (worktree) · **Size:** M

## Context
Delivers the reward side of §2.4: the branding-currency reduction for small groups ("especially for
branding currency") and the heroic tier/quantity bump, both through the **existing §9.4 personal-loot
delivery path** (per player, no tagging). No new currency representation — branding resources stay
item-entry-backed (§16.3).

## Scope
- **Adapter** wiring in the reward-grant path:
  - On boss/event reward grant, build the `RewardScale` (§2.2 group fraction `r`) and apply
    `currencyMul` to the **branding-currency** component specifically (gear uses `materialQuantity`/
    `maxTier` as today); steeper currency curve from #23.
  - Apply the §2.4 `HeroicTierBonus` to bump tier/quantity/currency up when the heroic overlay engaged
    for the run.
  - Compose with the **contribution** path: per-player currency = `base × currencyMul × heroicBonus ×
    contributionShare` (reuse §9.3/§9.4); deliver via the §9.4 chest→inventory→mail-fallback path.
- **Conf** currency floor/exponent + heroic currency-bonus knobs (defaults: item `r^0.5` floor `0.5`;
  currency `r^1.0` floor `0.05` — the "steep" tuning).
- **SQL** only if a grant-log/audit row is needed (`pending_db_characters`, idempotent DELETE+INSERT).

## Acceptance
Standard DoD. A 5-man MC clear grants ≈⅛ the branding currency of a full 40-man, and the currency
reduction is provably steeper than the item-quantity reduction at the same `r`. Heroic runs grant a
strictly higher tier/currency than the equivalent normal run. Per-player (personal loot), unexploitable
by stacking/dropping members at the kill (snapshot from #24).

## Touch points
The reward-grant adapter (§9.4 delivery + §9.3 contribution), `RewardScale` consumers,
`conf/mod_branding.conf.dist`, optionally `pending_db_characters/`.
