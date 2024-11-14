DELETE FROM `smart_scripts` WHERE `entryorguid` = 24979 AND `source_type` = 0;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24979, 0, 0, 0, 9, 0, 100, 0, 1000, 1000, 1000, 1000, 10, 70, 11, 35932, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Range Check 10-70 yards - Cast Immolation Arrow every second'),
(24979, 0, 1, 0, 9, 0, 100, 0, 1000, 1000, 1000, 1000, 10, 70, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Range Check 10-70 yards - Cast Shoot every second'),
(24979, 0, 2, 0, 9, 0, 100, 0, 0, 10, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Melee Range - Enable Movement'),
(24979, 0, 3, 0, 9, 0, 100, 0, 0, 10, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Melee Range - Start Melee Attacks'),
(24979, 0, 4, 0, 9, 0, 100, 0, 1000, 1000, 1000, 1000, 10, 70, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Beyond Melee Range - Stop Movement'),
(24979, 0, 5, 0, 0, 0, 100, 0, 0, 0, 10000, 10000, 0, 0, 11, 35935, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - In Combat - Cast Immolation every 10 seconds');
