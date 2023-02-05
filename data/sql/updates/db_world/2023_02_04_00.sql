-- DB update 2023_01_31_08 -> 2023_02_04_00
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15547) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15547, 0, 0, 0, 0, 0, 100, 0, 1000, 10000, 12000, 25000, 0, 11, 29320, 0, 0, 0, 0, 0, 28, 40, 0, 0, 0, 0, 0, 0, 0, 'Spectral Charger - In Combat - Cast \'Charge\''),
(15547, 0, 1, 0, 31, 0, 100, 0, 29320, 0, 0, 0, 0, 11, 29321, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Charger - On Target Spellhit \'Charge\' - Cast \'Fear\'');
