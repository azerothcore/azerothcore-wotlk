-- DB update 2026_09_21_01 -> 2026_09_21_02
-- Shadowforge Flame Keepers must always drop the torch needed to open the Lyceum doors.
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE `Entry` = 9956 AND `Item` = 11885 AND `Reference` = 0;
