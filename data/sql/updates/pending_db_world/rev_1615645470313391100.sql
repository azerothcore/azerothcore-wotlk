INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615645470313391100');

DELETE FROM `gameobject` WHERE (`id` = 1731) AND (`guid` IN (31011));
INSERT INTO `gameobject` VALUES
(31011, 1731, 0, 0, 0, 1, 1, -9893.121094, 1447.154175, 81.898338, -0.767945, 0, 0, 0.374607, -0.927184, 900, 100, 1, '', 0);

DELETE FROM `gameobject` WHERE (`id` = 1731) AND (`guid` IN (120595));
INSERT INTO `gameobject` VALUES
(120595, 1731, 0, 0, 0, 1, 1, -9892.582031, 1420.489136, 40.933098, 1.36136, 0, 0, 0, 1, 3600, 255, 1, '', 0);
                                                             
