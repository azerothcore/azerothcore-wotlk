-- DB update 2023_06_17_02 -> 2023_06_17_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16704) AND `source_type` = 0 AND `id` =5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16704, 0, 5, 0, 0, 0, 100, 0, 13350, 21000, 20700, 39250, 0, 11, 23601, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - In Combat - Cast \'Scatter Shot\'');
