
-- Edit Action Lists 1985100, 1985101 & update comments.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (1985100, 1985101));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1985100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Active On'),
(1985100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(1985100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 2, 1985100, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Waypoint Path 1985100'),
(1985100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 15742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Cast \'Ashcrombe`s Teleport\''),
(1985100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Event Phase 2'),
(1985101, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Orientation Closest Creature \'Doctor Vomisa, Ph.T.\''),
(1985101, 9, 1, 0, 0, 0, 100, 0, 150, 150, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 0'),
(1985101, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(1985101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 70975, 19849, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Attacking');
