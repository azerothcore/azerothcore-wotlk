--
-- Remove Roughshod Pikes from any creature
DELETE FROM `creature_loot_template` WHERE `item` IN (12533);
UPDATE `creature_template` SET `lootid`='0' WHERE `entry`=415;
