-- DB update 2026_10_10_07 -> 2026_10_10_08
--
SET @GUID := 58153;
SET @PATH := @GUID * 10;

DELETE FROM `creature_text` WHERE `CreatureID` = 16864;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16864, 0, 0, 'Where do you want these bottles?', 12, 7, 100, 1, 0, 0, 12798, 0, 'Stormwind Infantry'),
(16864, 0, 1, 'Got another shipment for you, Sid.', 12, 7, 100, 1, 0, 0, 12799, 0, 'Stormwind Infantry'),
(16864, 0, 2, 'Craziest thing - No matter how many bottles I take from the stockpile, the quantity on hand never decreases. It\'s like I\'m stuck in some endless loop of actions...', 12, 7, 100, 1, 0, 0, 12800, 0, 'Stormwind Infantry'),
(16864, 1, 0, '%s nods.', 16, 7, 100, 273, 0, 0, 13319, 0, 'Stormwind Infantry');

DELETE FROM `creature_text` WHERE `CreatureID` = 16826;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16826, 0, 0, 'Bless yer heart, soldier! Just put \'em in the back room.', 12, 7, 100, 1, 0, 0, 12801, 0, 'Sid Limbardi'),
(16826, 0, 1, 'Just leave \'em in the cellar.', 12, 7, 100, 1, 0, 0, 12802, 0, 'Sid Limbardi');

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @GUID AND `id` = 16864;

DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@GUID, @PATH, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -686.385, 2604.82, 86.8205, 0.480196, 0, 180000, 0, 0, 0, 100, 0),
(@PATH, 2, -691.207, 2612.31, 86.8205, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -692.789, 2615.88, 89.0356, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -694.695, 2622.96, 90.1075, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -690.474, 2632.93, 89.6493, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -681.026, 2642.45, 89.6308, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -679.96, 2643.33, 89.5278, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 8, -676.079, 2652.33, 89.4551, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 9, -683.296, 2672.44, 91.135, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 10, -691.312, 2677.85, 92.8546, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 11, -697.73, 2679.42, 93.8214, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 12, -703.916, 2680.7, 93.977, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 13, -709.742, 2703.19, 94.6914, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 14, -709.845, 2710.92, 94.8316, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 15, -709.813, 2713.01, 94.9769, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 16, -703.213, 2713.81, 94.737, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 17, -702.924, 2721.49, 94.4231, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 18, -703.556, 2730.55, 94.9842, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 19, -704.699, 2735.23, 94.9005, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 20, -705.576, 2736.91, 94.7334, NULL, 0, 13000, 0, 0, 0, 100, 0),
(@PATH, 21, -704.528, 2742.1, 94.7331, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 22, -711.543, 2742.86, 94.9752, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 23, -713.99, 2746, 94.9523, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 24, -714.34, 2747.43, 94.4032, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 25, -713.345, 2758.64, 87.9284, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 26, -711.17, 2759.31, 88.1836, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 27, -704.457, 2754.74, 87.5646, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 28, -704.557, 2753.35, 87.7123, 4.874504, 0, 8000, 0, 0, 0, 100, 0),
(@PATH, 29, -711.819, 2759.1, 87.9301, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 30, -714.008, 2757.47, 88.2508, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 31, -713.869, 2744.81, 94.7205, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 32, -704.527, 2743, 94.7323, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 33, -704.334, 2731.92, 94.9807, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 34, -703.802, 2728.73, 94.4215, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 35, -703.245, 2714.08, 94.7372, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 36, -709.237, 2711.93, 94.7216, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 37, -709.1, 2700.17, 94.5333, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 38, -709.751, 2696.8, 94.3956, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 39, -694.21, 2679.31, 93.231, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 40, -682.847, 2672.11, 91.0064, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 41, -679.444, 2666.9, 90.3499, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 42, -677.203, 2648.91, 89.4379, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 43, -683.666, 2640.91, 89.9481, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 44, -689.635, 2635.62, 89.8588, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 45, -691.457, 2610.44, 88.2721, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH, 46, -687.945, 2606.45, 87.2522, NULL, 0, 0, 0, 0, 0, 100, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = -@GUID AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (5815301, 5815302, 5815303, 1682600) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 108, 0, 100, 0, 1, @PATH, 0, 0, 0, 0, 80, 5815301, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - On Point 1 of Path 581530 Reached - Run Script'),
(-@GUID, 0, 1, 0, 108, 0, 100, 0, 20, @PATH, 0, 0, 0, 0, 80, 5815302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - On Point 20 of Path 581530 Reached - Run Script'),
(-@GUID, 0, 2, 0, 108, 0, 100, 0, 28, @PATH, 0, 0, 0, 0, 80, 5815303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - On Point 28 of Path 581530 Reached - Run Script'),
(5815301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Set Emote State \'Use Standing\''),
(5815301, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 71, 0, 0, 3756, 3757, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Equip Black and Green Bottles'),
(5815301, 9, 2, 0, 0, 0, 100, 0, 178000, 178000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Set Emote State \'None\''),
(5815302, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 57884, 16826, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Set Orientation To Sid Limbardi'),
(5815302, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Say Line 0'),
(5815302, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 80, 1682600, 0, 0, 0, 0, 0, 10, 57884, 16826, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Run Script (Sid Limbardi)'),
(5815302, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Say Line 1'),
(5815303, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Set Stand State Kneel'),
(5815303, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Unequip Bottles'),
(5815303, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Infantry - Actionlist - Remove Stand State Kneel'),
(1682600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 58153, 16864, 0, 0, 0, 0, 0, 0, 'Sid Limbardi - Actionlist - Set Orientation To Stormwind Infantry'),
(1682600, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sid Limbardi - Actionlist - Say Line 0'),
(1682600, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sid Limbardi - Actionlist - Set Home Orientation');
