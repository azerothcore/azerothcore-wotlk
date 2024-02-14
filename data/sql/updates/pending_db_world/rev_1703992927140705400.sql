 -- Cauldron Lord Bilemaw smart ai
SET @ENTRY := 11075;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 54, 0, 50, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell  Spawn Smoke (10389) on Self'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Talk %s emerges from the shadows to defend the cauldron! (1) to invoker'),
(@ENTRY, 0, 2, 0, 9, 0, 100, 0, 0, 5, 7000, 12000, 11, 13445, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'When victim in range 0 - 5 yards (cooldown 7000 - 12000 ms) - Self: Cast spell  Rend (13445) with flags aura not present on Victim'),
(@ENTRY, 0, 3, 0, 26, 0, 100, 0, 0, 5, 18000, 22000, 11, 3391, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On only hostile unit in line of sight (in combat) (wait 18000 - 22000 ms before next event trigger) - Self: Cast spell  Thrash  (3391) with flags aura not present on Self'),
(@ENTRY, 0, 4, 0, 26, 0, 100, 0, 0, 5, 7000, 12000, 11, 3427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On only hostile unit in line of sight (in combat) (wait 7000 - 12000 ms before next event trigger) - Self: Cast spell  Infected Wound (3427) on Victim'),
(@ENTRY, 0, 5, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Self: Talk $R flesh... must feed! (0) to Victim');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 11075 AND `SourceId` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 11075;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11075, 0, 0, '$R flesh... must feed!', 14, 0, 100, 0, 0, 0, 6494, 0, 'Cauldron Lord Bilemaw'),
(11075, 1, 0, '%s emerges from the shadows to defend the cauldron!', 16, 0, 100, 0, 0, 0, 6546, 0, 'Cauldron Lord Bilemaw');

 -- Cauldron Lord Razarch smart ai
SET @ENTRY := 11076;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 3.4 - 4.8 seconds (0 - 0s initially) (IC) - Self: Cast spell  Shadow Bolt (12471) with flags combat move on Victim'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 11000, 15000, 20000, 25000, 11, 17204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 - 25 seconds (11 - 15s initially) (IC) - Self: Cast spell  Summon Skeleton (17204) on Self'),
(@ENTRY, 0, 2, 0, 2, 0, 100, 0, 0, 50, 14000, 18000, 11, 17173, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'When health between 0%-50%% (cooldown 14000 - 18000 ms) - Self: Cast spell  Drain Life (17173) on Victim'),
(@ENTRY, 0, 3, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Self: Talk The Scourge beckons you, foolish $r. (0) to Victim'),
(@ENTRY, 0, 4, 5, 54, 0, 50, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell  Spawn Smoke (10389) on Self'),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Talk %s emerges from the shadows to defend the cauldron! (1) to invoker');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 11076 AND `SourceId` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 11076;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11076, 0, 0, 'The Scourge beckons you, foolish $r.', 14, 0, 100, 0, 0, 0, 6496, 0, 'Cauldron Lord Razarch'),
(11076, 1, 0, '%s emerges from the shadows to defend the cauldron!', 16, 0, 100, 0, 0, 0, 6546, 0, 'Cauldron Lord Razarch');

 -- Cauldron Lord Malvinious smart ai
SET @ENTRY := 11077;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 3 - 4 seconds (0 - 0s initially) (IC) - Self: Cast spell  Shadow Bolt (12471) on Victim'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 11000, 13000, 20000, 25200, 11, 17204, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 - 25.2 seconds (11 - 13s initially) (IC) - Self: Cast spell  Summon Skeleton (17204) on None'),
(@ENTRY, 0, 2, 0, 2, 0, 100, 0, 0, 50, 15000, 19000, 11, 17173, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'When health between 0%-50%% (cooldown 15000 - 19000 ms) - Self: Cast spell  Drain Life (17173) on Victim'),
(@ENTRY, 0, 3, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Self: Talk Who dares to approach this cauldron?  Taste my dark blade! (0) to Victim'),
(@ENTRY, 0, 4, 5, 54, 0, 100, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell  10389 (10389) on Self'),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Talk %s emerges from the shadows to defend the cauldron! (1) to invoker');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 11077 AND `SourceId` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 11077;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11077, 0, 0, 'Who dares to approach this cauldron?  Taste my dark blade!', 14, 0, 100, 0, 0, 0, 6495, 0, 'Cauldron Lord Malvinious'),
(11077, 1, 0, '%s emerges from the shadows to defend the cauldron!', 16, 0, 100, 0, 0, 0, 6546, 0, 'Cauldron Lord Malvinious');

 -- Cauldron Lord Soulwrath smart ai
SET @ENTRY := 11078;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 54, 0, 50, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell  10389 (10389) on Self'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Talk %s emerges from the shadows to defend the cauldron! (1) to invoker'),
(@ENTRY, 0, 2, 0, 26, 0, 100, 0, 0, 8, 12000, 15000, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On only hostile unit in line of sight (in combat) (wait 12000 - 15000 ms before next event trigger) - Self: Cast spell  Uppercut (10966) on Victim'),
(@ENTRY, 0, 3, 0, 0, 0, 100, 0, 5000, 8000, 14000, 20000, 11, 12946, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 14 - 20 seconds (5 - 8s initially) (IC) - Self: Cast spell  Putrid Stench (12946) on Victim'),
(@ENTRY, 0, 4, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Self: Talk $C - I will consume your light! (0) to Victim');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 11078 AND `SourceId` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 11078;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11078, 0, 0, '$C - I will consume your light!', 14, 0, 100, 0, 0, 0, 6497, 0, 'Cauldron Lord Soulwrath'),
(11078, 1, 0, '%s emerges from the shadows to defend the cauldron!', 12, 0, 100, 0, 0, 0, 6546, 0, 'Cauldron Lord Soulwrath');
