--
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 2775;
DELETE FROM `creature_loot_template` WHERE `entry` = 2775;
