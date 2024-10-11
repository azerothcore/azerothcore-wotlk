-- DB update 2022_08_15_01 -> 2022_08_15_02
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15656) AND (`source_type` = 0) AND (`id` = 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15656, 0, 2, 0, 75, 0, 100, 0, 0, 15958, 20, 1200, 0, 49, 0, 0, 0, 0, 0, 0, 19, 15402, 53, 0, 0, 0, 0, 0, 0, 'Angershade - On Distance To Creature - Start Attacking');
