# mod-nostrum-bg-xp

Grants configurable XP for battleground participation on NostrumWoW, rewarding actual play without enabling AFK farming.

---

## XP formula

```
BaseXP     = XPForLevel(level) × CompletionPercent × BaseMultiplier × BGMultiplier
WinXP      = BaseXP × WinMultiplier
LossXP     = BaseXP × LossMultiplier
ObjXP      = XPForLevel(level) × ObjectivePercent × ObjectiveMultiplier × min(objectives, MaxEvents)
TotalXP    = (WinXP or LossXP) + ObjXP
Daily win  = TotalXP × DailyFirstWinMultiplier (first win of the day only)
```

`XPForLevel(level)` is the AzerothCore XP table lookup — it represents roughly one level's worth of XP. With `CompletionPercent = 0.035` and `WinMultiplier = 1.0`, a win gives ~3.5% of a level before objective bonuses.

---

## XP sources

| Source | Hook | Notes |
|--------|------|-------|
| BG completion (win) | `OnBattlegroundEndReward` | Win multiplier applied |
| BG completion (loss) | `OnBattlegroundEndReward` | Loss multiplier applied |
| Objectives | BG score attrs at match end | Attr1+Attr2: flags, assaults, defenses |
| Honorable kills | `OnPlayerPVPKill` | Disabled by default; per-BG cap |
| Daily first win | at win end | Multiplies total XP once per day |

---

## Participation / anti-AFK

At match end, each player's contribution score is computed from their BG stats:

- Honorable kills × `Contribution.HonorKill` points
- Objectives (flag caps/returns, base assaults/defenses) × `Contribution.Objective` points
- Damage done ≥ threshold → `Contribution.DamageDonePoints`
- Healing done ≥ threshold → `Contribution.HealingDonePoints`

If the score is below `MinimumContributionScore`, no XP is granted (or a small flat amount if configured). Healers are explicitly supported via the healing threshold.

---

## Database requirement

The daily first win system requires a custom table in the **characters database**:

```sql
-- Apply once:
data/sql/db-characters/base/nostrum_bg_xp.sql
```

Run this against your `acore_characters` database before starting the server with this module loaded. Without it, daily win tracking will not persist across restarts (first win still works per-session).

---

## Installation

1. Place this module folder inside `modules/` in your AzerothCore source tree.
2. Rebuild the server.
3. Apply the SQL migration: `mysql -u root -p acore_characters < data/sql/db-characters/base/nostrum_bg_xp.sql`
4. Copy `conf/nostrum_bg_xp.conf.dist` to your server config directory as `nostrum_bg_xp.conf`.
5. Edit values as needed.
6. Start the worldserver.

---

## Configuration

All keys are prefixed with `NostrumBGXP.` — see `nostrum_bg_xp.conf.dist` for full documentation inline.

---

## Live reload

`.reload config` reloads all rate and config values immediately. The daily win state loaded from DB is not affected by reload. No restart required for rate changes.

---

## Known limitations

| Feature | Status | Notes |
|---------|--------|-------|
| Objective XP per event type | ℹ️ BG score attrs | Attr1+Attr2 from BattlegroundScore; meaning varies by BG. WSG=caps+returns, AB=assaults+defenses, EOTS=caps. AV attr meanings differ — test carefully. |
| AV / SOTA / IOC objective specifics | ⚠️ Limited | Generic Attr1+Attr2 may not cover all AV/SOTA/IOC objectives. No per-BG-type hook available without subclassing each BG. |
| Objective events during BG | ℹ️ End of BG only | Objective XP is computed from cumulative score at match end, not event-by-event. |
| HK XP kill trading | ⚠️ Per-BG cap | Cap reduces but doesn't eliminate kill trading if enabled. Recommend leaving disabled unless monitoring. |
| Daily win reset precision | ℹ️ UTC | Reset hour is UTC. If your server runs in a different timezone, adjust `ResetHour` accordingly. |
| Arena exclusion | ✅ Safe | `bg->isBattleground()` check prevents XP from arenas. |
| Level 80 XP | ✅ Excluded | `MaxLevel = 79` by default. Set to 80 intentionally to include level 80. |
| mod-nostrum-rates interaction | ✅ No conflict | This module calls `GiveXP()` directly, bypassing `OnPlayerGiveXP` hooks. BG XP rates are controlled here only. |

---

## Testing checklist

1. Start worldserver — confirm `>> NostrumBGXP: module enabled` appears in logs.
2. Set `NostrumBGXP.Enable = 0`, `.reload config` — confirm `>> NostrumBGXP: module disabled` and no custom XP is granted.
3. Join WSG at level 10+, win — confirm XP announcement and correct amount (~3.5% of level for default settings).
4. Join WSG, lose — confirm XP is lower (~1.225% of level default).
5. AFK in a BG without dealing damage, healing, or getting HKs — confirm no XP or fallback XP only.
6. Heal teammates above the healing threshold — confirm participation requirement met.
7. Capture a flag or assault a base — confirm objective XP is included.
8. Win a BG twice in one day — confirm daily bonus only applies once.
9. Log out and back in after a daily win — confirm the win is remembered (DB persistence).
10. Set a player level to 80 with default `MaxLevel = 79` — confirm no XP granted.
11. Set `NostrumBGXP.CompletionXP.PercentOfLevel = 0.999` — confirm warning logged and default used.
12. Remove a config key — confirm default is used without crash.
13. Test level 15 — confirm bracket `10-19` rate applies.
14. Test level 65 — confirm bracket `60-69` rate applies.
15. Enter a solo arena — confirm no XP is granted (arena check).
