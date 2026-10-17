-- DB update 2025_07_02_01 -> 2025_07_03_00
-- Forces dispawn ignoring the "boss" rank for corpseDecay, his body should dispawn 20 seconds of dying and spawn 2 mins after
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31099 AND `id` = 3;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31099, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Patchwerk - On Just Died - Despawn In 20000 ms');
