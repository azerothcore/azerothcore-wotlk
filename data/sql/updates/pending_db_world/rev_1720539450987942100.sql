-- Disgusting Oozeling
DELETE FROM `creature_text` WHERE (`CreatureID` = 15429);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15429, 0, 0, '%s guzzles down the ale!', 16, 0, 100, 0, 0, 0, 10167, 0, 'Disgusting Oozeling - Dark Iron Ale');

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 165578 AND `id` = 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(165578, 1, 4, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 15429, 20, 0, 0, 0, 0, 0, 0, 'Dark Iron Ale Mug - On Just Created - Set Data to Disgusting Oozeling');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15429;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15429);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15429, 0, 0, 0, 38, 0, 100, 0, 1, 1, 5000, 5000, 0, 0, 80, 1542900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - On Data Set 1 1 - Run Script'),
(15429, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 1542901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - On Reached Point 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1542900,1542901));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1542900, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - Actionlist - Move To Invoker \'Dark Iron Ale\''),
(1542901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 33, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - Actionlist - Play Emote 33'),
(1542901, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - Actionlist - Say Line 0'),
(1542901, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - Actionlist - Despawn Invoker In 1000 ms'),
(1542901, 9, 3, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 0, 29, 1, 90, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Disgusting Oozeling - Actionlist - Start Follow Owner Or Summoner');
