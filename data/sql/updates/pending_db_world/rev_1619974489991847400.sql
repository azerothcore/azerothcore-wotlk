INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619974489991847400');

DELETE FROM `pool_creature` WHERE (`guid` IN (14616, 134014, 134015, 134016, 134017, 134018, 134019));
INSERT INTO `pool_creature` VALUES
(14616, 1003, 50, 'Or\'Kalar (2773) - Spawn 1'),
(134014, 1003, 10, 'Or\'Kalar (2773) - Spawn 2'),
(134015, 1003, 10, 'Or\'Kalar (2773) - Spawn 3'),
(134016, 1003, 10, 'Or\'Kalar (2773) - Spawn 4'),
(134017, 1003, 10, 'Or\'Kalar (2773) - Spawn 5'),
(134018, 1003, 5, 'Or\'Kalar (2773) - Spawn 6'),
(134019, 1003, 5, 'Or\'Kalar (2773) - Spawn 7');
