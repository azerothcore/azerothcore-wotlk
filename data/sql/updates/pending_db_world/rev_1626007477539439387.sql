INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626007477539439387');

-- Delete Arathi PVP supplies from Warpwood Stomper, Desert Rumbler, Vekniss Soldier
DELETE FROM `creature_loot_template` WHERE `entry` IN (11465, 11746, 15229) AND `item` IN (20062, 20066);

-- Delete loot table for Field Marshal Oslight 
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 14983;
DELETE FROM `creature_loot_template` WHERE `entry` = 14983;

