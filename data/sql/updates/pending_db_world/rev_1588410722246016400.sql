INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588410722246016400');

UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` IN (2992,7484,3680,17079,17080); 

DELETE FROM `creature_loot_template` WHERE `entry` IN (2992, 7484, 3680, 17079, 17080); 
