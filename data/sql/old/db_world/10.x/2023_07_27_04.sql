-- DB update 2023_07_27_03 -> 2023_07_27_04
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17157 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17157, 0, 0, 0, 0, 0, 100, 0, 9600, 12900, 30600, 43600, 0, 11, 33840, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Rumbler - In Combat - Cast \'Earth Rumble\' '),
(17157, 0, 1, 0, 8, 0, 100, 513, 32001, 0, 0, 0, 0, 80, 1715700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Rumbler - On Spellhit \'Throw Gordawg\'s Boulder\' - Run Script (No Repeat)');
