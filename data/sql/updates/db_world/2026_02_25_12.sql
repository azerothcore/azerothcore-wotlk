-- Description: Fix missing damage values for various ILVL 146, 232, and 264 player weapons.
-- Reason: These items currently have 0 damage in the database, making them unusable for players.
-- Values sourced from Wowhead (Wrath Classic).

-- Fix ILVL 146 Fast 1H Weapons (Speed 1.8 | ~88.1 DPS)
UPDATE `item_template` SET `dmg_min1` = 119, `dmg_max1` = 198, `dmg_type1` = 0 WHERE `entry` = 36477;

-- Fix ILVL 146 Standard 1H Weapons (Speed 2.6 | ~88.1 DPS)
UPDATE `item_template` SET `dmg_min1` = 160, `dmg_max1` = 298, `dmg_type1` = 0 WHERE `entry` IN (36491, 36505, 36519, 36561, 36575);

-- Fix ILVL 146 Standard 2H Weapons (Speed 3.5 | ~114.4 DPS)
UPDATE `item_template` SET `dmg_min1` = 320, `dmg_max1` = 481, `dmg_type1` = 0 WHERE `entry` IN (36533, 36603, 38468);

-- Fix ILVL 146 Ranged Weapons (Speed 2.8 | ~88.1 DPS)
UPDATE `item_template` SET `dmg_min1` = 180, `dmg_max1` = 313, `dmg_type1` = 0 WHERE `entry` IN (36617, 36631, 36645);

-- Fix ILVL 146 Caster Weapons (Low physical damage)
UPDATE `item_template` SET `dmg_min1` = 45, `dmg_max1` = 95, `dmg_type1` = 0 WHERE `entry` IN (36673, 36687);
UPDATE `item_template` SET `dmg_min1` = 100, `dmg_max1` = 150, `dmg_type1` = 0 WHERE `entry` = 36701;

-- Fix ILVL 146 Wands & Thrown
UPDATE `item_template` SET `dmg_min1` = 160, `dmg_max1` = 298 WHERE `entry` IN (36659, 36715);

-- Fix ILVL 232 PvP Epic 2H (Furious Gladiator's Waraxe)
UPDATE `item_template` SET `dmg_min1` = 575, `dmg_max1` = 863, `dmg_type1` = 0 WHERE `entry` = 42238;

-- Fix ILVL 264 Epic Wand (Wand of the Drowned Contessa)
UPDATE `item_template` SET `dmg_min1` = 380, `dmg_max1` = 707, `dmg_type1` = 5 WHERE `entry` = 50204;