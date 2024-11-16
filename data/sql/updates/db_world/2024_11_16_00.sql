-- DB update 2024_11_15_04 -> 2024_11_16_00

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24979) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24979, 0, 0, 0, 1, 0, 100, 0, 3000, 3000, 5000, 5000, 0, 0, 11, 45101, 0, 0, 0, 0, 0, 19, 5202, 26, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Out of Combat - Cast \'Flaming Arrow\''),
(24979, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 0, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - In Combat - Cast \'Shoot\'');
