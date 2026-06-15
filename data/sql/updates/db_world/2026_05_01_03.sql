-- DB update 2026_05_01_02 -> 2026_05_01_03
--
-- Add an explicit CallForHelp action with a 60-yard radius because CallForAssistance's default 10-yard range is too small.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16573) AND (`source_type` = 0) AND (`id` = 6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16573, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 60, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - On Aggro - Call For Help');
