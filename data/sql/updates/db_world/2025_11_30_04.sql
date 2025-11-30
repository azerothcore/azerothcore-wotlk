-- DB update 2025_11_30_03 -> 2025_11_30_04
--
UPDATE `creature_template` SET `lootid` = 29605 WHERE `entry` = 30291;
DELETE FROM `creature_loot_template` WHERE `Entry` = 30291;
