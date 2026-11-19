-- DB update 2026_10_25_00 -> 2026_10_25_01
--
-- Three named Eversong and Ghostlands casters stand still when silenced or interrupted instead of closing
-- to melee, because their main attack lacks SMARTCAST_COMBAT_MOVE and their hand-rolled combat movement
-- cannot answer a failed cast. Same conversion as 478d64959 did for the Anub'ar casters.
--

-- 16249 Masophet the Black
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16249);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16249, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 20792, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Masophet the Black - On Aggro - Cast ''Frostbolt'''),
(16249, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 20792, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Masophet the Black - In Combat - Cast ''Frostbolt'''),
(16249, 0, 2, 0, 0, 0, 100, 0, 12000, 15000, 9000, 13000, 0, 0, 11, 16568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Masophet the Black - In Combat - Cast ''Mind Flay'''),
(16249, 0, 3, 0, 2, 0, 100, 513, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Masophet the Black - Between 0-15% Health - Flee For Assist (No Repeat)');

-- 16294 Aldaron the Reckless
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16294);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16294, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aldaron the Reckless - On Aggro - Cast ''Fireball'''),
(16294, 0, 1, 0, 0, 0, 100, 0, 4700, 5200, 4700, 5200, 0, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aldaron the Reckless - In Combat - Cast ''Fireball'''),
(16294, 0, 2, 0, 2, 0, 100, 512, 0, 15, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Aldaron the Reckless - Between 0-15% Health - Flee For Assist');

-- 16358 Kel'gash the Wicked
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16358);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16358, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 20802, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel''gash the Wicked - On Aggro - Cast ''Lightning Bolt'''),
(16358, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 20802, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel''gash the Wicked - In Combat - Cast ''Lightning Bolt'''),
(16358, 0, 2, 0, 9, 0, 100, 0, 0, 0, 9000, 13000, 0, 30, 11, 28900, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel''gash the Wicked - Within 0-30 Range - Cast ''Chain Lightning'''),
(16358, 0, 3, 0, 0, 0, 100, 0, 7000, 10000, 15000, 22000, 0, 0, 11, 7289, 32, 0, 0, 0, 0, 5, 0, 0, 0, 7289, 0, 0, 0, 0, 'Kel''gash the Wicked - In Combat - Cast ''Shrink''');
