-- DB update 2024_05_13_00 -> 2024_05_14_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17908 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17908, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Giant Infernal - On Respawn - Start Random Movement 10y'),
(17908, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 35747, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Giant Infernal - On Respawn - Cast \'Flame Buffet\'');
