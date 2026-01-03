-- DB update 2026_01_03_01 -> 2026_01_03_02
--
UPDATE `creature_loot_template` SET `Chance` = 40 WHERE `Entry` = 23691 AND `Item` = 33611;
UPDATE `creature_loot_template` SET `Chance` = 40 WHERE `Entry` = 23690 AND `Item` = 33611;
UPDATE `creature_loot_template` SET `Chance` = 20 WHERE `Entry` = 24791 AND `Item` = 33611;
