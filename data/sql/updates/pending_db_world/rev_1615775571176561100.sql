INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615775571176561100');

DELETE FROM `gameobject_addon` WHERE `guid` = 26628;
INSERT INTO `gameobject_addon` VALUES (26628, 0, 0);
UPDATE `gameobject` SET `position_x` = -8640.98, `position_y` = 760, `position_z` = 98.38 WHERE `guid` = 26628;
