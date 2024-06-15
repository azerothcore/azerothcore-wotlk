-- DB update 2023_02_13_01 -> 2023_02_15_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 182589);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(182589, 1, 0, 0, 8, 0, 100, 1, 32744, 0, 0, 0, 0, 34, 10, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrel - On Spellhit \'Planting Incendiary Bomb\' - Set Instance Data 10 to 1 (No Repeat)');
