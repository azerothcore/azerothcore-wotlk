# #25 — Heroic reward modifiers (currency reduction + tier bump) (§2.4.3/§2.4.2)

**Status:** open · **Epic:** #22 · **Deps:** #23 (`RewardScale.currencyMul`), #24 (`HeroicMgr`) · **Parallel-safe:** yes (worktree) · **Size:** S–M

## Context
The reward side of §2.4: the branding-currency reduction for small groups ("especially for branding
currency") and the heroic tier bump. **Decoupled from the §9 invasion/event reward stream** — that
`EventMgr::ResolveReward` path is open-world contribution and is owned by the invasion-scaling work.
Heroic rewards are **instanced** content, so #25 ships reusable pure logic + a `HeroicMgr` exposure
that a future instanced boss-reward trigger consumes, and does **not** edit `EventMgr`.

No new currency representation — branding resources stay item-entry-backed (§16.3).

## Scope
- **Pure core** `core/branding/contribution/RewardTier`: `RewardTier BumpTier(RewardTier base,
  uint8_t bonus)` — advance a tier by the heroic bonus, capped at Gold; `None` stays `None` (heroic
  bumps an *earned* reward, never conjures one). Tests in `tests/contribution/RewardTierTest.cpp`
  (advance+cap, identity at bonus 0, None floor, monotonic in bonus). The currency-steepness math is
  already proven in #23 (`RewardScale.currencyMul`).
- **Adapter exposure (no EventMgr):**
  - `ScalingMgr::CurrencyMulForGroup(groupSize, contentSize)` — the §2.4.3 currency multiplier from
    the instance body-count vs intended size (independent of `Branding.Scaling.Enable`).
  - `HeroicMgr::RewardModifiersFor(Map*)` → `{currencyMul, tierBonus}` — resolves the instance's body
    count + intended size + heroic tier bonus into the adjustments a reward trigger applies as
    `tier = BumpTier(base, mods.tierBonus); currency = round(base * mods.currencyMul)`. Identity
    outside instances / when disabled.
  - `.branding heroic` surfaces the resolved modifiers (demonstration).
- **Conf**: reuses the #23/#24 dials (`Branding.Scaling.CurrencyReductionExponent/CurrencyMulFloor`,
  `Branding.Heroic.TierBonus`). No new keys.
- **SQL**: none.

## Out of scope (deferred)
The **instanced boss-reward trigger** that calls `RewardModifiersFor` on a boss kill and delivers via
the §9.4 personal-loot path. That belongs with the §2.2 instanced-reward wiring (still open) and must
not be grafted onto the §9 event stream. #25 provides the building blocks; the trigger is its own issue.

## Acceptance
Standard DoD. `BumpTier` GoogleTested. `RewardModifiersFor` returns a steeper-than-gear `currencyMul`
for a small group (e.g. 5-in-40 lands on the floor) and a non-zero `tierBonus` only for a heroic run;
identity outside instances. No `EventMgr` edit; heroic and invasion reward streams stay separate.

## Touch points
`src/core/branding/contribution/RewardTier.{h,cpp}`, `tests/contribution/RewardTierTest.cpp`,
`src/ScalingMgr.{h,cpp}`, `src/HeroicMgr.{h,cpp}`, `src/BrandingCommandScript.cpp`.
