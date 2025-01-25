-- DB update 2025_01_15_03 -> 2025_01_15_04
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23597) AND (`source_type` = 0) AND (`id` IN (12, 18));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23597, 0, 12, 0, 1, 1, 100, 515, 6200, 6200, 6200, 6200, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Remove Flags Immune To Players & Immune To NPC\'s (Phase 1) (No Repeat) (Normal Dungeon)'),
(23597, 0, 18, 0, 1, 2, 100, 515, 7600, 7600, 7600, 7600, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Remove Flags Immune To Players & Immune To NPC\'s (Phase 2) (No Repeat) (Normal Dungeon)');
