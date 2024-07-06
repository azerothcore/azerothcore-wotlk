--
DELETE FROM `creature_text` WHERE (`CreatureID` = 22484);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22484, 0, 0, '%s gathers the warp chaser\'s blood.', 16, 0, 100, 0, 0, 0, 20371, 0, 'Zeppit - Gather blood');

UPDATE `smart_scripts` SET`target_param2` = 25 WHERE `entryorguid`=18884 AND `source_type`=0 AND `id`=3;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22484);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22484, 0, 0, 0, 38, 0, 100, 0, 1, 1, 3000, 3000, 0, 0, 69, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Zeppit - On Data Set 1 1 - Move To Invoker'),
(22484, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2248400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zeppit - On Reached Point 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2248400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2248400, 9, 0, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zeppit - Actionlist - Say Line 0'),
(2248400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39244, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Zeppit - Actionlist - Cast \'Gather Warp Chaser Blood\''),
(2248400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Zeppit - Actionlist - Start Follow Owner Or Summoner');
