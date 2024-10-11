-- DB update 2023_03_09_04 -> 2023_03_11_00
-- Daggerfen Assassin 
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18116);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18116, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Assassin - On Reset - Cast \'Sneak\''),
(18116, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 10000, 10000, 0, 11, 35204, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Assassin - In Combat - Cast \'Toxic Fumes\'');
