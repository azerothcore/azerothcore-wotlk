-- DB update 2025_06_12_02 -> 2025_06_12_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30285) AND (`source_type` = 0) AND (`id` IN (5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30285, 0, 5, 0, 6, 0, 100, 515, 0, 0, 0, 0, 0, 0, 11, 56733, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Taldaram - Just Died - Cast \'Shadowfury\' (No Repeat) (Normal Dungeon)'),
(30285, 0, 6, 0, 6, 0, 100, 517, 0, 0, 0, 0, 0, 0, 11, 61463, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Taldaram - Just Died - Cast \'Shadowfury\' (No Repeat) (Heroic Dungeon)');
