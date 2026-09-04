-- DB update 2026_08_15_02 -> 2026_08_15_03
/*
15:43:47.253
Close Interaction
Remove Flags
15:43:49.115
Open Cage
15:43:50.332
Start Path
Text: So long, suckers. I'm out of here!
*/

DELETE FROM `waypoint_data` WHERE `id` = 283751;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `smoothTransition`, `move_type`) VALUES
(283751, 1, 4027.8062, 6375.1694, 28.96469, NULL, 1, 1), -- PathType: None
(283751, 2, 4044.9631, 6368.4707, 27.29592, NULL, 1, 1),
(283751, 3, 4056.1611, 6362.3037, 27.245745, NULL, 1, 1),
(283751, 4, 4063.8945, 6344.567, 24.264015, NULL, 1, 1),
(283751, 5, 4063.9614, 6313.688, 25.044909, NULL, 1, 1),
(283751, 6, 4059.0117, 6292.6987, 24.18087, NULL, 1, 1),
(283751, 7, 4073.856, 6280.3735, 25.858074, NULL, 1, 1),
(283751, 8, 4090.73, 6280.725, 27.397182, NULL, 1, 1),
(283751, 9, 4116.07, 6278.1797, 25.329634, NULL, 1, 1),
(283751, 10, 4134.756, 6283.0615, 29.011368, NULL, 1, 1),
(283751, 11, 4155.078, 6277.4043, 31.225716, NULL, 1, 1),
(283751, 12, 4164.9185, 6270.947, 29.695414, NULL, 1, 1);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28375;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28375);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28375, 0, 0, 0, 20, 0, 100, 0, 11569, 0, 0, 0, 0, 0, 80, 2837500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glrglrglr - On Quest \'Keymaster Urmgrgl\' Finished - Run Script'),
(28375, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glrglrglr - On Respawn - Add Npc Flags Gossip & Questgiver'),
(28375, 0, 2, 0, 109, 0, 100, 0, 0, 283751, 0, 0, 0, 0, 41, 0, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glrglrglr - On Path 283751 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2837500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2837500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glrglrglr - Actionlist - Remove Npc Flags Gossip & Questgiver'),
(2837500, 9, 1, 0, 0, 0, 100, 0, 1800, 1800, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 190567, 10, 0, 0, 0, 0, 0, 0, 'Glrglrglr - Actionlist - Activate Gameobject'),
(2837500, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glrglrglr - Actionlist - Say Line 0'),
(2837500, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 283751, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glrglrglr - Actionlist - Start Path 283751');

DELETE FROM `creature_text` WHERE (`CreatureID` = 28375);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28375, 0, 0, 'So long, suckers. I\'m out of here!', 12, 0, 100, 0, 0, 0, 27829, 0, 'Glrglrglr - Quest Complete');
