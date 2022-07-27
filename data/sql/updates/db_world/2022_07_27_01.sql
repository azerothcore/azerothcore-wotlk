-- DB update 2022_07_27_00 -> 2022_07_27_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15325;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15325) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15325, 0, 0, 1, 9, 0, 100, 0, 0, 40, 11000, 16000, 0, 11, 25185, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Wasp - Within 0-40 Range - Cast \'Itch\''),
(15325, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 25185, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Wasp - Within 0-40 Range - Cast \'Itch\''),
(15325, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 25185, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Wasp - Within 0-40 Range - Cast \'Itch\'');
