-- DB update 2026_04_05_02 -> 2026_04_05_03
-- Primal Ooze (6557)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6557) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6557, 0, 0, 0, 8, 0, 100, 512, 16031, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - On Spellhit 16031 (Releasing Corrupt Ooze) - Set Event Phase 2'),
(6557, 0, 1, 0, 8, 0, 100, 513, 15702, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - On Spellhit 15702 (Filling Empty Jar) - Despawn'),
(6557, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14146, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - Between 0-30% Health - Cast Clone (No Repeat)'),
(6557, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - Between 0-30% Health - Say Line 0 (No Repeat)'),
(6557, 0, 4, 5, 75, 2, 100, 513, 0, 10290, 3, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - Phase 2 - On Distance Creature 10290 within 3yd - Set Visibility Off'),
(6557, 0, 5, 6, 61, 2, 100, 513, 0, 0, 0, 0, 0, 0, 12, 9621, 6, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - Phase 2 (Link) - Summon Gargantuan Ooze'),
(6557, 0, 6, 7, 61, 2, 100, 513, 0, 0, 0, 0, 0, 0, 11, 16032, 0, 0, 0, 0, 0, 9, 9621, 0, 10, 0, 0, 0, 0, 0, 'Primal Ooze - Phase 2 (Link) - Cast Merging Oozes on Gargantuan Ooze'),
(6557, 0, 7, 0, 61, 2, 100, 513, 0, 0, 0, 0, 0, 0, 41, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - Phase 2 (Link) - Despawn In 50ms');

-- Captured Felwood Ooze (10290)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10290) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10290, 0, 0, 0, 54, 0, 100, 513, 0, 0, 0, 0, 0, 0, 29, 0, 0, 1, 0, 1, 0, 9, 6557, 0, 50, 0, 0, 0, 0, 0, 'Captured Felwood Ooze - On Just Summoned - Start Follow Closest Primal Ooze'),
(10290, 0, 1, 2, 75, 0, 100, 513, 0, 6557, 3, 500, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Felwood Ooze - Within 3yd of Primal Ooze - Set Visibility Off'),
(10290, 0, 2, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Felwood Ooze - Within 3yd (Link) - Despawn In 500ms');
