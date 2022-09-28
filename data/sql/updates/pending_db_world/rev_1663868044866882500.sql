--
DELETE FROM `creature_loot_template` WHERE `item` = 6083;
/* Gelkis Rumblers have no other loot */
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 4661;
