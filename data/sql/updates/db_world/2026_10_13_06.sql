-- DB update 2026_10_13_05 -> 2026_10_13_06
--
-- The three Skettis casters stand still when silenced instead of closing to melee, because their main
-- attack lacks SMARTCAST_COMBAT_MOVE and their hand-rolled combat movement never fires in that case.
-- Same conversion as 478d64959 did for the Anub'ar casters.
--

-- 21649 Skettis Windwalker
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21649);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21649, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 13901, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - On Aggro - Cast ''Arcane Bolt'' (No Repeat)'),
(21649, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 2400, 3800, 0, 0, 11, 13901, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - In Combat - Cast ''Arcane Bolt'''),
(21649, 0, 2, 0, 0, 0, 100, 0, 4000, 6500, 14000, 18000, 0, 0, 11, 40578, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - In Combat - Cast ''Cyclone'''),
(21649, 0, 3, 0, 14, 0, 100, 0, 3000, 40, 20000, 30000, 0, 0, 11, 34110, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Friendly At 3000 Health - Cast ''Shadow Mend''');

-- 21728 Skettis Surger
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21728);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21728, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 32011, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Surger - On Aggro - Cast ''Water Bolt'' (No Repeat)'),
(21728, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 2400, 3800, 0, 0, 11, 32011, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Surger - In Combat - Cast ''Water Bolt''');

-- 21730 Alluvion
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21730);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21730, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 38669, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvion - On Aggro - Cast ''Water Bolt'' (No Repeat)'),
(21730, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 2400, 3800, 0, 0, 11, 38669, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvion - In Combat - Cast ''Water Bolt'''),
(21730, 0, 2, 0, 106, 0, 100, 0, 4000, 8000, 14000, 18000, 0, 10, 11, 15063, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvion - In Combat - Cast ''Frost Nova''');
