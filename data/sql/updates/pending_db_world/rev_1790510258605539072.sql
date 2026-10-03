--
-- 26319 Anub'ar Cultist
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26319);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26319, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 51605, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - On Aggro - Cast ''Zeal'' (No Repeat)'),
(26319, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - On Aggro - Cast ''Shadow Bolt'''),
(26319, 0, 2, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - In Combat - Cast ''Shadow Bolt'''),
(26319, 0, 3, 0, 1, 0, 100, 0, 3000, 6000, 15000, 35000, 0, 0, 11, 47257, 32, 0, 0, 0, 0, 11, 26607, 50, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - Out of Combat - Cast Empower');

-- 26607 Anub'ar Blightbeast
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26607);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26607, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 21971, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Blightbeast - On Aggro - Cast ''Poison Bolt'' (No Repeat)'),
(26607, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 21971, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Blightbeast - In Combat - Cast ''Poison Bolt'''),
(26607, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 20000, 24000, 0, 0, 11, 47443, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Blightbeast - In Combat - Cast ''Blighted Shriek''');

-- 26655 High Cultist Zangus
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26655, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Cultist Zangus - On Aggro - Cast ''Shadow Bolt'' (No Repeat)'),
(26655, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Cultist Zangus - In Combat - Cast ''Shadow Bolt'''),
(26655, 0, 2, 0, 2, 0, 100, 0, 0, 30, 120000, 125000, 0, 0, 11, 51605, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Cultist Zangus - Between 0-30% Health - Cast ''Zeal''');

-- 26770 Tivax the Breaker
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26770);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26770, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 13878, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - On Aggro - Cast ''Scorch'' (No Repeat)'),
(26770, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 13878, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - In Combat - Cast ''Scorch'''),
(26770, 0, 2, 0, 0, 0, 100, 0, 5000, 7000, 9000, 12000, 0, 0, 11, 20795, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - In Combat - Cast ''Fire Blast'''),
(26770, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - On Just Died - Say Line 0');
