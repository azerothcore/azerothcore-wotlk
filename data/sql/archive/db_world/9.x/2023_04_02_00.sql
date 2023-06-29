-- DB update 2023_04_01_02 -> 2023_04_02_00
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2202300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2202300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 19, 22160, 50, 0, 0, 0, 0, 0, 0, '[DND]Spirit 1 - Actionlist - Move To Closest Creature \'Bloodmaul Taskmaster\''),
(2202300, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DND]Spirit 1 - Actionlist - Move To Invoker'),
(2202300, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 33, 22383, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DND]Spirit 1 - Actionlist - Quest Credit \'On Spirit\'s Wings\'');
