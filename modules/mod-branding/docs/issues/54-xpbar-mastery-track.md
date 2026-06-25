# #54 — Watch brand XP on the native XP bar (§19.2 XPB / §14.13)

**Status:** open · **Epic:** #17 · **Deps:** `ProficiencyMgr` (present), addon protocol (§19, present) ·
**Parallel-safe:** yes (worktree) · **Size:** S–M

## Context
Players asked to see **branding (proficiency) level XP on the XP bar**, the way reputation can be
watched there. The native XP bar is a pure client view of `PLAYER_XP`/`PLAYER_NEXT_LEVEL_XP` and the
rep watch-bar's colour is hardwired to standing tier — neither can be repurposed server-side without
breaking real leveling. The supported seam on 3.3.5a is the **addon message channel the module
already ships** (§19): the server pushes the number, the addon renders it. This issue adds that push
(a new **XPB** frame) and an addon surface that draws it on/over the XP bar. Pairs naturally with #20
(post-cap XP redirect): at max *player* level the native bar is inert, so this reuses that space.

## Scope
- **Pure core (TDD):**
  - `proficiency/Proficiency.{h,cpp}` — `ComputeLevelProgress(totalXp, cfg) -> LevelProgress`
    (`level`, `maxLevel`, `xpIntoLevel`, `xpForLevel`, `atMax`). Reuses §7.4 `XpForLevel`/`LevelForXp`;
    the addon never duplicates the curve. At/above `MaxLevel`: `atMax`, `xpForLevel == 0`.
  - `core/addon/Protocol.{h,cpp}` — `XpFrame` + `EncodeXp`/`DecodeXp` + `operator==`. Wire:
    `BRND\tXPB\t<brand>\t<level>\t<maxLevel>\t<xpIntoLevel>\t<xpForLevel>\t<prestige>`. Additive under
    protocol v2 (unknown KIND ignored → no version bump).
- **Adapter (thin):**
  - `ProficiencyMgr::BrandProgress(guid, brand) -> LevelProgress` — reads the cached `totalXp` and
    calls the core. Zeroed if the character isn't loaded.
  - `AddonProtocolMgr::SendXp(player)` — resolves the active brand (`LoadoutMgr`), builds `XpFrame`
    from `BrandProgress`, sends one XPB frame. Pushed in `SendLoginSnapshot` and on the slow
    CHAR/SCHED refresh tick (`AddonScripts.cpp`). No raw `Player*` stored past the call.
- **Client addon (`client-addon/Branding/`):**
  - `Comms.lua` — `XPB` decode branch → `ns.state.xp`, fires `"xp"`; add `ns.SchoolColor`.
  - `XPBar.lua` (new) — a movable `StatusBar` anchored over `MainMenuExpBar`, fill =
    `xpIntoLevel/xpForLevel`, `N / M` label, school-tinted; "Prestige" at max. Unprotected overlay
    (no secure edit / no taint). Registered in `Branding.toc` and the `PLAYER_LOGIN` init in `Comms.lua`.

## Acceptance
Standard DoD. Server pushes the active brand's progression on login + refresh; the addon shows it on
the XP bar with the correct fill and a full "Prestige" bar at max level. Colour-by-school is present
but cosmetic (nice-to-have). `branding_core_tests` covers `ComputeLevelProgress` + the XPB round-trip.
Adapter TUs syntax-verify; Lua is manual-verify in-client (grammar parity with §19.2 is the contract).

## Notes
No SQL — every value is already persisted by `ProficiencyMgr`; this slice only transports it.
Colour table is config-free in the addon (school→RGB) since it is purely cosmetic.
