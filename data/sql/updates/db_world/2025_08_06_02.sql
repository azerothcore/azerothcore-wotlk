-- DB update 2025_08_06_01 -> 2025_08_06_02
-- Captain Arathyn & Azurebeak
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19635 AND `id` IN (5, 6, 7, 8));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21005 AND `id` IN (0, 1, 2, 5, 6, 7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19635, 0, 5, 6, 0, 0, 100, 1, 500, 500, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Arathyn - In Combat - Store Targetlist (No Repeat)'),
(19635, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 204, 21005, 0, 0, 0, 0, 0, 0, 0, 'Captain Arathyn - In Combat - Send Target 1 (No Repeat)'),
(19635, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 204, 21005, 0, 0, 0, 0, 0, 0, 0, 'Captain Arathyn - In Combat - Set Data 1 1 to Azurebeak (No Repeat)'),
(19635, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 21005, 0, 0, 0, 0, 0, 0, 0, 'Captain Arathyn - On Reset - Despawn Summons'),
(21005, 0, 0, 0, 0, 0, 100, 0, 9100, 9100, 11000, 14000, 0, 0, 11, 31273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azurebeak - In Combat - Cast \'Screech\''),
(21005, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Azurebeak - On Data Set 1 1 - Start Attacking'),
(21005, 0, 2, 0, 1, 0, 100, 0, 2000, 2000, 2000, 2000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Azurebeak - Out of Combat - Despawn Instant');
