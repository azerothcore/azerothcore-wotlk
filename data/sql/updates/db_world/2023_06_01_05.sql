-- DB update 2023_06_01_04 -> 2023_06_01_05
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19716 AND `source_type` = 0 AND `id` IN (5, 6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19716, 0, 5, 6, 34, 2, 100, 1, 8, 0, 0, 0, 0, 11, 35058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Reached Point 0 - Cast \'Nether Explosion\' (Phase 2) (No Repeat)'),
(19716, 0, 6, 0, 61, 2, 100, 1, 0, 0, 0, 0, 0, 37, 1001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Reached Point 0 - Kill Self (Phase 2) (No Repeat)');
