-- DB update 2025_01_04_01 -> 2025_01_04_02
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23889) AND (`source_type` = 0) AND (`id` = 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23889, 0, 3, 0, 38, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - On Data Set 0 0 - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23597) AND (`source_type` = 0) AND (`id` IN (13, 19, 20, 21, 22));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23597, 0, 13, 21, 1, 1, 100, 3, 7000, 7000, 7000, 7000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Start Attacking (No Repeat) (Normal Dungeon)'),
(23597, 0, 19, 20, 1, 2, 100, 3, 7800, 7800, 7800, 7800, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Start Attacking (No Repeat) (Normal Dungeon)'),
(23597, 0, 20, 22, 61, 2, 100, 3, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Reactstate Aggressive (Phase 2) (No Repeat) (Normal Dungeon)'),
(23597, 0, 21, 22, 61, 1, 100, 3, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Reactstate Aggressive (Phase 2) (No Repeat) (Normal Dungeon)'),
(23597, 0, 22, 0, 61, 3, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Home Position (Phase 1+2) (No Repeat) (Normal Dungeon)');
