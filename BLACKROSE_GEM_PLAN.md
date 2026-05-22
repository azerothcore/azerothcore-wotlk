# Black Rose Feature and Gem Plan

## Current Status

This document summarizes the Black Rose work completed so far and preserves the
implementation plan for the Black Rose gem system. It is intended as a handoff
and testing reference for server, DB, and client-side follow-up.

## Change Summary

### Norah Rose Quest

- Added the level 20 quest `The Black Rose`.
- Added separate faction quest IDs:
  - Alliance: `900100`
  - Horde: `900101`
- Added Norah Rose as the quest giver in each major city:
  - Horde NPC: `900103`, display ID `16695`
  - Alliance NPC: `900104`, display ID `14615`
- Spawned Norah Rose in Orgrimmar, Undercity, Thunder Bluff, Silvermoon,
  Stormwind, Darnassus, Ironforge, and Exodar.
- Quest rewards include:
  - `5` gold
  - closest DB-supported level 20 XP reward setting
  - `Bag of the Black Rose` item `900102`
  - faction Black War Bear mount item
  - `The Black Rose` trinket item `900105`

Primary SQL:

- `data/sql/updates/pending_db_world/rev_1779316939445293603.sql`

### Bag of the Black Rose

- Added `Bag of the Black Rose` item `900102`.
- It is soulbound and has `26` container slots.
- Uses the black silk bag display/icon reference.

### Rosy Vendor and Bag Upgrades

- Added Rosy as a vendor NPC:
  - NPC ID: `900140`
  - Display ID: `617` (murloc)
- Spawned Rosy next to Norah Rose in each major city.
- Added upgraded versions of `Bag of the Black Rose`:
  - `900120`: 28 slots
  - `900121`: 30 slots
  - `900122`: 32 slots
  - `900123`: 34 slots
  - `900124`: 36 slots
- Added bag upgrade token items:
  - `900130`: upgrades 26 to 28 slots, costs 5 silver
  - `900131`: upgrades 28 to 30 slots, costs 5 gold
  - `900132`: upgrades 30 to 32 slots, costs 50 gold
  - `900133`: upgrades 32 to 34 slots, costs 500 gold
  - `900134`: upgrades 34 to 36 slots, costs 50,000 gold
- Implemented `item_black_rose_bag_upgrade` in C++.
- Bag upgrade behavior:
  - Player must equip the current matching bag tier.
  - Bag must be empty.
  - The token is consumed.
  - The equipped bag is replaced with the next tier.

Primary SQL/source:

- `data/sql/updates/pending_db_world/rev_1779360000000000000.sql`
- `src/server/scripts/World/item_scripts.cpp`

### Gold and Gray Item Economy

- Adjusted server configuration so mob money drops target roughly `300%`.
- Adjusted poor-quality gray item vendor value rate to target `300%`.
- Disabled AutoBalance money reward scaling via config rather than C++ changes.
- The intended behavior is:
  - Solo kill with base 100 copper shows and awards 300 copper.
  - Three-player group still sees 300 copper total, split to 100 copper each.
  - Gray item with old sell value 1 gold now sells for 3 gold.

Primary config areas:

- `worldserver.conf`
- `AutoBalance.conf`

### Warlock Soul Shards

- Updated Soul Shard item `6265` to stack to `10`.
- This lets Warlocks carry 10 shards in one inventory slot.

### The Black Rose Trinket

- Added `The Black Rose` trinket item `900105`.
- Artifact quality.
- Equippable by all classes and races.
- Required level `20`.
- Base stats:
  - `+5` intellect
  - `+5` strength
  - `+5` spirit
  - `+5` agility
  - `+20` stamina
- Has 3 sockets:
  - red
  - yellow
  - blue
- Wired to the custom use effect:
  - Spell/aura ID: `900900`
  - Duration: `20` seconds
  - Cooldown: `3` minutes
  - ScriptName: `item_black_rose_trinket`
- On use, it channels the power of the Black Rose and makes socketed Black Rose
  gem stats count as `250%` total effectiveness for the duration.

Primary SQL/source:

- `data/sql/updates/pending_db_world/rev_1779316939445293603.sql`
- `data/sql/updates/pending_db_world/rev_1779400000000000000.sql`
- `data/sql/updates/pending_db_world/rev_1779410000000000000.sql`
- `src/server/scripts/World/item_scripts.cpp`
- `src/server/scripts/Spells/spell_item.cpp`

## Black Rose Gem Plan

### Design Goals

- Use `The Black Rose` as the only valid socket target for custom Black Rose
  gems.
- Keep red and yellow gems as straightforward stat-stick gems first.
- Defer blue class gems and class-specific mechanics to a later phase.
- Let Rosy sell base gems and only the next eligible upgrade tier.
- Use server-side scripting for behavior that cannot be represented cleanly in
  SQL alone.
- Keep the system ID ranges predictable so later gem families can be added
  without reworking the existing content.

### Currency Items

- `900200`: Black Miasma
  - Used for red gems.
  - Stack size `10000`.
- `900201`: Black Petals
  - Used for yellow gems.
  - Stack size `10000`.
- `900202`: Black Thorns
  - Reserved for future blue/class gems.
  - Stack size `10000`.

Quest completion grants 1 of each currency through the
`player_black_rose_gem_system` `OnPlayerCompleteQuest` hook.

### Spell and DBC Rows

- `900900`: `Power of the Black Rose`
  - Dummy aura used by the trinket.
  - Lasts `20` seconds.
  - Reapplies Black Rose socket enchant stats as boosted while active.
- `900901`: `Empower Black Rose Gem`
  - Generic upgrade-token use spell.
  - Replaces the borrowed captured-frog spell reference.

Related DB tables:

- `spell_dbc`
- `spellduration_dbc`
- `spell_script_names`
- `spellitemenchantment_dbc`
- `gemproperties_dbc`
- `itemextendedcost_dbc`
- `item_template`
- `npc_vendor`
- `conditions`

### Red Gems

Red gems use Black Miasma and have 7 ranks.

ID formula:

- Gem item/enchant base: `900300`
- Upgrade token base: `900500`
- Gem ID: `900300 + family * 10 + rankIndex`
- Upgrade token ID: `900500 + family * 10 + upgradeIndex`
- `rankIndex` is zero-based for ranks 1 through 7.
- `upgradeIndex` is zero-based for upgrades to ranks 2 through 7.

Families:

- `0`: Stark, strength
- `1`: Klug, intellect
- `2`: Geist, spirit
- `3`: Schnell, agility
- `4`: Fett, stamina
- `5`: Gross, strength and stamina
- `6`: Spinnst, intellect and spirit
- `7`: Scharf, strength and agility
- `8`: Weise, intellect and stamina

Single-stat rank values:

- Rank 1: `+2`
- Rank 2: `+22`
- Rank 3: `+42`
- Rank 4: `+62`
- Rank 5: `+82`
- Rank 6: `+102`
- Rank 7: `+122`

Split-stat rank values:

- Rank 1: `+1 / +1`
- Rank 2: `+11 / +11`
- Rank 3: `+21 / +21`
- Rank 4: `+31 / +31`
- Rank 5: `+41 / +41`
- Rank 6: `+51 / +51`
- Rank 7: `+61 / +61`

Costs in Black Miasma:

- Base rank 1 purchase: `1`
- Upgrade to rank 2: `10`
- Upgrade to rank 3: `50`
- Upgrade to rank 4: `500`
- Upgrade to rank 5: `1000`
- Upgrade to rank 6: `5000`
- Upgrade to rank 7: `10000`

### Yellow Gems

Yellow gems use Black Petals and have 7 ranks.

ID formula:

- Gem item/enchant base: `900400`
- Upgrade token base: `900600`
- Gem ID: `900400 + family * 10 + rankIndex`
- Upgrade token ID: `900600 + family * 10 + upgradeIndex`

Families:

- `0`: pouvoir, spell power
- `1`: douleur, attack power

Rank values:

- Rank 1: `+6`
- Rank 2: `+26`
- Rank 3: `+86`
- Rank 4: `+126`
- Rank 5: `+166`
- Rank 6: `+206`
- Rank 7: `+246`

Costs in Black Petals:

- Base rank 1 purchase: `1`
- Upgrade to rank 2: `10`
- Upgrade to rank 3: `50`
- Upgrade to rank 4: `500`
- Upgrade to rank 5: `1000`
- Upgrade to rank 6: `5000`
- Upgrade to rank 7: `10000`

### Upgrade Flow

The intended player flow is:

1. Complete `The Black Rose` quest.
2. Equip `The Black Rose` trinket.
3. Buy a rank 1 gem from Rosy.
4. Socket the rank 1 gem into `The Black Rose`.
5. Rosy displays only the next eligible upgrade for that socketed gem.
6. Buy the upgrade token.
7. Right-click the upgrade token.
8. The token verifies the lower-rank gem is socketed.
9. The lower-rank socket enchant is removed.
10. The next-rank gem item is granted.
11. The token is consumed.
12. The player sockets the new higher-rank gem.

### Server-Side Enforcement

Implemented in `src/server/game/BlackRoseGemSystem.h`:

- Central constants for items, spells, NPCs, quests, gem bases, and upgrade
  bases.
- Helpers to identify Black Rose gems and upgrade tokens.
- Helpers to map an upgrade token to its lower-rank gem and next-rank gem.
- Helper to find equipped `The Black Rose`.
- Helper to determine if Rosy should show an upgrade item.
- Scoped multiplier mode used to safely remove and reapply socket enchant stats
  during the trinket aura transition.

Implemented in `src/server/game/Handlers/ItemHandler.cpp`:

- Prevents Black Rose gems from being socketed into any item except
  `The Black Rose`.
- Filters Rosy's vendor list so upgrade tokens only appear when the player has
  the prerequisite lower-rank gem socketed.

Implemented in `src/server/scripts/World/item_scripts.cpp`:

- `item_black_rose_trinket`
  - Casts aura `900900`.
  - Applies a 3-minute cooldown.
- `item_black_rose_gem_upgrade`
  - Verifies the correct lower-rank gem is socketed.
  - Removes the lower-rank socket enchant.
  - Grants the next-rank gem.
  - Consumes the token.
- `player_black_rose_gem_system`
  - Blocks invalid Rosy purchases server-side.
  - Multiplies Black Rose gem enchant stat amounts by `5 / 2` while boosted.
  - Grants one Black Miasma, one Black Petals, and one Black Thorns when the
    quest is completed.

Implemented in `src/server/scripts/Spells/spell_item.cpp`:

- `spell_item_black_rose`
  - On aura apply, reapplies socket enchant stats as boosted.
  - On aura removal, reapplies socket enchant stats as base values.

### Follow-Up Correction SQL

Added `data/sql/updates/pending_db_world/rev_1779410000000000000.sql` after
testing revealed stale item data. This follow-up update corrects live DB rows
that may not be updated if an earlier pending revision had already been applied.

It fixes:

- Gem item names, for example `Klug Gem` instead of `Black Rose Klug 1`.
- Gem descriptions, for example `Grants the Black Rose +2 intellect.`
- Upgrade names and descriptions.
- Upgrade `spellid_1`, replacing the captured-frog spell reference.
- Trinket use spell fields, cooldown, base stats, and `ScriptName`.
- Enchantment display names for socketed gem effects.

## Known Client and Cache Caveats

- Item names and descriptions queried by the client can stay stale until the
  client `Cache` folder is cleared.
- `spell_dbc`, `spellduration_dbc`, `gemproperties_dbc`, and
  `spellitemenchantment_dbc` changes require a server restart.
- Some tooltip behavior may require client-side DBC patches.
- The trinket tooltip may not dynamically display socketed gem stat totals even
  when the server applies the stats correctly.
- If the upgrade token still references the captured frog, verify that
  `rev_1779410000000000000.sql` was applied and the client cache was cleared.

## Test Checklist

### DB and Server Setup

1. Apply all pending DB-world SQL updates.
2. Rebuild worldserver if C++ changes were not already built.
3. Restart worldserver.
4. Clear the WoW client `Cache` folder.

### Quest Test

1. Visit Norah Rose in a major city at level 20 or above.
2. Confirm `The Black Rose` quest is available.
3. Complete the quest.
4. Confirm rewards:
   - 5 gold
   - `Bag of the Black Rose`
   - faction Black War Bear item
   - `The Black Rose` trinket
   - 1 Black Miasma
   - 1 Black Petals
   - 1 Black Thorns

### Bag Upgrade Test

1. Equip the 26-slot `Bag of the Black Rose`.
2. Buy the first Rosy bag upgrade.
3. Try using it while the bag contains items and confirm it is rejected.
4. Empty the bag.
5. Use the upgrade token and confirm the bag becomes 28 slots.
6. Repeat through the 36-slot tier.

### Gem Purchase and Socket Test

1. Equip `The Black Rose`.
2. Open Rosy's vendor list.
3. Confirm base red/yellow gems are visible.
4. Confirm upgrade tokens are hidden before the prerequisite gem is socketed.
5. Buy `Klug Gem`.
6. Confirm its name and description are correct.
7. Socket it into `The Black Rose`.
8. Confirm only the next Klug upgrade appears.
9. Attempt to socket a Black Rose gem into another item and confirm it fails.

### Gem Upgrade Test

1. Socket a rank 1 gem into `The Black Rose`.
2. Buy its rank 2 upgrade token.
3. Use the token.
4. Confirm the rank 1 socket enchant is removed.
5. Confirm the rank 2 gem item is granted.
6. Confirm the upgrade token is consumed.

### Trinket On-Use Test

1. Equip `The Black Rose` with at least one Black Rose gem socketed.
2. Record character stat values.
3. Use the trinket.
4. Confirm the aura appears for 20 seconds.
5. Confirm relevant gem-derived stats increase to 250% total.
6. Confirm the effect falls off after 20 seconds.
7. Confirm the trinket incurs a 3-minute cooldown.

## Deferred Work

- Blue class gems using Black Thorns.
- Class-specific gem mechanics for Warrior, Priest, Paladin, Shaman, Druid,
  Rogue, Mage, Warlock, Hunter, and Death Knight.
- Client-side DBC/tooltip patching for full polished item display.
- Final in-game tuning after live playtesting.
