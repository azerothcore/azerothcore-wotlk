-- DB update 2025_07_26_01 -> 2025_07_27_00
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 496101) AND (`source_type` = 9) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(496101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 1447, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dashel Stonefist - On Script - Quest Credit \'The Missing Diplomat\'');
