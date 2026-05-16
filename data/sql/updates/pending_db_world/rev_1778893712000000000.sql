--
UPDATE `smart_scripts` SET `link` = 2 WHERE (`entryorguid` = 23689 AND `source_type` = 0 AND `id` = 1);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23689 AND `source_type` = 0 AND `id` = 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23689, 0, 2, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 24170, 0, 0, 0, 0, 0, 18, 35, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Quest Credit \'Draconis Gastritis Bunny\'');
