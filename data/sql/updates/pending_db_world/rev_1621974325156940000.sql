INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621974325156940000');

DELETE FROM `gameobject` WHERE (`id` = 1731) AND (`guid` IN (5027));
INSERT INTO `gameobject` VALUES
(5027, 1731, 0, 0, 0, 1, 1, -9370.67, -1900.14, 74.7683, 2.61931, 0, 0, 0.915428, 0.402483, 900, 100, 1, '', 0);
