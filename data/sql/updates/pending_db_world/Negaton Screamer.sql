 -- Timed list 2087501 smart ai
SET @ENTRY := 2087501;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 2'),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Damage Reduction: Fire (34333) on Self'),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Elemental Response (36733) with flags triggered on Self'),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 11, 36742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 3 - 8 seconds - Self: Cast spell Fireball Volley (36742) on Self'),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 1.5 seconds - Self: Remove aura due to spell Damage Reduction: Fire (34333)'),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 1');

 -- Timed list 2087502 smart ai
SET @ENTRY := 2087502;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 2'),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Damage Reduction: Frost (34334) on Self'),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Elemental Response (36733) with flags triggered on Self'),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 11, 36741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 3 - 8 seconds - Self: Cast spell Frostbolt Volley (36741) on Self'),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 1.5 seconds - Self: Remove aura due to spell Damage Reduction: Frost (34334)'),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 1');

 -- Timed list 2087503 smart ai
SET @ENTRY := 2087503;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 2'),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Damage Reduction: Arcane (34331) on Self'),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Elemental Response (36733) with flags triggered on Self'),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 11, 36738, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 3 - 8 seconds - Self: Cast spell Arcane Volley (36738) on Self'),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 1.5 seconds - Self: Remove aura due to spell Damage Reduction: Arcane (34331)'),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 1');

 -- Timed list 2087504 smart ai
SET @ENTRY := 2087504;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 2'),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Damage Reduction: Nature (34335) on Self'),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Elemental Response (36733) with flags triggered on Self'),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 11, 36740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 3 - 8 seconds - Self: Cast spell Lightning Bolt Volley (36740) on Self'),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 1.5 seconds - Self: Remove aura due to spell Damage Reduction: Nature (34335)'),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 1');

 -- Timed list 2087505 smart ai
SET @ENTRY := 2087505;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 2'),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Damage Reduction: Shadow (34338) on Self'),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Elemental Response (36733) with flags triggered on Self'),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 11, 36736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 3 - 8 seconds - Self: Cast spell Shadow Bolt Volley (36736) on Self'),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 1.5 seconds - Self: Remove aura due to spell Damage Reduction: Shadow (34338)'),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 1');

 -- Timed list 2087506 smart ai
SET @ENTRY := 2087506;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 2'),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Damage Reduction: Holy (34336) on Self'),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Cast spell Elemental Response (36733) with flags triggered on Self'),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 11, 36743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 3 - 8 seconds - Self: Cast spell Holy Bolt Volley (36743) on Self'),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 1.5 seconds - Self: Remove aura due to spell Damage Reduction: Holy (34336)'),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Set event phase to phase 1');