-- DB update 2026_02_28_02 -> 2026_02_28_03
-- Description: Fix missing damage values for various ILVL 146, 232, and 264 player weapons.
-- Reason: These items currently have 0 damage in the database, making them unusable for players.
-- Values sourced from Wowhead (Wrath Classic).

-- Twin-Edged Stiletto (ILVL 146 Fast 1H)
UPDATE `item_template` SET `dmg_min1` = 104, `dmg_max1` = 195, `dmg_type1` = 0 WHERE `entry` = 36477;

-- Kalu'ak Peacebringer (ILVL 146 2H)
UPDATE `item_template` SET `dmg_min1` = 106, `dmg_max1` = 198, `dmg_type1` = 0 WHERE `entry` = 38468;

-- Yielding Bow, Horned Crossbow, Tuskarr Boomstick (ILVL 146 Ranged)
UPDATE `item_template` SET `dmg_min1` = 150, `dmg_max1` = 280, `dmg_type1` = 0 WHERE `entry` IN (36617, 36631, 36645);

-- Serrated Maul, Moonlit Katana, Mummified Paw, Dragonflayer Hatchet (ILVL 146 Standard 1H)
UPDATE `item_template` SET `dmg_min1` = 160, `dmg_max1` = 298, `dmg_type1` = 0 WHERE `entry` IN (36491, 36519, 36561, 36575);

-- Adorned Broadsword, Archaic Longspear, Frosted Steel Mallet, Pine Needle Staff (ILVL 146 Standard 2H/Staff)
UPDATE `item_template` SET `dmg_min1` = 320, `dmg_max1` = 481, `dmg_type1` = 0 WHERE `entry` IN (36533, 36603, 36505, 36701);

-- Wise Dagger, Illuminated Scepter (ILVL 146 Caster 1H)
UPDATE `item_template` SET `dmg_min1` = 41, `dmg_max1` = 132, `dmg_type1` = 0 WHERE `entry` IN (36673, 36687);

-- Shivery Wand (ILVL 146 Wand)
UPDATE `item_template` SET `dmg_min1` = 192, `dmg_max1` = 358 WHERE `entry` = 36659;

-- Runed Shuriken (ILVL 146 Thrown)
UPDATE `item_template` SET `dmg_min1` = 136, `dmg_max1` = 253 WHERE `entry` = 36715;

-- Furious Gladiator's Waraxe (ILVL 232 Epic PvP 2H)
UPDATE `item_template` SET `dmg_min1` = 339, `dmg_max1` = 632, `dmg_type1` = 0 WHERE `entry` = 42238;

-- Wand of the Drowned Contessa (ILVL 264 Epic Wand)
UPDATE `item_template` SET `dmg_min1` = 583, `dmg_max1` = 1083, `dmg_type1` = 4 WHERE `entry` = 50204;

UPDATE `item_template` SET `MaxDurability`=55, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36477;
UPDATE `item_template` SET `MaxDurability`=75, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36491;
UPDATE `item_template` SET `MaxDurability`=85, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36505;
UPDATE `item_template` SET `MaxDurability`=75, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36519;
UPDATE `item_template` SET `MaxDurability`=85, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36533;
UPDATE `item_template` SET `MaxDurability`=85, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36547;
UPDATE `item_template` SET `MaxDurability`=75, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36575;
UPDATE `item_template` SET `MaxDurability`=85, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36589;
UPDATE `item_template` SET `MaxDurability`=85, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36603;
UPDATE `item_template` SET `MaxDurability`=65, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36617;
UPDATE `item_template` SET `MaxDurability`=65, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36631;
UPDATE `item_template` SET `MaxDurability`=65, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36645;
UPDATE `item_template` SET `MaxDurability`=55, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36659;
UPDATE `item_template` SET `MaxDurability`=55, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36673;
UPDATE `item_template` SET `MaxDurability`=75, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36687;
UPDATE `item_template` SET `MaxDurability`=85, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36701;
UPDATE `item_template` SET `MaxDurability`=0, `DisenchantID`=15, `RequiredDisenchantSkill`=325 WHERE `entry`=36715;

UPDATE `item_template` SET `MaxDurability`=105 WHERE `entry`=42238;
UPDATE `item_template` SET `MaxDurability`=75, `DisenchantID`=68, `RequiredDisenchantSkill`=375 WHERE `entry`=50204;
