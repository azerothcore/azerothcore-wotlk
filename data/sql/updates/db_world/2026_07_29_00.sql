-- DB update 2026_07_28_05 -> 2026_07_29_00
--
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 23784);

DELETE FROM `script_waypoint` WHERE `entry` = 23784;

DELETE FROM `creature_template_addon` WHERE (`entry` = 23784);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(23784, 0, 0, 0, 1, 0, 0, '5680');

SET @CGUID := 117903;
SET @PATH := @CGUID * 10;
DELETE FROM `waypoint_data` WHERE `id`= @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
(@PATH, 1 , 1379.813, -6409.201, 1.539683, NULL, 0, 1),
(@PATH, 2 , 1380.114, -6401.745, 2.517954, NULL, 0, 1),
(@PATH, 3 , 1380.114, -6401.745, 2.517954, 1.523505, 11000, 1),
(@PATH, 4 , 1394.768, -6387.708, 3.68069, NULL, 0, 1),
(@PATH, 5 , 1405.694, -6380.924, 4.62476, NULL, 0, 1),
(@PATH, 6 , 1416.18, -6370.656, 5.950443, NULL, 0, 1),
(@PATH, 7 , 1425.048, -6361.604, 6.354269, NULL, 0, 1),
(@PATH, 8 , 1427.955, -6350.528, 6.354269, NULL, 0, 1),
(@PATH, 9 , 1424.617, -6340.581, 5.786398, NULL, 0, 1),
(@PATH, 10, 1416.344, -6335.909, 5.705465, NULL, 0, 1),
(@PATH, 11, 1404.921, -6335.286, 6.229269, NULL, 0, 1),
(@PATH, 12, 1404.921, -6335.286, 6.229269, NULL, 0, 1),
(@PATH, 13, 1400.859, -6340.079, 6.476339, NULL, 0, 1),
(@PATH, 14, 1400.859, -6340.079, 6.476339, 3.994878, 9400, 1),
(@PATH, 15, 1419.282, -6332.309, 5.531731, NULL, 0, 1),
(@PATH, 16, 1428.454, -6335.082, 5.604269, NULL, 0, 1),
(@PATH, 17, 1446.955, -6338.777, 7.95246, NULL, 0, 1),
(@PATH, 18, 1457.27, -6343.141, 8.380317, NULL, 0, 1),
(@PATH, 19, 1465.724, -6345.168, 7.788642, NULL, 0, 1),
(@PATH, 20, 1465.724, -6345.168, 7.788642, 6.044203, 1600, 1),
(@PATH, 21, 1471.415, -6347.916, 7.629934, NULL, 5000, 1),
(@PATH, 22, 1461.322, -6337.461, 7.834174, NULL, 0, 1),
(@PATH, 23, 1465.077, -6331.357, 7.562849, NULL, 0, 1),
(@PATH, 24, 1475.621, -6327.219, 7.119575, NULL, 0, 1),
(@PATH, 25, 1490.551, -6315.318, 8.244208, NULL, 0, 1),
(@PATH, 26, 1497.682, -6311.022, 7.41413, NULL, 0, 1),
(@PATH, 27, 1506.431, -6317.528, 7.372158, NULL, 10600, 1),
(@PATH, 28, 1513.499, -6287.491, 5.818699, NULL, 0, 1),
(@PATH, 29, 1513.937, -6277.724, 5.583104, NULL, 0, 1),
(@PATH, 30, 1523.013, -6259.255, 4.599159, NULL, 0, 1),
(@PATH, 31, 1538.941, -6220.414, 6.434206, NULL, 0, 1),
(@PATH, 32, 1554.772, -6204.828, 6.688478, NULL, 0, 1),
(@PATH, 33, 1566.746, -6192.293, 7.589974, NULL, 0, 1),
(@PATH, 34, 1583.782, -6168.592, 8.31788, NULL, 0, 1),
(@PATH, 35, 1588.554, -6163.325, 7.81916, NULL, 0, 1),
(@PATH, 36, 1600.514, -6157.163, 8.667747, NULL, 0, 1),
(@PATH, 37, 1615.063, -6157.817, 9.339622, NULL, 0, 1);

DELETE FROM `creature_text` WHERE (`CreatureID` = 23784) AND (`GroupID` IN (1, 5));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23784, 1, 0, 'Yes, let us leave... but not before we leave our Alliance hosts something to remember us by!', 12, 1, 100, 16, 0, 0, 22486, 0, 'Apothecary Hanes'),
(23784, 5, 0, 'That\'ll teach you to mess with an apothecary, you motherless Alliance dogs!', 14, 1, 100, 14, 0, 0, 22491, 0, 'Apothecary Hanes');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23784;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23784);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23784, 0, 0 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2378400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Respawn - Run Script'),
(23784, 0, 1 , 0, 1, 0, 100, 0, 30000, 30000, 30000, 30000, 0, 0, 5, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Out of Combat - Play Emote OneShotBeg if Near Lieutenant Celeyne'),
(23784, 0, 2 , 0, 2, 0, 100, 0, 0, 75, 10000, 10000, 0, 0, 11, 17534, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Between 0-75% Health - Cast \'Healing Potion\''),
(23784, 0, 3 , 0, 19, 0, 100, 0, 11241, 0, 0, 0, 0, 0, 80, 2378401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Quest \'Trail of Fire\' Taken - Run Script'),
(23784, 0, 4 , 0, 108, 0, 100, 0, 3, 1179030, 0, 0, 0, 0, 80, 2378402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 3 Reached - Run Script'),
(23784, 0, 5 , 0, 108, 0, 100, 0, 14, 1179030, 0, 0, 0, 0, 80, 2378403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 14 Reached - Run Script'),
(23784, 0, 6 , 0, 108, 0, 100, 0, 20, 1179030, 0, 0, 0, 0, 80, 2378404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 20 Reached - Run Script'),
(23784, 0, 7 , 0, 108, 0, 100, 0, 21, 1179030, 0, 0, 0, 0, 80, 2378405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 21 Reached - Run Script'),
(23784, 0, 8 , 0, 108, 0, 100, 0, 27, 1179030, 0, 0, 0, 0, 80, 2378406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 27 Reached - Run Script'),
(23784, 0, 9 , 0, 108, 0, 100, 0, 34, 1179030, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 34 Reached - Say Line 7'),
(23784, 0, 10, 0, 108, 0, 100, 0, 37, 1179030, 0, 0, 0, 0, 80, 2378407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Point 37 Reached - Run Script'),
(23784, 0, 11, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 11241, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Just Died - Fail Quest \'Trail of Fire\''),
(23784, 0, 12, 0, 19, 0, 100, 0, 11241, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Quest \'Trail of Fire\' Taken - Store Targetlist');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Set Flag Standstate Kneel'),
(2378400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Add Npc Flags Questgiver'),
(2378400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1933, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Set Faction 1933');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Remove FlagStandstate Kneel'),
(2378401, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 0'),
(2378401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Set Faction 232'),
(2378401, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1179030, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Start Path 1179030');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378402);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378402, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 1'),
(2378402, 9, 1, 0, 0, 0, 100, 0, 4600, 4600, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 2');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378403);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378403, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 11, 42685, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Cast \'Burn\''),
(2378403, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 3');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378404);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378404, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 11, 42685, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Cast \'Burn\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378405);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378405, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 11, 42685, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Cast \'Burn\''),
(2378405, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 4');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378406);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378406, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 11, 42685, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Cast \'Burn\''),
(2378406, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Play Emote 11'),
(2378406, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 5'),
(2378406, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 6');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378407);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378407, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Set Orientation Stored'),
(2378407, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 8'),
(2378407, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 11241, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Quest Credit \'Trail of Fire\''),
(2378407, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Despawn Instant');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23968;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23968);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23968, 0, 0, 0, 8, 0, 100, 0, 42685, 0, 0, 0, 0, 0, 50, 182071, 60000, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hanes Fire Trigger - On Spellhit \'Burn\' - Summon Gameobject \'Small Chapel Fire\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 42685) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 23968) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 42685, 0, 0, 31, 0, 3, 23968, 0, 0, 0, 0, '', 'Spell \'Burn\' (42685) from \'Trail of Fire\' (11241) Quest Requires Target \'Hanes Fire Trigger\' (23968)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 23784) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 23964) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 23784, 0, 0, 29, 1, 23964, 5, 0, 0, 0, 0, '', 'Apothecary Hanes (23784) will only emote Beg when near an alive Lieutenant Celeyne (23964)');
