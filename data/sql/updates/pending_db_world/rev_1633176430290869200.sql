INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633176430290869200');

DELETE FROM `gameobject` WHERE `guid`=12487;
DELETE FROM `gameobject` WHERE `guid`=2135425;
INSERT INTO `gameobject` VALUES (2135425, 1731, 1, 0, 0, 1, 1, -402.363, -4745.78, 38.7069, 0.0534247, -0, -0, -0.0267091, -0.999643, 300, 0, 1, '', 0);
