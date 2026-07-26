-- DB update 2025_07_03_02 -> 2025_07_03_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16994) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16994, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 10000, 16000, 0, 0, 11, 17140, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Anchorite - In Combat - Cast \'Holy Fire\'');
