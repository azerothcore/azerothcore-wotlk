-- DB update 2023_04_19_02 -> 2023_04_19_03
--
-- Remove Roughshod Pikes from any creature
DELETE FROM `creature_loot_template` WHERE `Item` = 12533;
UPDATE `creature_template` SET `lootid`=0 WHERE `entry`=415;
