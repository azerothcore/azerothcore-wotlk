-- Scarlet Centurion with guid 39959 smart ai
SET @ENTRY := -39959;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4301;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3995900, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #3995900, walk, repeat, Aggressive');

SET @PATH := 3995900;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 921.6099, 1377.474, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 2, 910.2684, 1384.033, 18.14382, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 3, 908.9036, 1414.986, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 4, 922.2239, 1422.836, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 5, 940.1893, 1423.288, 18.19546, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 6, 953.9409, 1423.293, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 7, 962.9168, 1421.757, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 8, 964.4153, 1434.409, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 9, 962.9168, 1421.757, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 10, 953.9409, 1423.293, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 11, 940.1893, 1423.288, 18.19546, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 12, 922.2239, 1422.836, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 13, 908.9036, 1414.986, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 14, 910.2684, 1384.033, 18.14382, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 15, 921.6099, 1377.474, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 16, 942.4823, 1377.869, 18.22111, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 17, 959.5735, 1377.871, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 18, 963.7056, 1368.213, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 19, 963.7056, 1368.213, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 20, 959.5735, 1377.871, 18.04585, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol'),
(@PATH, 21, 942.4823, 1377.869, 18.22111, NULL, 0, 'Scarlet Monastery Guid 39959 Patrol');

-- Scarlet Sorcerer with guid 39998 smart ai
SET @ENTRY := -39998;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4294;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3999800, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #3999800, walk, repeat, Aggressive');

SET @PATH := 3999800;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES 
(@PATH, 1, 1048.8198 ,1454.7341 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 2, 1045.2096 ,1448.4248 ,29.248976, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 3, 1044.7418 ,1438.5563 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 4, 1031.598 ,1433.3317 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 5, 1011.3624 ,1437.2462 , 27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 6, 989.74774 ,1436.1188 , 27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 7, 986.0866 ,1418.0801 , 24.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 8, 964.4335 ,1418.325 , 18.84273, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 9, 986.0866 ,1418.0801 ,24.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 10, 989.74774 ,1436.1188 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 11, 1011.3624 ,1437.2462 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 12, 1031.598 ,1433.3317 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 13, 1044.7418 ,1438.5563 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol'),
(@PATH, 14, 1045.2096 ,1448.4248 ,29.248976, NULL, 0, 'Scarlet Monastery Guid 39998 Patrol');

-- Scarlet Myrmidon with guid 39967 smart ai
SET @ENTRY := -39967;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4300;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3996700, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #3996700, walk, repeat, Aggressive');

DELETE FROM `creature` WHERE (`id1` = 4300) AND (`guid` IN (39967));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(39967, 4300, 0, 0, 189, 0, 0, 1, 1, 1, 943.8057, 1360.7302, 18.795536, 3.1434457302093506, 86400, 2, 0, 3514, 5950, 1, 0, 0, 0, '', 0);

SET @PATH := 3996700;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 893.3013, 1360.65, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 2, 889.6783, 1367.656, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 3, 889.9191, 1398.58, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 4, 889.9798, 1430.839, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 5, 896.0825, 1437.567, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 6, 916.9831, 1437.534, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 7, 948.0972, 1437.544, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 8, 916.9831, 1437.534, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 9, 896.0825, 1437.567, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 10, 889.9798, 1430.839, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 11, 889.9191, 1398.58, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 12, 889.6783, 1367.656, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 13, 893.3013, 1360.65, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 14, 916.6596, 1360.68, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 15, 948.0366, 1360.763, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol'),
(@PATH, 16, 916.6596, 1360.68, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39967 Patrol');

-- Scarlet Centurion with guid 39978 smart ai
SET @ENTRY := -39978;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4301;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3997800, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once - Self: Start path #3997800, walk, repeat, Aggressive');

SET @PATH := 3997800;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES 
(@PATH, 1, 992.4866 ,1343.4125 ,29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 2, 1004.212 ,1343.4463 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 3, 1027.6887 ,1343.4991 ,29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 4, 1045.2471 ,1345.6957 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 5, 1045.5465 ,1356.4733 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 6, 1037.7705 ,1367.9752 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 7, 1040.2479 ,1383.3046 ,27.436476, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 8, 1045.2888 ,1401.2083 ,27.43648, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 9, 1038.3645 ,1413.4927 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 10, 1039.7012 ,1423.1774 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 11, 1046.1355 ,1442.3398 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 12, 1045.7563 ,1454.8784 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 13, 1033.3754 ,1454.7417 ,29.382483, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 14, 1004.4383 ,1454.7516 ,29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 15, 983.2637 ,1454.7847 ,29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 16, 1004.4383 ,1454.7516 ,29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 17, 1033.3754 ,1454.7417 ,29.382483, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 18, 1045.7563 ,1454.8784 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 19, 1046.1355 ,1442.3398 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 20, 1039.7401 ,1423.2935 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 21, 1038.3645 ,1413.4927 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 22, 1045.2888 ,1401.2083 ,27.43648, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 23, 1040.2479 ,1383.3046 ,27.436476, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 24, 1037.7705 ,1367.9752 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 25, 1045.5465 ,1356.4733 ,27.436478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 26, 1045.2471 ,1345.6957 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 27, 1040.5303 ,1345.1056 ,29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
-- (@PATH, 28, 1036.6069 ,1344.6147 , 29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
-- (@PATH, 29, 1036.2529 ,1344.5706 , 29.41444, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
-- (@PATH, 30, 1035.7527 ,1344.5079 , 29.24478, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
-- (@PATH, 31, 1031.2517 ,1343.9448 , 29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
-- (@PATH, 32, 1030.8684 ,1343.897 , 29.451473, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
-- (@PATH, 33, 1030.5647 ,1343.8589 , 29.247059, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 28, 1027.6887 ,1343.4991 , 29.248978, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol'),
(@PATH, 29, 1004.212 ,1343.4463 , 29.24898, NULL, 0, 'Scarlet Monastery Guid 39978 Patrol');

-- Scarlet Myrmidon with guid 39980 smart ai
SET @ENTRY := -39980;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4295;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3998000, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #3998000, walk, repeat, Aggressive');

SET @PATH := 3998000;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 1000.262, 1360.218, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 2, 986.8563, 1362.948, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 3, 985.2372, 1379.213, 24.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 4, 963.3975, 1379.723, 18.84273, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 5, 985.2372, 1379.213, 24.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 6, 986.8563, 1362.948, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 7, 1000.262, 1360.218, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 8, 1026.781, 1361.222, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 9, 1041.813, 1368.812, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 10, 1049.958, 1360.567, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 11, 1041.813, 1368.812, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol'),
(@PATH, 12, 1026.781, 1361.222, 27.43648, NULL, 0, 'Scarlet Monastery Guid 39980 Patrol');

UPDATE `creature` SET `id1`=4295, `id2`=0, `id3`=0, `map`=189, `zoneId`=0, `areaId`=0, `spawnMask`=1, `phaseMask`=1, `equipment_id`=1, `position_x`=1027.78, `position_y`=1399.18, `position_z`=27.3967, `orientation`=3.15905, `spawntimesecs`=86400, `wander_distance`=0, `currentwaypoint`=0, `curhealth`=3831, `curmana`=0, `MovementType`=0, `npcflag`=0, `unit_flags`=0, `dynamicflags`=0, `ScriptName`='', `VerifiedBuild`=0, `CreateObject`=0, `Comment`=NULL WHERE `guid`=39982;

-- Scarlet Wizard with guid 40015 smart ai
SET @ENTRY := -40015;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4300;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 4001500, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #4001500, walk, repeat, Aggressive');

SET @PATH := 4001500;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 1109.386, 1417.222, 30.44585, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 2, 1126.689, 1417.373, 30.64322, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 3, 1138.397, 1423.53, 30.49723, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 4, 1141.203, 1453.949, 30.44585, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 5, 1138.397, 1423.53, 30.49723, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 6, 1126.724, 1417.391, 30.70664, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 7, 1109.402, 1417.222, 30.44585, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 8, 1082.383, 1418.53, 30.44585, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 9, 1082.713, 1410.991, 30.55198, NULL, 0,'Scarlet Monastery Guid 40015 Patrol'),
(@PATH, 10, 1082.383, 1418.53, 30.44585, NULL, 0,'Scarlet Monastery Guid 40015 Patrol');

-- Scarlet Wizard with guid 40019 smart ai
SET @ENTRY := -40019;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4300;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 4001900, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #4001900, walk, repeat, Aggressive');

SET @PATH := 4001900;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 1117.623, 1380.505, 30.44585, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 2, 1136.148, 1379.347, 30.50507, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 3, 1137.257, 1363.06, 30.44585, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 4, 1140.875, 1349.175, 30.44586, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 5, 1137.257, 1363.06, 30.44585, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 6, 1136.148, 1379.347, 30.50507, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 7, 1117.623, 1380.505, 30.44585, NULL, 0,'Scarlet Monastery Guid 40019 Patrol'),
(@PATH, 8, 1091.545, 1380.518, 30.66889, NULL, 0,'Scarlet Monastery Guid 40019 Patrol');

-- Scarlet Chaplain with guid 40008 smart ai
SET @ENTRY := -40008;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4299;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 4000800, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #4000800, walk, repeat, Aggressive');

DELETE FROM `creature` WHERE (`id1` = 4299) AND (`guid` IN (40008));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(40008, 4299, 0, 0, 189, 0, 0, 1, 1, 1, 1081.6327, 1379.4738, 30.445854, 3.1230602264404297, 86400, 0, 1, 2901, 2014, 2, 0, 0, 0, '', 0);

DELETE FROM `creature_addon` WHERE (`guid` IN (40008));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(40008, 0, 0, 0, 0, 0, 0, NULL);

SET @PATH := 4000800;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 1081.633, 1379.474, 30.44585, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 2, 1081.354, 1385.916, 30.44585, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 3, 1081.633, 1379.474, 30.44585, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 4, 1100.825, 1379.118, 30.44586, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 5, 1128.136, 1379.364, 30.47259, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 6, 1137.428, 1373.87, 30.43785, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 7, 1140.826, 1345.011, 30.44586, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 8, 1137.428, 1373.87, 30.43785, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 9, 1128.276, 1379.281, 30.44585, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 10, 1100.825, 1379.118, 30.44586, NULL, 0,'Scarlet Monastery Guid 40008 Patrol'),
(@PATH, 11, 1081.633, 1379.474, 30.44585, NULL, 0,'Scarlet Monastery Guid 40008 Patrol');

UPDATE `creature` SET  `MovementType`=0 WHERE `guid`=40008;

-- delete waypoint_data path
DELETE FROM `waypoint_data` WHERE `id`=400080;

-- Scarlet Wizard with guid 40034 smart ai
SET @ENTRY := -40034;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4300;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 53, 0, 4003400, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Once (OOC) - Self: Start path #4003400, walk, repeat, Aggressive');

SET @PATH := 4003400;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 1, 1140.994, 1449.657, 30.44585, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 2, 1137.558, 1435.392, 30.44586, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 3, 1135.353, 1419.83, 30.53343, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 4, 1112.505, 1417.833, 30.44585, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 5, 1091.572, 1417.443, 30.44585, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 6, 1112.505, 1417.833, 30.44585, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 7, 1135.353, 1419.83, 30.53343, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 8, 1137.558, 1435.392, 30.44586, NULL, 0,'Scarlet Monastery Guid 40034 Patrol'),
(@PATH, 9, 1140.994, 1449.657, 30.44585, NULL, 0,'Scarlet Monastery Guid 40034 Patrol');

-- Replaces the generated coordinates
DELETE FROM `creature` WHERE (`id1` = 4302) AND (`guid` IN (40031));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(40031, 4302, 0, 0, 189, 0, 0, 1, 1, 1, 1138.5015, 1369.3634, 30.3899, 1.4660766124725342, 86400, 2, 1, 3540, 2472, 1, 0, 0, 0, '', 0);

DELETE FROM `creature_addon` WHERE (`guid` IN (40031));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(40031, 0, 0, 0, 1, 0, 0, NULL);

-- delete waypoint_data path
DELETE FROM `waypoint_data` WHERE `id`=400310;
