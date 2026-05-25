-- DB update 2026_01_17_01 -> 2026_01_18_00
-- Sets "Spiritsbreath" to be 100 from 58 % drop rate for "Grumbald One-Eye"
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE `Entry` = 26681 AND `Item` = 36740;
