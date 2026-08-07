-- DB update 2026_08_06_01 -> 2026_08_07_00
--
DELETE FROM `creature_text` WHERE (`CreatureID` = 25714);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25714, 0, 0, 'Okay, $N, here we go. Cross your fingers, toes, eyes and whatever else you can cross!', 12, 7, 100, 1, 0, 0, 24888, 0, 'Tinky Wickwhistle - Quest Reward 1'),
(25714, 1, 0, 'Oh no, it didn\'t work! Somehow I feel... lighter.', 12, 7, 100, 5, 0, 0, 24889, 0, 'Tinky Wickwhistle - Quest Reward 2');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25714;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25714);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25714, 0, 0, 0, 20, 0, 100, 0, 11699, 0, 0, 0, 0, 0, 80, 2571400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tinky Wickwhistle - On Quest \'I\'m Stuck in this Damned Cage... But Not For Long!\' Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2571400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2571400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tinky Wickwhistle - Actionlist - Set Orientation Invoker'),
(2571400, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tinky Wickwhistle - Actionlist - Say Line 0'),
(2571400, 9, 2, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 11, 45878, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tinky Wickwhistle - Actionlist - Cast \'Really Evil Twin\''),
(2571400, 9, 3, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tinky Wickwhistle - Actionlist - Say Line 1'),
(2571400, 9, 4, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tinky Wickwhistle - Actionlist - Set Orientation Home Position');
