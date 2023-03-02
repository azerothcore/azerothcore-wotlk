-- DB update 2022_11_12_02 -> 2022_11_12_03
-- Remove animation on in comabt rather than on aggro
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17477) AND (`source_type` = 0) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17477, 0, 5, 0, 0, 0, 10, 512, 0, 0, 0, 0, 0, 28, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Remove Summon Visual');
