-- DB update 2025_07_27_01 -> 2025_07_27_02

-- Haerthsinger Forresten
DELETE FROM `creature_text` WHERE (`CreatureID` = 30551);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30551, 0, 0, 'This whole situation seems a bit paranoid, don\'t you think?', 12, 0, 100, 1, 0, 0, 31324, 0, ''),
(30551, 1, 0, 'Thank the Light for that.', 12, 0, 100, 1, 0, 0, 32573, 0, '');

-- Fras Siabi
DELETE FROM `creature_text` WHERE (`CreatureID` = 30552);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30552, 0, 0, 'It\'s a strange order, you can\'t deny. Suspicious food? Under that definition, you should arrest Belfast!', 12, 0, 100, 1, 0, 0, 31326, 0, ''),
(30552, 1, 0, '%s nods.', 16, 0, 100, 0, 0, 0, 32046, 0, '');

-- Footman James
DELETE FROM `creature_text` WHERE (`CreatureID` = 30553);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30553, 0, 0, 'Orders are orders. If the Prince says jump...', 12, 0, 100, 1, 0, 0, 31325, 0, ''),
(30553, 1, 0, 'Don\'t worry too much. By the time I went off duty, we hadn\'t found a scrap of befouled grain here.', 12, 0, 100, 1, 0, 0, 32572, 0, '');

-- Michael Belfast
DELETE FROM `creature_text` WHERE (`CreatureID` = 30571);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30571, 0, 0, 'Hey! Stop rooting around in my cellar! Clear out!', 12, 0, 100, 5, 0, 0, 31322, 0, ''),
(30571, 0, 1, 'What were you doing in my cellar? There\'s a food scare going on, and the last thing I need is strangers rummaging around in my goods! Shoo!', 12, 0, 100, 5, 0, 0, 31323, 0, ''),
(30571, 1, 0, 'I HEARD THAT! No more ale for you! Not a drop!', 12, 0, 100, 25, 0, 0, 31327, 0, '');

-- Mal Corricks
DELETE FROM `creature_text` WHERE (`CreatureID` = 31017);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31017, 0, 0, 'Enough, Michael. Business is hurting enough with this scare as it is. We can use every copper.', 12, 0, 100, 274, 0, 0, 32560, 0, ''),
(31017, 1, 0, '%s grudgingly nods.', 16, 0, 100, 0, 0, 0, 32569, 0, ''),
(31017, 2, 0, 'I can\'t argue with that.', 12, 0, 100, 1, 0, 0, 32570, 0, '');

-- Gryan Stoutmantle
DELETE FROM `creature_text` WHERE (`CreatureID` = 30561);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30561, 0, 0, 'The soldiers are doing important work. The safety of the people is more important, Mal, if you\'re interested in your customers living to spend another day.', 12, 0, 0, 1, 0, 0, 32571, 0, '');

-- Move old Waypoint into waypoint_data.
DELETE FROM `waypoints` WHERE `entry` IN (3057100);
DELETE FROM `waypoint_data` WHERE `id` IN (3057100);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("3057100", 1, 1549.5714, 575.55707, 100.05218, NULL, 10000, 0, 0, 100, 0),
("3057100", 2, 1550.5083, 579.5038, 99.76226, NULL, 10000, 0, 0, 100, 0),
("3057100", 3, 1553.4889, 578.15356, 99.76225, NULL, 10000, 0, 0, 100, 0);

-- Set New Waypoint (Michael Belfast)
DELETE FROM `waypoint_data` WHERE `id` IN (3057101);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("3057101", 1, 1554.98, 588.784, 99.7754, NULL, 0, 0, 0, 100, 0);

-- Set New SmartAI (Michael Belfast)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30571;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30571);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30571, 0, 0, 0, 38, 0, 100, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Data Set 0 1 - Say Line 0 (No Repeat)'),
(30571, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 3057100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Respawn - Start Path 3057100'),
(30571, 0, 2, 3, 108, 0, 100, 0, 1, 3057100, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 1 of Path 3057100 Reached - Set Emote State 0'),
(30571, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.5, 'Michael Belfast - On Point 1 of Path 3057100 Reached - Set Orientation 4.5'),
(30571, 0, 4, 5, 108, 0, 100, 0, 2, 3057100, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3, 'Michael Belfast - On Point 2 of Path 3057100 Reached - Set Orientation 3'),
(30571, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 2 of Path 3057100 Reached - Set Flag Standstate Kneel'),
(30571, 0, 6, 7, 108, 0, 100, 0, 3, 3057100, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 3 of Path 3057100 Reached - Remove FlagStandstate Kneel'),
(30571, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Point 3 of Path 3057100 Reached - Set Emote State 69'),
(30571, 0, 8, 0, 52, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3057100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Text 0 Over - Run Script'),
(30571, 0, 9, 10, 38, 0, 100, 0, 0, 2, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Data Set 0 2 - Remove FlagStandstate Kneel'),
(30571, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 3057101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Data Set 0 2 - Start Path 3057101'),
(30571, 0, 12, 0, 38, 0, 100, 0, 0, 3, 0, 0, 0, 0, 232, 3057100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - On Data Set 0 3 - Start Path 3057100');

-- Set New Timed Action List and Remove the old ones (Michael Belfast - Conversation).
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (3057100, 3057101, 3057102));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3057100, 9, 0, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 1970878, 30551, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 0'),
(3057100, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 1970880, 30553, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 0'),
(3057100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 1970879, 30552, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 0'),
(3057100, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Set Data 0 2'),
(3057100, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 1'),
(3057100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 1970865, 31017, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 0'),
(3057100, 9, 6, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 1970898, 30561, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 0'),
(3057100, 9, 7, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 1970865, 31017, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 1'),
(3057100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 10, 1970865, 31017, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 2'),
(3057100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Set Data 0 3'),
(3057100, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 1970880, 30553, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 1'),
(3057100, 9, 11, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 1970878, 30551, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 1'),
(3057100, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 1970879, 30552, 0, 0, 0, 0, 0, 0, 'Michael Belfast - Actionlist - Say Line 1');
