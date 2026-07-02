-- DB update 2026_07_02_01 -> 2026_07_02_02

-- Update Mkhail SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4963;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4963) AND (`source_type` = 0) AND (`id` IN (0, 1, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4963, 0, 1, 0, 19, 0, 100, 512, 1249, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mikhail - On Quest \'The Missing Diplomat\' Taken - Remove Npc Flags Questgiver'),
(4963, 0, 5, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 10000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mikhail - On Data Set 1 1 - Say Line 0');

-- Remove old Action List (it is not needed anymore).
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 496300) AND (`source_type` = 9);

-- Update Tapoke SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4962;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4962) AND (`source_type` = 0) AND (`id` IN (12, 13, 14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4962, 0, 12, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 4971, 0, 0, 0, 0, 0, 0, 0, 'Tapoke "Slim" Jahn - On Evade - Set Data 2 2'),
(4962, 0, 13, 14, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 10, 9432, 4963, 0, 0, 0, 0, 0, 0, 'Tapoke "Slim" Jahn - On Respawn - Add Npc Flags Questgiver (Mikhail)'),
(4962, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 10, 9432, 4963, 0, 0, 0, 0, 0, 0, 'Tapoke "Slim" Jahn - On Respawn - Set Active Off (Mikhail)'),
(4962, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tapoke "Slim" Jahn - On Respawn - Set Active Off');
