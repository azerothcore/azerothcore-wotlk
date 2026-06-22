# #21 — Prestige titles (graduation, §14.13.4 / §11)

**Status:** open · **Epic:** #17 · **Deps:** `ProficiencyMgr::BrandLevel` (present), `reachedPrestige` (present) · **Parallel-safe:** yes (worktree) · **Size:** M

## Context
§14.13.4: hitting **max Proficiency** in a school grants a per-character cosmetic title
("[Name] the Fire-Branded"). Capstone title for all-schools-maxed. Trade-safe (cosmetic, no power).

## Decision (v1 default — §14.13.4)
**Repurpose spare/unused `CharTitlesEntry` IDs** the 3.3.5a client already ships — **server-only, no
client patch**. Title id per school is **config-mapped** (`Branding.Prestige.TitleId.<School>`), so a
later custom-`CharTitles.dbc` patch can swap in literal "the Fire-Branded" strings with no code change.
Document the chosen spare IDs as placeholders.

## Scope
- **Adapter** `src/PrestigeMgr.{h,cpp}` + `src/PrestigeScripts.cpp` — **do not edit `ProficiencyMgr`**
  (keeps this independent of #20). `PrestigeMgr::CheckAndGrant(Player*)`:
  - for each brand, if `sProficiencyMgr->BrandLevel(guid, brand) >= MaxLevel(cfg)` and the title isn't
    already set → `Player::SetTitle(sCharTitlesStore.LookupEntry(configuredId))`, idempotent.
  - if **all** brands maxed → grant the capstone title.
  - Call from `OnLogin` (catch-up) and a low-frequency post-activity trigger (e.g. `OnLevelChanged`
    / periodic) — cheap and idempotent, so frequency only affects latency, not correctness.
- **Conf**: `Branding.Prestige.Enable`, `Branding.Prestige.TitleId.<School>` map, `CapstoneTitleId`.

## Acceptance
Standard DoD. Maxing a brand grants its title once (idempotent); all-maxed grants capstone; titles are
cosmetic (no stat/effect). Server-only (no DBC patch required for v1). Syntax-verify the TUs.
