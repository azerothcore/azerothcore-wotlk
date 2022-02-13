INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644769898514768700');

UPDATE `creature_template` SET `skinloot`=3124 WHERE `entry`=3124;
DELETE FROM `skinning_loot_template` WHERE `entry`=3124;
INSERT INTO `skinning_loot_template` VALUES
(3124,2318,0,10,0,1,1,1,1,'Light Leather');
(3124,2934,0,88,0,1,1,1,1,'Ruined Leather Scraps');
