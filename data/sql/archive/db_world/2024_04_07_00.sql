-- DB update 2024_04_03_01 -> 2024_04_07_00
--
DELETE FROM `creature_loot_template` WHERE `Entry` = 17968 AND `Item` = 190068;
UPDATE `creature_loot_template` SET `MaxCount` = 3 WHERE `Entry` = 17968 AND `Item` = 34068;
