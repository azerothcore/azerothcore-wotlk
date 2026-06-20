# #01 — Brand Knowledge unlock flow (§6)

**Status:** open · **Deps:** none · **Parallel-safe:** yes · **Size:** S–M

## Context
Brand **proficiency** is per-character but gated by account-wide **Knowledge** (§6, anti-P2W §1).
The `account_brand_knowledge` table and the `CanEarnProficiency` / `CanExpressBrand` core gates
exist, but nothing ever *populates* knowledge — so today every character earns 0 XP and every
effect resolves to 0. This issue defines how an account unlocks a brand.

## Scope
- Decide + implement the unlock trigger (design open question §12.5): pick one to start —
  recommended a GM/debug grant now, with a quest/economy hook stubbed for later.
- Pure core (if any new rules): extend `core/proficiency/Knowledge.*` only if logic is needed
  (e.g. unlock prerequisites); most of this is adapter + DB.
- Adapter: a `KnowledgeMgr` (or extend `ProficiencyMgr`) that loads/saves `account_brand_knowledge`
  and exposes `UnlockBrand(accountId, brand)` writing the row + updating the in-memory mask.
- Command: `.branding knowledge grant <brand>` / `.branding knowledge list` (RBAC debug).
- Make `ProficiencyMgr` refresh the account mask after an unlock (so earning works immediately).

## Acceptance
- Standard DoD. New GoogleTests if any core rule is added.
- After `.branding knowledge grant`, the demo kill hook earns XP and `.branding info` shows level>0
  and non-zero effect strength.

## Touch points
`src/*` (new `KnowledgeMgr.*` or `ProficiencyMgr` edits), `src/BrandingCommandScript.cpp`,
existing `account_brand_knowledge` table.
