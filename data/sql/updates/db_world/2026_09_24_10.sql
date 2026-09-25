-- DB update 2026_09_24_09 -> 2026_09_24_10
-- --------------------------------------------------------------------------------------------
-- Level 80 raids: raise the last hostile creatures below their Blizzlike level
-- --------------------------------------------------------------------------------------------

-- Frost Sphere (Entry 34606, Trial of the Crusader, map 649)
-- Correct level from 79-80 to 80
-- -------------------------------------------
-- Anub'arak's Frost Sphere rolled 79 or 80 on all four difficulties. Wowhead lists it at a flat 80.
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80 WHERE `entry` IN (34606, 34649, 3460602, 3460603);

-- Flame Warder (Entry 35143, Vault of Archavon, map 624)
-- Correct level from 78 to 82
-- -------------------------------------------
-- The 10-man Flame Warder was level 78. Wowhead lists it at 82, which matches its 25-man entry (35359).
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82 WHERE `entry` = 35143;
