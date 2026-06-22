# #20 — Post-cap XP → active-school Proficiency (§14.13.3)

**Status:** open · **Epic:** #17 · **Deps:** `ProficiencyMgr` (present) · **Parallel-safe:** yes (worktree) · **Size:** S–M

## Context
§14.13.3: at max player level, normal XP has no sink — redirect it into the **active school's**
Proficiency. Thin adapter over the existing §7 Proficiency core; **no new pure logic** expected.

## Scope
- **Adapter** `src/PostCapXpScripts.cpp` — a `PlayerScript` hook on the XP path
  (`OnPlayerGiveXP(Player*, uint32& amount, Unit* victim, uint8 xpSource)` — see `DiscoveryScripts.cpp`
  for the exact signature). When `player->GetLevel()` is the configured max:
  - resolve the active brand (`LoadoutMgr`), feed the XP into that brand's Proficiency through the
    **existing `ProficiencyMgr` public API** (prefer `ApplyActivity`; only if unavoidable add a small
    `AddRawXp(guid, brand, units)` to `ProficiencyMgr` and report the hunk),
  - zero/reduce the vanilla `amount` so post-cap XP becomes Proficiency, not wasted.
  - Only the **active** brand grows; dormant brands untouched.
- **Conf**: `Branding.PostCapXp.Enable`, `ConversionRatio` (xp→Proficiency units).

## Acceptance
Standard DoD. At max level, post-cap XP flows to the active brand's Proficiency only; below cap,
untouched. Toggleable. Syntax-verify the TU (no worldserver build).

## Notes
Pacing of this conversion is the knob the **#14** sim calibrates to the ~3-month Prestige target
(§14.13.6) — keep `ConversionRatio` in config so #14 can pin it.
