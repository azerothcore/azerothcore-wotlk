-- DB update 2026_10_03_07 -> 2026_10_03_08
-- A Suitable Disguise (20438 / 24556): port Shandy Glossgleam's laundry event to SmartAI (TrinityCore 36414de688).
-- Timings, positions and the run length follow WotLK Classic sniffs: a run is 7 requests, each request fails
-- about 12 s after it is asked, and either way Shandy walks off and respawns about 16 s later.
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 36856;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_class` = 2, `unit_flags` = `unit_flags` | 33554432
WHERE `entry` IN (36944, 36945, 36946, 36947);

-- Wants Shirts / Pants / Unmentionables / Water: rooted, with gravity disabled above the tub
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (36944, 36945, 36946, 36947);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(36944, 0, 0, 1, 1, 0, 0, 0),
(36945, 0, 0, 1, 1, 0, 0, 0),
(36946, 0, 0, 1, 1, 0, 0, 0),
(36947, 0, 0, 1, 1, 0, 0, 0);

-- Shandy Glossgleam
SET @ENTRY := 36856;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 62, 0, 100, 0, 10854, 0, 0, 0, 0, 0, 80, @ENTRY*100+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Gossip Option 0 Selected - Run Script'),
(@ENTRY, 0, 1, 0, 62, 0, 100, 0, 10854, 1, 0, 0, 0, 0, 80, @ENTRY*100+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Gossip Option 1 Selected - Run Script'),
(@ENTRY, 0, 2, 0, 1, 1, 100, 0, 8200, 8800, 13000, 14000, 0, 0, 88, @ENTRY*100+1, @ENTRY*100+4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Out of Combat - Run Random Script (Phase 1)'),
(@ENTRY, 0, 3, 4, 72, 1, 100, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Action 1 Done - Say Line 1 (Phase 1)'),
(@ENTRY, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Link - Remove Timed Event 1'),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Link - Add 1 to Counter 1'),
(@ENTRY, 0, 6, 0, 77, 1, 100, 0, 1, 7, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Counter 1 Set to 7 - Set Event Phase 2 (Phase 1)'),
(@ENTRY, 0, 7, 0, 59, 1, 100, 0, 1, 0, 0, 0, 0, 0, 80, @ENTRY*100+5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Timed Event 1 Triggered - Run Script (Phase 1)'),
(@ENTRY, 0, 8, 0, 59, 2, 100, 0, 2, 0, 0, 0, 0, 0, 80, @ENTRY*100+6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Timed Event 2 Triggered - Run Script (Phase 2)'),
(@ENTRY, 0, 9, 0, 109, 0, 100, 0, 0, @ENTRY*10+1, 0, 0, 0, 0, 41, 0, 16, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - On Path 368561 Finished - Despawn Instant (Respawn 16s)');

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
(@ENTRY*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36947, 1, 11500, 0, 0, 0, 8, 0, 0, 0, 0, 5796.801, 694.002, 658.032, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Water\''),
(@ENTRY*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 12000, 12500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 1 (Request Failed)'),
(@ENTRY*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 11600, 11600, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 2 (Laundry Done)');

-- Shandy Glossgleam - request pants
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+2 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 5'),
(@ENTRY*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36945, 1, 11500, 0, 0, 0, 8, 0, 0, 0, 0, 5796.801, 694.002, 658.032, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Pants\''),
(@ENTRY*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 12000, 12500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 1 (Request Failed)'),
(@ENTRY*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 11600, 11600, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 2 (Laundry Done)');

-- Shandy Glossgleam - request unmentionables
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+3 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 6'),
(@ENTRY*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36946, 1, 11500, 0, 0, 0, 8, 0, 0, 0, 0, 5796.801, 694.002, 658.032, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Unmentionables\''),
(@ENTRY*100+3, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 12000, 12500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 1 (Request Failed)'),
(@ENTRY*100+3, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 11600, 11600, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 2 (Laundry Done)');

-- Shandy Glossgleam - request shirts
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+4 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 4'),
(@ENTRY*100+4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 36944, 1, 11500, 0, 0, 0, 8, 0, 0, 0, 0, 5796.801, 694.002, 658.032, 0, 'Shandy Glossgleam - Actionlist - Summon Creature \'Wants Shirts\''),
(@ENTRY*100+4, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 12000, 12500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 1 (Request Failed)'),
(@ENTRY*100+4, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 11600, 11600, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Create Timed Event 2 (Laundry Done)');

-- Shandy Glossgleam - request failed
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+5 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts'),
(@ENTRY*100+5, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 9'),
(@ENTRY*100+5, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, @ENTRY*10+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Start Path 368562'),
(@ENTRY*100+5, 9, 3, 0, 0, 0, 100, 0, 11600, 11600, 0, 0, 0, 0, 41, 0, 16, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Despawn Instant (Respawn 16s)');

-- Shandy Glossgleam - laundry done
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ENTRY*100+6 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY*100+6, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Reset All Scripts'),
(@ENTRY*100+6, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.88496, 'Shandy Glossgleam - Actionlist - Set Orientation 1.88496'),
(@ENTRY*100+6, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 7'),
(@ENTRY*100+6, 9, 3, 0, 0, 0, 100, 0, 6700, 6700, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Say Line 8'),
(@ENTRY*100+6, 9, 4, 0, 0, 0, 100, 0, 600, 600, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Do Action 2 on Closest Creature \'Aquanos\''),
(@ENTRY*100+6, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 232, @ENTRY*10+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shandy Glossgleam - Actionlist - Start Path 368561');

-- Wants Shirts / Pants / Unmentionables / Water
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (36944, 36945, 36946, 36947) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36944, 0, 0, 1, 8, 0, 100, 1, 69593, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Shirts - On Spellhit \'Toss Shirts\' - Do Action 1 on Closest Creature \'Shandy Glossgleam\''),
(36944, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Shirts - On Link - Do Action 1 on Closest Creature \'Aquanos\''),
(36945, 0, 0, 1, 8, 0, 100, 1, 69600, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Pants - On Spellhit \'Toss Pants\' - Do Action 1 on Closest Creature \'Shandy Glossgleam\''),
(36945, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Pants - On Link - Do Action 1 on Closest Creature \'Aquanos\''),
(36946, 0, 0, 1, 8, 0, 100, 1, 69601, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Unmentionables - On Spellhit \'Toss Unmentionables\' - Do Action 1 on Closest Creature \'Shandy Glossgleam\''),
(36946, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Unmentionables - On Link - Do Action 1 on Closest Creature \'Aquanos\''),
(36947, 0, 0, 1, 8, 0, 100, 1, 69614, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36856, 30, 0, 0, 0, 0, 0, 0, 'Wants Water - On Spellhit \'Toss Water\' - Do Action 1 on Closest Creature \'Shandy Glossgleam\''),
(36947, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 36851, 30, 0, 0, 0, 0, 0, 0, 'Wants Water - On Link - Do Action 1 on Closest Creature \'Aquanos\'');

-- Aquanos
DELETE FROM `smart_scripts` WHERE `entryorguid` = 36851 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36851, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 3685100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquanos - On Action 1 Done - Run Script'),
(36851, 0, 1, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 50, 201384, 30, 0, 0, 0, 0, 8, 0, 0, 0, 0, 5797.561, 696.262, 657.949, 5.235988, 'Aquanos - On Action 2 Done - Summon Gameobject \'Clean Laundry\'');

-- Aquanos - laundry tossed
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3685100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3685100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 69657, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquanos - Actionlist - Cast \'Water Splash (Self)\''),
(3685100, 9, 1, 0, 0, 0, 100, 0, 1900, 1900, 0, 0, 0, 0, 11, 69659, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquanos - Actionlist - Cast \'Evocation, Visual Only\'');

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

-- Shandy Glossgleam walks off after the laundry is done (path 1) or after a failed request (path 2)
SET @PATH := @ENTRY*10;
DELETE FROM `waypoint_data` WHERE `id` IN (@PATH+1, @PATH+2);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH+1, 1, 5800.057, 691.5624, 658.0007, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 2, 5802.057, 691.5624, 658.0007, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 3, 5802.307, 690.0624, 658.0007, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 4, 5802.557, 688.8124, 658.0007, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 5, 5802.824, 688.4631, 657.9935, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 6, 5803.074, 686.4631, 658.2435, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 7, 5803.574, 681.9631, 658.2435, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 8, 5804.324, 677.7131, 658.2435, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 9, 5804.842, 673.8136, 658.0798, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 10, 5802.092, 671.8136, 658.3298, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 11, 5801.806, 671.6563, 658.1652, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 12, 5801.306, 671.1563, 658.1652, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 13, 5800.306, 671.9063, 658.4152, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 14, 5799.306, 672.9063, 657.4152, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 15, 5798.056, 673.4063, 656.4152, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+1, 16, 5795.953, 674.7413, 654.7663, NULL, 0, 0, 0, 0, 0, 100, 0),
(@PATH+2, 1, 5802.909, 686.403, 658.028, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Horde laundry piles
SET @OGUID := 204;
DELETE FROM `gameobject` WHERE `id` IN (201934, 201935, 201936) AND `guid` BETWEEN @OGUID AND @OGUID+2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@OGUID+0, 201934, 571, 0, 0, 1, 1, 5806.0146, 694.6285, 657.949, 1.710422, 0, 0, 0.754709, 0.656059, 300, 0, 1, '', 52237, NULL),
(@OGUID+1, 201935, 571, 0, 0, 1, 1, 5805.5869, 691.0608, 657.9492, 0, 0, 0, 0, 1, 300, 0, 1, '', 52237, NULL),
(@OGUID+2, 201936, 571, 0, 0, 1, 1, 5805.3257, 697.5555, 657.949, 1.640607, 0, 0, 0.731353, 0.681999, 300, 0, 1, '', 52237, NULL);

-- Laundry piles and water buckets of both factions at their sniffed positions. Both sets sit on the same spots;
-- the Horde has a single Unmentionables spawn and its bucket on the ground.
UPDATE `gameobject` SET `position_x` = 5806.047, `position_y` = 694.594, `position_z` = 657.949, `orientation` = 1.710421, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.754709, `rotation3` = 0.656059, `VerifiedBuild` = 45327 WHERE `id` = 201295 AND `guid` = 268924;
UPDATE `gameobject` SET `position_x` = 5805.592, `position_y` = 691.082, `position_z` = 657.949, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201296 AND `guid` = 268922;
UPDATE `gameobject` SET `position_x` = 5805.338, `position_y` = 697.573, `position_z` = 657.979, `orientation` = 1.640606, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.731352, `rotation3` = 0.681999, `VerifiedBuild` = 45327 WHERE `id` = 201297 AND `guid` = 268926;
UPDATE `gameobject` SET `position_x` = 5807.094, `position_y` = 690.587, `position_z` = 659.112, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201298 AND `guid` = 268916;
UPDATE `gameobject` SET `position_x` = 5806.068, `position_y` = 694.58, `position_z` = 658.457, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201931 AND `guid` = 268925;
UPDATE `gameobject` SET `position_x` = 5805.556, `position_y` = 691.102, `position_z` = 658.395, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201932 AND `guid` = 268923;
UPDATE `gameobject` SET `position_x` = 5805.316, `position_y` = 697.562, `position_z` = 658.306, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201933 AND `guid` = 268927;
UPDATE `gameobject` SET `position_x` = 5806.068, `position_y` = 694.58, `position_z` = 658.458, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201301 AND `guid` = 268919;
UPDATE `gameobject` SET `position_x` = 5805.579, `position_y` = 691.087, `position_z` = 658.361, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201300 AND `guid` = 268917;
UPDATE `gameobject` SET `position_x` = 5805.316, `position_y` = 697.562, `position_z` = 658.305, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201299 AND `guid` = 268920;
UPDATE `gameobject` SET `position_x` = 5806.817, `position_y` = 691.347, `position_z` = 657.949, `orientation` = 0, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1, `VerifiedBuild` = 45327 WHERE `id` = 201855 AND `guid` = 268918;
DELETE FROM `gameobject` WHERE `id` = 201299 AND `guid` = 268921;
