--
DELETE FROM `smart_scripts` WHERE `entryorguid`=1651800 AND `source_type`=9;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1651800, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Set Orientation Invoker'),
(1651800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Say Line 0'),
(1651800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33024, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Set Flag Immune To Players'),
(1651800, 9, 3, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 33, 16534, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Quest Credit \'Inoculation\''),
(1651800, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 89, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Start Random Movement'),
(1651800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Remove Flag Immune To Players'),
(1651800, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nestlewood Owlkin - On Script - Despawn in 10 seconds');
