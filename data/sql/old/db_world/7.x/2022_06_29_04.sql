-- DB update 2022_06_29_03 -> 2022_06_29_04
--
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 2775;
DELETE FROM `creature_loot_template` WHERE `entry` = 2775;
