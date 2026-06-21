# #06 — Account vault adapter (§13)

**Status:** open · **Deps:** none · **Parallel-safe:** yes · **Size:** M

## Context
`core/vault/Vault` is tested: `VaultTransferCost` (base + per-unit friction) and `VaultCanStore`
(capacity). Needs a storage backend + UI so alts share an account-bound stash with deposit friction.

## Scope
- SQL (`pending_db_auth`, account-scoped): `account_vault` (account, slot, item_entry, count) +
  capacity from config (`IVaultConfig` already defines it).
- Adapter: `VaultMgr` — load/save account vault; deposit/withdraw with `VaultCanStore` capacity check
  and `VaultTransferCost` charged (deduct money/resource) on deposit.
- UI: a gossip NPC (GameObject/Creature `GossipScript`) for deposit/withdraw, or commands for v1.
- Reuse `RewardDelivery` for withdraw-to-inventory (mail fallback).

## Acceptance
- Standard DoD (incl. codestyle-sql). Capacity + transfer-cost enforced; vault shared across the
  account's characters.

## Touch points
`src/Vault*.*` (new), `pending_db_auth` SQL, gossip script. Fully independent.
