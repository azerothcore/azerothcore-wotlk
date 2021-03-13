INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615643547619605800');

DELETE FROM `creature` WHERE (`id` = 1008) AND (`guid` IN (9418));
INSERT INTO `creature` VALUES
(9418, 1008, 0, 0, 0, 1, 1, 355, 1, -4155.5625, -2854.758057, 23.074253, 5.859894, 300, 0, 0, 531, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature` WHERE (`id` = 1007) AND (`guid` IN (9417));
INSERT INTO `creature` VALUES
(9417, 1007, 0, 0, 0, 1, 1, 3199, 1, -4194.87207, -2871.548828, 41.763573, 6.189762, 300, 0, 0, 494, 0, 0, 0, 0, 0, '', 0);
