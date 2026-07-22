-- DB update 2025_07_24_00 -> 2025_07_24_01

-- Set Waypoint (Martha Goslin)
DELETE FROM `waypoints` WHERE `entry` IN (2788400);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
("2788400", 1, 1639.9459, 725.77765, 113.55246, NULL, 'Martha Goslin'),
("2788400", 2, 1635.8268, 723.14343, 113.55243, NULL, 'Martha Goslin');

-- Set Timed Actionlist (Martha Goslin)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2788400,2788401));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2788400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.5, 'Martha Goslin - Actionlist - Set Orientation 4.5'),
(2788400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - Actionlist - Set Emote State 69'),
(2788401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3, 'Martha Goslin - Actionlist - Set Orientation 3'),
(2788401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - Actionlist - Set Emote State 69');

-- Set SmartAI (Martha Goslin)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27884;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27884);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27884, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2788400, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - On Reset - Start Patrol Path 2788400'),
(27884, 0, 1, 2, 40, 0, 100, 0, 1, 2788400, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - On Point 1 of Path 2788400 Reached - Pause Waypoint'),
(27884, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2788400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - On Point 1 of Path 2788400 Reached - Run Script'),
(27884, 0, 3, 4, 40, 0, 100, 0, 2, 2788400, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - On Point 2 of Path 2788400 Reached - Pause Waypoint'),
(27884, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2788401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Martha Goslin - On Point 2 of Path 2788400 Reached - Run Script');

-- Set Waypoint (Jena Anderson)
DELETE FROM `waypoints` WHERE `entry` IN (2788500);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
("2788500", 1, 1602.1324, 743.804, 114.724106, NULL, 'Jena Anderson'),
("2788500", 2, 1603.4928, 749.756, 114.72387, NULL, 'Jena Anderson');

-- Set Creature Text (Jena Anderson)
DELETE FROM `creature_text` WHERE (`CreatureID` = 27885);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27885, 0, 0, 'Strawberries! Oh wait, they\'re not in season.', 12, 0, 100, 1, 0, 0, 27222, 0, ''),
(27885, 0, 1, 'I need to make something healthy for him, he\'s still not recovered from that illness from last week.', 12, 0, 100, 1, 0, 0, 27221, 0, ''),
(27885, 0, 2, 'I\'ve got plenty of cured bacon, but he had some for breakfast.', 12, 0, 100, 1, 0, 0, 27220, 0, ''),
(27885, 0, 3, 'Let\'s see, we had chicken last night.', 12, 0, 100, 1, 0, 0, 27219, 0, '');

-- Set SmartAI (Jena Anderson)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27885;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27885);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27885, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2788500, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Reset - Start Patrol Path 2788500'),
(27885, 0, 1, 2, 1, 0, 100, 0, 25000, 30000, 25000, 30000, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Out of Combat - Pause Waypoint'),
(27885, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Out of Combat - Say Line 0');

-- Set Creature Text (Bartleby Battson)
DELETE FROM `creature_text` WHERE (`CreatureID` = 27907);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27907, 0, 0, 'I wasn\'t even supposed to be hree today!', 12, 0, 100, 1, 0, 0, 27256, 0, ''),
(27907, 0, 1, 'This grain shipment has been nothing but trouble!', 12, 0, 100, 14, 0, 0, 27254, 0, ''),
(27907, 0, 2, 'I knew I should have secured the wagon lock better when I was in Andorhal.', 12, 0, 100, 1, 0, 0, 27253, 0, ''),
(27907, 0, 3, 'I\'m going to lose my on time bonus because of this!', 12, 0, 100, 5, 0, 0, 27255, 0, '');

-- Set SmartAI (Bartleby Battson)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27907;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27907) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27907, 0, 0, 0, 1, 0, 100, 0, 20000, 25000, 20000, 25000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Out of Combat - Say Line 0');

-- Set Creature Text (Sergeant Morigan)
DELETE FROM `creature_text` WHERE (`CreatureID` = 27877);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27877, 0, 0, 'Mr. Perelli, if you happen across any signs of Scourge activity or shady dealings in your travels, let the nearest Lordaeron soldier know.', 12, 0, 100, 6, 0, 0, 27197, 0, ''), -- Yes
(27877, 1, 0, 'Mr. Perelli, I know you travel around quite a bit hawking your goods. Surely you\'ve heard rumors or information about the Scourge?', 12, 0, 100, 6, 0, 0, 27192, 0, ''), -- No
(27877, 2, 0, 'Mr. Perelli, have these goods been under your supervision at all times?', 12, 0, 100, 6, 0, 0, 27194, 0, ''), -- Yes
(27877, 3, 0, 'You wouldn\'t happen to have any canned turtle soup from Hillsbrad, would you?', 12, 0, 100, 6, 0, 0, 27195, 0, ''), -- Yes
(27877, 4, 0, 'Mr. Perelli, have you seen any signs of the undead? Any information you can provide would be appreciated by Prince Arthas.', 12, 0, 100, 6, 0, 0, 27191, 0, ''), -- No
(27877, 5, 0, 'Do you plan on leaving the area soon if we have further questions?', 12, 0, 100, 6, 0, 0, 27193, 0, ''); -- No

-- Set Action List (Sergeant Morigan)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2787700, 2787701, 2787702, 2787703, 2787704, 2787705));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2787700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 0'),
(2787701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 1'),
(2787702, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 2'),
(2787703, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 3'),
(2787704, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 4'),
(2787705, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 5');

-- Set SmartAI (Sergeant Morigan)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27877;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27877);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27877, 0, 0, 0, 1, 0, 100, 0, 30000, 35000, 30000, 35000, 0, 0, 87, 2787700, 2787701, 2787702, 2787703, 2787704, 2787705, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Out of Combat - Run Random Script'),
(27877, 0, 1, 0, 52, 0, 100, 0, 0, 27877, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 0 Over - Say Line 0'),
(27877, 0, 2, 0, 52, 0, 100, 0, 1, 27877, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 1 Over - Say Line 1'),
(27877, 0, 3, 0, 52, 0, 100, 0, 2, 27877, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 2 Over - Say Line 0'),
(27877, 0, 4, 0, 52, 0, 100, 0, 3, 27877, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 3 Over - Say Line 0'),
(27877, 0, 5, 0, 52, 0, 100, 0, 4, 27877, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 4 Over - Say Line 1'),
(27877, 0, 6, 0, 52, 0, 100, 0, 5, 27877, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 5 Over - Say Line 1');

-- Set Creature Text (Silvio Perelli)
DELETE FROM `creature_text` WHERE (`CreatureID` = 27876);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27876, 0, 0, 'Yes, Sergeant Morigan.', 12, 0, 100, 273, 0, 0, 27202, 0, ''),
(27876, 0, 1, 'Yes, sir.', 12, 0, 100, 273, 0, 0, 27201, 0, ''),
(27876, 1, 0, 'No, Sergeant.', 12, 0, 100, 1, 0, 0, 27198, 0, ''),
(27876, 1, 1, 'No, sir.', 12, 0, 100, 1, 0, 0, 27199, 0, '');

-- Set Waypoint (Michael Belfast)
DELETE FROM `waypoints` WHERE `entry` IN (3057100);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
("3057100", 1, 1549.5714, 575.55707, 100.05218, 4.2112427, 'Michael Belfast'),
("3057100", 2, 1550.5083, 579.5038, 99.76226, 2.6797037, 'Michael Belfast'),
("3057100", 3, 1553.4889, 578.15356, 99.76225, 5.83105, 'Michael Belfast');

-- Set SmartAI (Trigger)
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5291;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5291, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 5291);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5291, 2, 0, 0, 46, 0, 100, 0, 5291, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 1970932, 30571, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 0 1');

-- Add Creature Text (Michael Belfast)
DELETE FROM `creature_text` WHERE (`CreatureID` = 30571);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30571, 0, 0, 'Hey! Stop rooting around in my cellar! Clear out!', 12, 0, 100, 5, 0, 0, 31322, 0, '');

-- Add Action List (Michael Belfast)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (3057100, 3057101, 3057102));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3057100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Set Emote State 0'),
(3057100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.5, 'Michael Belfast - Actionlist - Set Orientation 4.5'),
(3057101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3, 'Michael Belfast - Actionlist - Set Orientation 3'),
(3057101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Set Flag Standstate Kneel'),
(3057102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Remove FlagStandstate Kneel'),
(3057102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Set Orientation Home Position'),
(3057102, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Set Emote State 69');

-- Set SmartAI (Michael Belfast)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30571;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30571);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30571, 0, 0, 0, 38, 0, 100, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Data Set 0 1 - Say Line 0 (No Repeat)'),
(30571, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 3057100, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Reset - Start Patrol Path 3057100'),
(30571, 0, 2, 3, 40, 0, 100, 0, 1, 3057100, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 1 of Path 3057100 Reached - Pause Waypoint'),
(30571, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3057100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 1 of Path 3057100 Reached - Run Script'),
(30571, 0, 4, 5, 40, 0, 100, 0, 2, 3057100, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 2 of Path 3057100 Reached - Pause Waypoint'),
(30571, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3057101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 2 of Path 3057100 Reached - Run Script'),
(30571, 0, 6, 7, 40, 0, 100, 0, 3, 3057100, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 3 of Path 3057100 Reached - Pause Waypoint'),
(30571, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3057102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 3 of Path 3057100 Reached - Run Script');

-- Add Creature Template Addon (Roger Owens)
DELETE FROM `creature_template_addon` WHERE (`entry` = 27903);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(27903, 0, 0, 8, 0, 0, 0, '');
