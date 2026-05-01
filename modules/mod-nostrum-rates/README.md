# mod-nostrum-rates

Centralizes configurable gameplay rate modifiers for NostrumWoW in a single module, configurable without recompiling.

---

## What it does

Applies multipliers to:

- **XP** — kill, quest, explore, battleground, dungeon/raid, and elite kills; with optional per-level-bracket overrides
- **Reputation** — kill and quest reputation (spillover included automatically)
- **Profession skill gain** — gathering and crafting separately
- **Loot drop chance** — creature, skinning, fishing, mining+herbalism, disenchanting, prospecting, milling
- **Creature money drops**
- **PvP honor** and **arena points**

---

## Installation

1. Place this module folder inside `modules/` in your AzerothCore source tree.
2. Rebuild the server (`make -j$(nproc) && make install`).
3. Copy `conf/nostrum_rates.conf.dist` to your server's config directory and rename it `nostrum_rates.conf`.
4. Edit values in `nostrum_rates.conf` as needed.
5. Start (or restart) the worldserver.

### Important: worldserver.conf

This module multiplies **on top of** any rates set in `worldserver.conf`. To avoid stacking, set the relevant rates to `1.0` in `worldserver.conf`:

```ini
Rate.XP.Kill    = 1.0
Rate.XP.Quest   = 1.0
Rate.XP.Explore = 1.0
Rate.Drop.Item.Poor      = 1.0
Rate.Drop.Item.Normal    = 1.0
Rate.Drop.Item.Uncommon  = 1.0
Rate.Drop.Item.Rare      = 1.0
Rate.Drop.Item.Epic      = 1.0
Rate.Drop.Item.Legendary = 1.0
```

---

## Configuration

All keys are prefixed with `NostrumRates.` and live in `nostrum_rates.conf`.

| Key | Description | Default |
|-----|-------------|---------|
| `NostrumRates.Enable` | Master on/off switch | `1` |
| `NostrumRates.XP.Kill` | Normal kill XP multiplier | `3.0` |
| `NostrumRates.XP.Quest` | Quest XP multiplier | `3.0` |
| `NostrumRates.XP.Explore` | Exploration XP multiplier | `3.0` |
| `NostrumRates.XP.Battleground` | BG kill XP multiplier | `1.0` |
| `NostrumRates.XP.Dungeon` | Kill XP inside dungeon/raid instances | `3.0` |
| `NostrumRates.XP.Elite` | Kill XP for elite creatures outside instances | `3.0` |
| `NostrumRates.XP.LevelRange.Enable` | Enable per-bracket XP overrides | `1` |
| `NostrumRates.XP.LevelRange.Brackets` | Comma-separated bracket list | `1-59,60-69,70-80` |
| `NostrumRates.XP.LevelRange.<range>.Kill` | Kill XP for bracket | global |
| `NostrumRates.XP.LevelRange.<range>.Quest` | Quest XP for bracket | global |
| `NostrumRates.XP.LevelRange.<range>.Explore` | Explore XP for bracket | global |
| `NostrumRates.Reputation.Kill` | Kill reputation multiplier | `2.0` |
| `NostrumRates.Reputation.Quest` | Quest reputation multiplier | `2.0` |
| `NostrumRates.Profession.GatheringSkillGain` | Gathering skill gain rate | `2.0` |
| `NostrumRates.Profession.CraftingSkillGain` | Crafting skill gain rate | `2.0` |
| `NostrumRates.Loot.Creature` | Creature item drop chance multiplier | `1.0` |
| `NostrumRates.Loot.Skinning` | Skinning drop chance multiplier | `1.0` |
| `NostrumRates.Loot.Fishing` | Fishing loot drop chance multiplier | `1.0` |
| `NostrumRates.Loot.Mining` | Mining drop chance multiplier (also applies to herbalism) | `1.0` |
| `NostrumRates.Loot.Herbalism` | Herbalism rate (must equal Mining — see Limitations) | `1.0` |
| `NostrumRates.Loot.Disenchanting` | Disenchanting drop chance multiplier | `1.0` |
| `NostrumRates.Loot.Prospecting` | Prospecting drop chance multiplier | `1.0` |
| `NostrumRates.Loot.Milling` | Milling drop chance multiplier | `1.0` |
| `NostrumRates.Money.Creature` | Creature gold drop multiplier | `1.0` |
| `NostrumRates.PvP.Honor` | Honor gain multiplier | `1.0` |
| `NostrumRates.PvP.ArenaPoints` | Arena point reward multiplier | `1.0` |

### Level range overrides

When `LevelRange.Enable = 1`, players whose level falls within a configured bracket use the bracket-specific rates instead of the global ones. Any rate not defined in a bracket falls back to the global value.

Add or remove brackets freely via the `Brackets` key — no recompile needed. Invalid bracket strings are skipped with a warning in the server log.

---

## Live reload

`.reload config` in-game reloads all `NostrumRates.*` values. You will see:

```
>> NostrumRates: config reloaded
```

All rate changes take effect immediately for subsequent XP/rep/loot events — no restart required.

---

## Known limitations

| Feature | Status | Notes |
|---------|--------|-------|
| Rested XP multiplier | ❌ Not implemented | No hook available; use `Rate.Rest.InGame` in worldserver.conf |
| Mining vs Herbalism separate rates | ❌ Not implemented | Both go through `gameobject_loot_template`; Mining rate applies to both |
| Fishing skill gain rate | ❌ Not implemented | `OnPlayerUpdateFishingSkill` returns bool (allow/deny), no gain modifier |
| Quest money rewards | ❌ Not implemented | No hook; use `Rate.Money.Quest` in worldserver.conf |
| Vendor sell price | ❌ Not implemented | No hook in AzerothCore |
| Battleground mark rewards | ❌ Not implemented | No hook available |
| Reputation spillover separate rate | ℹ️ Not separate | Spillover fires the same hook as kill/quest; same multiplier applies |
| Dungeon vs Normal elite distinction | ℹ️ Dungeon takes priority | A creature that is both elite and inside a dungeon uses the Dungeon rate |
| Loot.Quest rate risks | ⚠️ Caution | Quest items roll through the same hook; 100%-chance quest items are safe but cap at 100%; variable-chance items will drop more |

---

## Testing checklist

1. Start worldserver — confirm `>> NostrumRates: module enabled` and rate lines appear in log.
2. Set `NostrumRates.Enable = 0`, `.reload config` — confirm `>> NostrumRates: module disabled` and rates stop.
3. Kill a normal creature — verify XP matches `XP.Kill` × base XP.
4. Kill a creature inside a dungeon — verify XP matches `XP.Dungeon` × base XP.
5. Kill an elite outside a dungeon — verify XP matches `XP.Elite` × base XP.
6. Complete a quest — verify XP matches `XP.Quest` × base XP.
7. Explore a new area — verify XP matches `XP.Explore` × base XP.
8. Gain reputation from a kill — verify matches `Reputation.Kill` × base rep.
9. Level a gathering profession — verify skill gain is multiplied.
10. Loot a creature — verify item drop frequency increases with `Loot.Creature`.
11. Kill a player in world PvP — verify honor matches `PvP.Honor` × base honor.
12. Set a rate to `999.0` — confirm warning logged and default used (server does not crash).
13. Remove a rate key from config — confirm default value is used silently.
14. Test a level-60 character: confirm bracket `60-69` rates apply.
15. `.reload config` with changed rates — confirm new values take effect without restart.
