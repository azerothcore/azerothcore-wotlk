-- DB update 2026_10_15_04 -> 2026_10_15_05
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19174) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19174, 0, 0, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 35205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chieftain Mummaki - Between 0-50% Health - Cast \'Vanish\' (Phase 1) (No Repeat)'),
(19174, 0, 1, 0, 67, 0, 100, 0, 0, 0, 4800, 7200, 0, 5, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chieftain Mummaki - On Behind Target - Cast \'Backstab\''),
(19174, 0, 2, 0, 0, 0, 100, 0, 1000, 3000, 12000, 12000, 0, 0, 11, 30983, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chieftain Mummaki - In Combat - Cast \'Wound Poison\'');
