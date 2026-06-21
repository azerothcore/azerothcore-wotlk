# #05 — Item branding adapter (§7.9)

**Status:** open · **Deps:** #02 (loadout), #03 (effect application) · **Parallel-safe:** after deps · **Size:** L

## Context
`core/effects/ItemBrand` is tested: `ItemEffectIntensity` (behaviour/proc intensity, monotonic in
step/level), `ApplyItemUpgrade` (fills levels, advances steps, caps), `ItemMaxCumulativeCost <
account-Knowledge cost`, `ResolvedItemEffectIntensity` (anti-P2W). Needs server wiring.

## Scope
- Persistence: per-item brand state (`item_branding` keyed by item GUID): brand, step, level_in_step.
  SQL in `pending_db_characters`.
- Upgrade flow: spend economy resources (reuse `core/economy` + the reward/economy plumbing) to call
  `ApplyItemUpgrade`; a gossip/command entry point. Enforce `ItemMaxCumulativeCost` ordering.
- Application: `ItemEffectIntensity` modifies the item's **proc behaviour/frequency** (NOT flat
  stats — §1) via the effect layer (#03) and the player's selected archetype (#02). Gate with
  `ResolvedItemEffectIntensity` (inert without the current account's Knowledge → trading stays safe).
- Tradeable: upgrade state travels with the item; verify a traded maxed item is inert without access.

## Acceptance
- Standard DoD (incl. codestyle-sql). Manual verify: upgrading raises proc intensity (not stats);
  a traded maxed item does nothing on an account lacking the brand Knowledge.

## Touch points
`src/ItemBranding*.*` (new), `pending_db_characters` SQL, effect layer (#03), loadout (#02).
Large — split upgrade-flow vs proc-application if needed.
