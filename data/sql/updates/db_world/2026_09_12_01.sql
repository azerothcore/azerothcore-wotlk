-- DB update 2026_09_12_00 -> 2026_09_12_01
UPDATE `creature_loot_template` SET `Chance` = 0 WHERE `Entry` = 10504 AND `Item` = 35031;
