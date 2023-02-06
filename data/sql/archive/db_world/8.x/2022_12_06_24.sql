-- DB update 2022_12_06_23 -> 2022_12_06_24
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18113) AND (`source_type` = 0) AND (`id` IN (19));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18113, 0, 19, 0, 0, 1, 100, 0, 7000, 9000, 14000, 18000, 0, 11, 12024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Feralfen Hunter - In Combat - Cast \'Net\' (Phase 1)');
