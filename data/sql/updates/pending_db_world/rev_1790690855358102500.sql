-- A Suitable Disguise (20438 / 24556): port Shandy Glossgleam's laundry event to SmartAI (TrinityCore 36414de688).
-- A request that is not answered within 10 s fails and resets Shandy, so the next run starts clean.
-- Shandy respawns 1 s after she leaves, so the next player does not wait the full 5 min spawn timer.
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 36856;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_class` = 2, `unit_flags` = `unit_flags` | 33554432
WHERE `entry` IN (36944, 36945, 36946, 36947);

-- Shandy Glossgleam
SET @ENTRY := 36856;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 62, 0, 100, 0, 10854, 0, 0, 0, 0, 0, 80, @ENTRY*100+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Gossip Option 0 Selected - Run Script'),
(@ENTRY, 0, 1, 0, 62, 0, 100, 0, 10854, 1, 0, 0, 0, 0, 80, @ENTRY*100+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Gossip Option 1 Selected - Run Script'),
(@ENTRY, 0, 2, 0, 1, 1, 100, 0, 8000, 8000, 12000, 12000, 0, 0, 88, @ENTRY*100+1, @ENTRY*100+4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Out of Combat - Run Random Script (Phase 1)'),
(@ENTRY, 0, 3, 0, 38, 1, 100, 0, 1, 1, 0, 0, 0, 0, 80, @ENTRY*100+5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Data Set 1 1 - Run Script (Phase 1)'),
(@ENTRY, 0, 4, 0, 1, 1, 100, 0, 120000, 120000, 120000, 120000, 0, 0, 80, @ENTRY*100+6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Out of Combat - Run Script (Phase 1)'),
(@ENTRY, 0, 5, 0, 40, 0, 100, 0, 16, @ENTRY, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Waypoint 16 Reached - Despawn Instant (Respawn 1s)');

-- Shandy Glossgleam - start
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+0 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Close Gossip'),
(@ENTRY*100+0, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Npc Flag None'),
(@ENTRY*100+0, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 0'),
(@ENTRY*100+0, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 2'),
(@ENTRY*100+0, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Event Phase 1');

-- Shandy Glossgleam - request water
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+1 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 3'),
(@ENTRY*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36947, 1, 10000, 0, 0, 0, 8, 0, 0, 0, 0, 5796.970215, 693.942993, 658.351990, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Water\''),
(@ENTRY*100+1, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 9'),
(@ENTRY*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Npc Flag Gossip'),
(@ENTRY*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts');

-- Shandy Glossgleam - request pants
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+2 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 5'),
(@ENTRY*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36945, 1, 10000, 0, 0, 0, 8, 0, 0, 0, 0, 5796.970215, 693.942993, 658.351990, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Pants\''),
(@ENTRY*100+2, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 9'),
(@ENTRY*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Npc Flag Gossip'),
(@ENTRY*100+2, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts');

-- Shandy Glossgleam - request unmentionables
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+3 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 6'),
(@ENTRY*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36946, 1, 10000, 0, 0, 0, 8, 0, 0, 0, 0, 5796.970215, 693.942993, 658.351990, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Unmentionables\''),
(@ENTRY*100+3, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 9'),
(@ENTRY*100+3, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Npc Flag Gossip'),
(@ENTRY*100+3, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts');

-- Shandy Glossgleam - request shirts
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+4 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 4'),
(@ENTRY*100+4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36944, 1, 10000, 0, 0, 0, 8, 0, 0, 0, 0, 5796.970215, 693.942993, 658.351990, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Shirts\''),
(@ENTRY*100+4, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 9'),
(@ENTRY*100+4, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Npc Flag Gossip'),
(@ENTRY*100+4, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts');

-- Shandy Glossgleam - request done
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+5 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 1');

-- Shandy Glossgleam - laundry done
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+6 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+6, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts'),
(@ENTRY*100+6, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Orientation Closest Creature \'Aquanos\''),
(@ENTRY*100+6, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 7'),
(@ENTRY*100+6, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 8'),
(@ENTRY*100+6, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Set Data 3 3 on Closest Creature \'Aquanos\''),
(@ENTRY*100+6, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 53, 1, @ENTRY, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Start Waypoint');

-- Wants Shirts / Pants / Unmentionables / Water
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (36944, 36945, 36946, 36947) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36944, 0, 0, 1, 8, 0, 100, 1, 69593, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Shirts - On Spellhit \'Toss Shirts\' - Set Data 1 1 on Closest Creature \'Shandy Glossgleam\''),
(36944, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Shirts - On Link - Set Data 2 2 on Closest Creature \'Aquanos\''),
(36945, 0, 0, 1, 8, 0, 100, 1, 69600, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Pants - On Spellhit \'Toss Pants\' - Set Data 1 1 on Closest Creature \'Shandy Glossgleam\''),
(36945, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Pants - On Link - Set Data 2 2 on Closest Creature \'Aquanos\''),
(36946, 0, 0, 1, 8, 0, 100, 1, 69601, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Unmentionables - On Spellhit \'Toss Unmentionables\' - Set Data 1 1 on Closest Creature \'Shandy Glossgleam\''),
(36946, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Unmentionables - On Link - Set Data 2 2 on Closest Creature \'Aquanos\''),
(36947, 0, 0, 1, 8, 0, 100, 1, 69614, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Water - On Spellhit \'Toss Water\' - Set Data 1 1 on Closest Creature \'Shandy Glossgleam\''),
(36947, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Water - On Link - Set Data 2 2 on Closest Creature \'Aquanos\'');

-- Aquanos
DELETE FROM `smart_scripts` WHERE `entryorguid` = 36851 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36851, 0, 0, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 0, 11, 69659, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquanos - On Data Set 2 2 - Cast \'Evocation, Visual Only\''),
(36851, 0, 1, 0, 38, 0, 100, 0, 3, 3, 0, 0, 0, 0, 50, 201384, 60, 0, 0, 0, 0, 8, 0, 0, 0, 0, 5797.147461, 696.602417, 657.949463, 6.090852, 'Aquanos - On Data Set 3 3 - Summon Gameobject \'Clean Laundry\'');

-- Clean Laundry: the template chest is not consumable, so remove it once it is fully looted.
-- Anyone can open it and an empty loot also counts as looted, so only arm the removal once
-- a player on the quest has opened it.
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 201384;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201384 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201384, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Clean Laundry - On Loot State Activated - Set Event Phase 1'),
(201384, 1, 1, 0, 70, 1, 100, 0, 3, 0, 0, 0, 0, 0, 41, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Clean Laundry - On Loot State Just Deactivated - Remove From World (Phase 1)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` = 201384 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 201384, 1, 0, 9, 0, 20438, 0, 0, 0, 0, 0, '', 'Clean Laundry - Opener has A Suitable Disguise (A) incomplete'),
(22, 1, 201384, 1, 1, 9, 0, 24556, 0, 0, 0, 0, 0, '', 'Clean Laundry - Opener has A Suitable Disguise (H) incomplete');

-- Show each faction's gossip option only while its quest is in progress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 10854 AND `SourceEntry` IN (0, 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10854, 0, 0, 0, 9, 0, 20438, 0, 0, 0, 0, 0, '', 'Show gossip option 0 if player has A Suitable Disguise (A) incomplete'),
(15, 10854, 1, 0, 0, 9, 0, 24556, 0, 0, 0, 0, 0, '', 'Show gossip option 1 if player has A Suitable Disguise (H) incomplete');

-- Each Toss spell may only hit the imp that asks for it
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (69593, 69600, 69601, 69614);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 69593, 0, 0, 31, 0, 3, 36944, 0, 0, 0, 0, '', 'Toss Shirts targets Wants Shirts'),
(13, 1, 69600, 0, 0, 31, 0, 3, 36945, 0, 0, 0, 0, '', 'Toss Pants targets Wants Pants'),
(13, 1, 69601, 0, 0, 31, 0, 3, 36946, 0, 0, 0, 0, '', 'Toss Unmentionables targets Wants Unmentionables'),
(13, 1, 69614, 0, 0, 31, 0, 3, 36947, 0, 0, 0, 0, '', 'Toss Water targets Wants Water');

-- Laundry piles: the player casts Trigger Throw on themselves, like the goober Data10 path does
DELETE FROM `smart_scripts` WHERE `entryorguid` = 201295 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201295, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69542, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Pants - On Gossip Hello - Invoker Cast Trigger Throw Pants on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201296 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201296, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69543, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shirts - On Gossip Hello - Invoker Cast Trigger Throw Shirts on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201297 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201297, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69544, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Unmentionables - On Gossip Hello - Invoker Cast Trigger Throw Unmentionables on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201298 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201298, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69548, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Bucket - On Gossip Hello - Invoker Cast Trigger Throw Water on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201299 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201299, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69544, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Unmentionables - On Gossip Hello - Invoker Cast Trigger Throw Unmentionables on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201300 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201300, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69543, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shirts - On Gossip Hello - Invoker Cast Trigger Throw Shirts on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201301 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201301, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69542, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Pants - On Gossip Hello - Invoker Cast Trigger Throw Pants on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201855 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201855, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69548, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Bucket - On Gossip Hello - Invoker Cast Trigger Throw Water on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201931 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201931, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69542, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Pants - On Gossip Hello - Invoker Cast Trigger Throw Pants on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201932 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201932, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69543, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shirts - On Gossip Hello - Invoker Cast Trigger Throw Shirts on Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 201933 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(201933, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 69544, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Unmentionables - On Gossip Hello - Invoker Cast Trigger Throw Unmentionables on Invoker');

-- Shandy Glossgleam leaves after the laundry is done
DELETE FROM `waypoints` WHERE `entry` = 36856;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(36856, 1, 5800.057, 691.5624, 658.0007, NULL, 0, 'Shandy Glossgleam'),
(36856, 2, 5802.057, 691.5624, 658.0007, NULL, 0, 'Shandy Glossgleam'),
(36856, 3, 5802.307, 690.0624, 658.0007, NULL, 0, 'Shandy Glossgleam'),
(36856, 4, 5802.557, 688.8124, 658.0007, NULL, 0, 'Shandy Glossgleam'),
(36856, 5, 5802.824, 688.4631, 657.9935, NULL, 0, 'Shandy Glossgleam'),
(36856, 6, 5803.074, 686.4631, 658.2435, NULL, 0, 'Shandy Glossgleam'),
(36856, 7, 5803.574, 681.9631, 658.2435, NULL, 0, 'Shandy Glossgleam'),
(36856, 8, 5804.324, 677.7131, 658.2435, NULL, 0, 'Shandy Glossgleam'),
(36856, 9, 5804.842, 673.8136, 658.0798, NULL, 0, 'Shandy Glossgleam'),
(36856, 10, 5802.092, 671.8136, 658.3298, NULL, 0, 'Shandy Glossgleam'),
(36856, 11, 5801.806, 671.6563, 658.1652, NULL, 0, 'Shandy Glossgleam'),
(36856, 12, 5801.306, 671.1563, 658.1652, NULL, 0, 'Shandy Glossgleam'),
(36856, 13, 5800.306, 671.9063, 658.4152, NULL, 0, 'Shandy Glossgleam'),
(36856, 14, 5799.306, 672.9063, 657.4152, NULL, 0, 'Shandy Glossgleam'),
(36856, 15, 5798.056, 673.4063, 656.4152, NULL, 0, 'Shandy Glossgleam'),
(36856, 16, 5795.953, 674.7413, 654.7663, NULL, 0, 'Shandy Glossgleam');

-- Horde laundry piles, at the positions of their Alliance counterparts
SET @OGUID := 204;
DELETE FROM `gameobject` WHERE `id` IN (201934, 201935, 201936) AND `guid` BETWEEN @OGUID AND @OGUID+2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@OGUID+0, 201934, 571, 0, 0, 1, 1, 5806.32, 693.684, 657.949, 1.65332, 0, 0, 0.735673, 0.677337, 300, 0, 1, '', 0, NULL),
(@OGUID+1, 201935, 571, 0, 0, 1, 1, 5806.8, 692.833, 657.95, 3.34514, 0, 0, 0.994826, -0.101598, 300, 0, 1, '', 0, NULL),
(@OGUID+2, 201936, 571, 0, 0, 1, 1, 5806, 697.65, 657.95, 3.43308, 0, 0, 0.989398, -0.145228, 300, 0, 1, '', 0, NULL);
