-- DB update 2025_01_11_00 -> 2025_01_11_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16857) AND (`source_type` = 0) AND (`id` IN (3, 7, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16857, 0, 3, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marauding Crust Burster - On Reset - Set Bytes0'),
(16857, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marauding Crust Burster - On Aggro - Set Rooted On'),
(16857, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marauding Crust Burster - On Reset - Set Rooted Off');
