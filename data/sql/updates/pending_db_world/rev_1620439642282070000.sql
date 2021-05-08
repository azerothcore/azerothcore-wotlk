INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620439642282070000');

DELETE FROM `creature_loot_template` WHERE `Entry`=7768;
UPDATE `creature_template` SET `lootid`=0 WHERE `entry`=7768;

