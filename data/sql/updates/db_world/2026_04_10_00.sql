-- DB update 2026_04_05_03 -> 2026_04_10_00

-- Edit Actionlists
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2840600) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 4, 5, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2840600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 54238, 0, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Cast \'Duel Aura Check 01\''),
(2840600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Cast \'Duel Flag\''),
(2840600, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Say Line 0'),
(2840600, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Say Line 1'),
(2840600, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Say Line 2'),
(2840600, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Set Event Phase 2'),
(2840600, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Set Invincibility Hp 1%');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2840601) AND (`source_type` = 9) AND (`id` IN (7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2840601, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Enable Evade'),
(2840601, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2840602) AND (`source_type` = 9) AND (`id` IN (5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2840602, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Enable Evade'),
(2840602, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2840611) AND (`source_type` = 9) AND (`id` IN (7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2840611, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Enable Evade'),
(2840611, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Actionlist - Despawn Instant');
