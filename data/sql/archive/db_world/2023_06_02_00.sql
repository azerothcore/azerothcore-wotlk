-- DB update 2023_06_01_06 -> 2023_06_02_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17160);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17160, 0, 0, 0, 23, 0, 100, 0, 12550, 0, 10000, 10000, 0, 11, 12550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Living Cyclone - On Missing Aura - Cast Lightning Shield'),
(17160, 0, 1, 0, 9, 0, 100, 0, 8, 40, 10000, 15000, 0, 11, 31705, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Living Cyclone - On Range - Cast Magnetic Pull');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19996) AND (`source_type` = 0) AND (`id` IN (1));
