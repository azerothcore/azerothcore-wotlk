-- DB update 2022_10_20_01 -> 2022_10_21_00
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (15740, 15741, 15742);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15742) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15742, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 5000, 10000, 0, 11, 26167, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colossus of Ashi - In Combat - Cast \'Colossal Smash\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15741) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15741, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 5000, 10000, 0, 11, 26167, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colossus of Regal - In Combat - Cast \'Colossal Smash\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15740) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15740, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 5000, 10000, 0, 11, 26167, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,  'Colossus of Zora - In Combat - Cast \'Colossal Smash\'');
