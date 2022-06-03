-- Murlocs have a 40% chance of triggering the summon event
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (17190, 17191, 17192);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17190);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17190, 0, 0, 0, 6, 0, 40, 0, 0, 0, 0, 0, 0, 12, 17612, 1, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Murloc - On Just Died - Summon Creature \'Quel\'dorei Magewraith\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17191) AND (`source_type` = 0) AND (`id` IN (2, 4, 5, 7, 11, 13, 14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17191, 0, 2, 0, 1, 0, 100, 0, 0, 0, 605000, 605000, 0, 11, 12550, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - Out of Combat - Cast \'Lightning Shield\''),
(17191, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - On Aggro - Increment Phase (No Repeat)'),
(17191, 0, 5, 0, 9, 1, 100, 0, 0, 40, 3400, 4800, 0, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - Within 0-40 Range - Cast \'Wrath\' (Phase 1)'),
(17191, 0, 7, 0, 61, 1, 100, 512, 0, 7, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - Between 0-7% Mana - Increment Phase (Phase 1) (No Repeat)'),
(17191, 0, 11, 0, 3, 2, 100, 512, 15, 100, 100, 100, 0, 23, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - Between 15-100% Mana - Decrement Phase (Phase 2)'),
(17191, 0, 13, 14, 61, 0, 100, 512, 0, 15, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - Between 0-15% Health - Enable Combat Movement (No Repeat)'),
(17191, 0, 14, 0, 61, 0, 100, 512, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - Between 0-15% Health - Flee For Assist (No Repeat)'),
(17191, 0, 15, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 12, 17612, 1, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Oracle - On Just Died - Summon Creature \'Quel\'dorei Magewraith\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17192) AND (`source_type` = 0) AND (`id` IN (3, 5, 7, 9, 10, 12, 13, 14, 15, 17));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17192, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - On Aggro - Increment Phase (No Repeat)'),
(17192, 0, 5, 0, 61, 1, 100, 0, 5, 30, 2300, 3900, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Within 5-30 Range - Set Sheath Ranged (Phase 1)'),
(17192, 0, 7, 0, 61, 1, 100, 512, 25, 80, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Within 25-80 Range - Start Attacking (Phase 1)'),
(17192, 0, 9, 10, 61, 1, 100, 512, 0, 5, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Within 0-5 Range - Set Sheath Melee (Phase 1)'),
(17192, 0, 10, 0, 61, 1, 100, 512, 0, 5, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Within 0-5 Range - Start Attacking (Phase 1)'),
(17192, 0, 12, 0, 61, 1, 100, 512, 5, 15, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Within 5-15 Range - Stop Attacking (Phase 1)'),
(17192, 0, 13, 14, 2, 0, 100, 513, 0, 15, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Between 0-15% Health - Increment Phase (No Repeat)'),
(17192, 0, 14, 15, 61, 0, 100, 512, 0, 15, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Between 0-15% Health - Enable Combat Movement (No Repeat)'),
(17192, 0, 15, 0, 61, 0, 100, 512, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - Between 0-15% Health - Flee For Assist (No Repeat)'),
(17192, 0, 17, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 12, 17612, 1, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Siltfin Hunter - On Just Died - Summon Creature \'Quel\'dorei Magewraith\'');

-- Condition for SMARTAI
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 17190) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 9595) AND (`ConditionValue2` = 8) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 17190, 0, 0, 47, 0, 9595, 8, 0, 0, 0, 0, '', 'Spawn Magewraith if player has quest \'Control\'');

-- Remove current Magewraith spawns
DELETE FROM `creature` WHERE `id1` = 17612;

-- Magewraith SmartAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17612);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17612, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - On Respawn - Set Visibility Off (No Repeat)'),
(17612, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - On Respawn - Set Reactstate Passive (No Repeat)'),
(17612, 0, 2, 3, 1, 0, 100, 1, 2000, 3000, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - Out of Combat - Set Visibility On (No Repeat)'),
(17612, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - Out of Combat - Say Line 0 (No Repeat)'),
(17612, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - Out of Combat - Set Reactstate Aggressive (No Repeat)'),
(17612, 0, 5, 0, 0, 0, 100, 0, 0, 500, 16000, 20000, 0, 11, 11436, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - In Combat - Cast \'Slow\''),
(17612, 0, 6, 0, 0, 0, 100, 0, 1000, 2000, 3000, 4500, 0, 11, 11921, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - In Combat - Cast \'Fireball\''),
(17612, 0, 7, 0, 0, 0, 100, 0, 6000, 6500, 12000, 13500, 0, 11, 31604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - In Combat - Cast \'Arcane Weakness\''),
(17612, 0, 8, 0, 13, 0, 100, 0, 6500, 7500, 15000, 20000, 0, 11, 31596, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quel\'dorei Magewraith - In Combat - Cast \'Counterspell\'');
