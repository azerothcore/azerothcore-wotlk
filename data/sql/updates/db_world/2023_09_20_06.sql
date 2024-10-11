-- DB update 2023_09_20_05 -> 2023_09_20_06
-- Summoned Succubus
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5677;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5677);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5677, 0, 0, 0, 54, 0, 100, 513, 0, 0, 0, 0, 0, 0, 80, 567700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - On Just Summoned - Run Script (No Repeat)'),
(5677, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 7000, 11000, 0, 0, 11, 16583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - In Combat - Cast \'Shadow Shock\''),
(5677, 0, 2, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - On Reached Home - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 567700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(567700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - Actionlist - Set Faction 35'),
(567700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 7741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - Actionlist - Cast \'Summoned Demon\''),
(567700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - Actionlist - Say Line 0'),
(567700, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - Actionlist - Set Faction 14'),
(567700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Succubus - Actionlist - Start Attacking');

-- Summoned Voidwalker
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5676;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5676);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5676, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 0, 80, 567600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - On Just Summoned - Run Script (No Repeat)'),
(5676, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 7750, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - Between 0-30% Health - Cast \'Consuming Rage\' (No Repeat)'),
(5676, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - On Aggro - Say Line 1'),
(5676, 0, 3, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - On Reached Home - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 567600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(567600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - Actionlist - Set Faction 35'),
(567600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 7741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - Actionlist - Cast \'Summoned Demon\''),
(567600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - Actionlist - Say Line 0'),
(567600, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - Actionlist - Set Faction 14'),
(567600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Voidwalker - Actionlist - Start Attacking');
