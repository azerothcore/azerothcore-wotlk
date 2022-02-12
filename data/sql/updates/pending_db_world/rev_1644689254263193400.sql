INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644689254263193400');

UPDATE `creature_template` SET `lootid`=2673 WHERE `entry`=2673;

DELETE FROM `creature_loot_template` WHERE `entry`=2673;
INSERT INTO `creature_loot_template` VALUES
(2673,2592,0,0,0,1,1,1,1,'Training Dummy'),
(2673,2841,0,0,0,1,1,1,1,'Training Dummy'),
(2673,4359,0,0,0,1,1,1,2,'Training Dummy'),
(2673,4363,0,0,0,1,1,1,1,'Training Dummy'),
(2673,7191,0,20,0,1,0,1,1,'Training Dummy');
