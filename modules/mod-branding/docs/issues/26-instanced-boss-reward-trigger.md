# #26 — Instanced boss-reward trigger (§2.4)

**Status:** open · **Epic:** #22 · **Deps:** #25 (`RewardModifiers`, `BumpTier`) · **Parallel-safe:** yes (worktree) · **Size:** S

## Context
The piece #25 deferred: the actual on-kill trigger that grants the heroic/small-group reward. Kept a
**self-contained instanced stream** — it does NOT touch `EventMgr` / the §9 invasion contribution
rewards. On an instance boss death every present player gets a personal branding-currency grant
(no tagging), so a heroic run pays more and a trivialised small-group clear pays the floored amount.

## Scope
- **Pure core** `core/branding/contribution/RewardTier`: `uint32_t BaseBossCurrency(RewardTier)` — the
  per-tier copper schedule (None 0 < Bronze < Silver < Gold). Tested.
- **Adapter** `HeroicMgr::BossCurrencyReward(Creature* boss)` — 0 unless the boss-reward gate is on,
  the creature `IsDungeonBoss()`/`isWorldBoss()`, and it's in an instance. Base tier by rank
  (world boss → Gold, raid → Silver, dungeon → Bronze), then `BumpTier(base, heroicTierBonus)`, then
  `× BossReward.CurrencyMultiplier × currencyMul` (group-size reduction from `RewardModifiersFor`).
- **Hook** `HeroicScripts.cpp`: `PlayerScript::OnPlayerCreatureKill` → grant the flat per-player amount
  to every non-GM player in the instance via `Player::ModifyMoney` (personal, fires once per boss
  death).
- **Conf**: `Branding.Heroic.BossReward.Enable` (opt-in, separate from the scaling gate) and
  `Branding.Heroic.BossReward.CurrencyMultiplier`.
- **SQL**: none.

## Acceptance
Standard DoD. `BaseBossCurrency` GoogleTested (strictly increasing, None = 0). With the gate on: an
instance boss death grants each present player currency that is higher on a heroic run (tier bump) and
reduced for a small group (steeper-than-gear `currencyMul`); 0 when the gate is off or the creature is
not an instance boss. No `EventMgr` edit; heroic and invasion reward streams stay separate.

## Notes
Currency-only baseline (gear stays engine loot). A richer instanced personal-loot table (items,
diversity) is future work under the broader §2.2 instanced-reward design.

## Touch points
`src/core/branding/contribution/RewardTier.{h,cpp}`, `tests/contribution/RewardTierTest.cpp`,
`src/HeroicConfig.{h,cpp}`, `src/HeroicMgr.{h,cpp}`, `src/HeroicScripts.cpp`,
`conf/mod_branding.conf.dist`.
