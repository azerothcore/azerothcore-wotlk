INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621448294726234300');
SET @PATH_ID := 798570;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID AND `point`=14;
INSERT INTO `waypoint_data` VALUES (@PATH_ID, 14, -9038, 463.829, 93.2955, 0, 0, 0, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID AND `point`=20;
INSERT INTO `waypoint_data` VALUES (@PATH_ID, 20, -9038, 463.829, 93.2955, 0, 0, 0, 0, 100, 0);