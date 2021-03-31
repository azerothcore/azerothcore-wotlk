INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617166961257812400');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4131);
INSERT INTO `smart_scripts` VALUES
(4131, 0, 0, 0, 0, 0, 100, 1, 4000, 7000, 22000, 25000, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Silithid Invader - In Combat - Cast \'Pierce Armor\' (No Repeat)'),
(4131, 0, 1, 0, 0, 0, 100, 1, 10000, 16000, 0, 0, 0, 11, 8137, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Silithid Invader - In Combat - Cast \'Silithid Pox\' (No Repeat)'),
(4131, 0, 2, 0, 2, 0, 100, 1, 1, 15, 0, 0, 0, 39, 30, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Silithid Invader - Between 1-15% Health - Call For Help (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4133);
INSERT INTO `smart_scripts` VALUES
(4133, 0, 1, 0, 2, 0, 100, 1, 1, 15, 0, 0, 0, 39, 30, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Silithid Hive Drone - Between 1-15% Health - Call For Help (No Repeat)');
