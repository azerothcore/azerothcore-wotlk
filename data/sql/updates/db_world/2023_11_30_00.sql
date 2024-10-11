-- DB update 2023_11_29_01 -> 2023_11_30_00
-- Wooly Mammoth Bull SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25743);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25743, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 46221, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Just Died - Cast \'Animal Blood\''),
(25743, 0, 1, 0, 27, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Passenger Boarded - Set ReactState Passive'),
(25743, 0, 2, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Passenger Removed - Despawn');
-- Wooly Mammoth Bull Flag Vehicle add
UPDATE `creature_template` SET `npcflag`= 16777216 WHERE  `entry`= 25743;
-- Wooly Mammoth Bull Vehicle condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 16 AND `SourceEntry`= 25743;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(16,0,25743,0,0,9,0,11879,0,0,0,0,'','Vehicle Wooly Mammoth Bull requires quest 11879');
-- Apply rep aura on quest accept 
DELETE FROM `spell_area` WHERE `spell`= 46234;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES 
(46234, 3537, 11879, 0, 0, 0, 2, 1, 74, 11);
-- Kaw Text
DELETE FROM `creature_text` WHERE `CreatureID`= 25802;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(25802, 0, 0, 'You challenge Kaw, destroyer of mammoths? Then face me and feel my thunder!', 14, 0, 100, 22, 0, 0, 25071, 0, 'Kaw the Mammoth Destroyer'),
(25802, 1, 0, 'Kaw\'s halberd breaks in two and falls to the ground!', 41, 0, 100, 0, 0, 930, 25087, 0, 'Kaw the Mammoth Destroyer');
-- Kaw SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25802, 0, 0, 1, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Just Died - Cast \'Drop War Halberd\''),
(25802, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Just Died - Alert Message'),
(25802, 0, 2, 3, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Respawn - Set Flags Immune To Players'),
(25802, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Respawn - Set Event Phase 1'),
(25802, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 98229, 25881, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Respawn - Respawn Closest Creature \'Moria\''),
(25802, 0, 5, 0, 38, 1, 100, 1, 1, 1, 0, 0, 0, 0, 80, 2580200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Data Set 1 1 - Run Script (Phase 1) (No Repeat)'),
(25802, 0, 6, 7, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 10, 98229, 25881, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Reached Home - Despawn Instant'),
(25802, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Reached Home - Despawn Instant'),
(25802, 0, 8, 0, 34, 0, 100, 0, 0, 1, 0, 0, 0, 0, 11, 46260, 0, 0, 0, 0, 0, 10, 98229, 25881, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Reached Point 1 - Cast \'Ride Vehicle\' (Sniffed: 43671)');
-- Kaw SAI Timed Actionlists
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2580200) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(2580200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - Actionlist - Set Event Phase 0'),
(2580200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - Actionlist - Say Line 0'),
(2580200, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 5, 53, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - Actionlist - Play Emote 53'),
(2580200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - Actionlist - Set Run On'),
(2580200, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3973.9749, 5477.6187, 35.615986, 0, 'Kaw the Mammoth Destroyer - Actionlist - Move To Position');
-- Kaw Update Loot
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25802);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25802, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Kaw the Mammoth Destroyer - Book of Glyph Mastery');
-- Moria SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25881);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25881, 0, 0, 1, 27, 0, 100, 1, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 10, 114932, 25802, 0, 0, 0, 0, 0, 0, 'Moria - On Passenger Boarded - Remove Flags Immune To Players (No Repeat)'),
(25881, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moria - On Passenger Boarded - Remove Flags Immune To Players'),
(25881, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Moria - On Passenger Boarded - Start Attacking (No Repeat)'),
(25881, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moria - On Respawn - Set Flags Immune To Players'),
(25881, 0, 4, 5, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 10, 114932, 25802, 0, 0, 0, 0, 0, 0, 'Moria - On Reached Home - Despawn Instant'),
(25881, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moria - On Reached Home - Despawn Instant');
-- Delete old Action List Moria
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2588100);

DELETE FROM `creature_addon` WHERE (`guid` IN (98229));	-- Delete old unneeded addon
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE (`entry` IN (25802, 25881));

-- AT
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4896;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4896, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 4896);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4896, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 114932, 25802, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1 (Kaw the Mammoth Destroyer)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 4896) AND (`SourceId` = 2) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 11879) AND (`ConditionValue2` = 8) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 4896, 2, 0, 47, 0, 11879, 8, 0, 0, 0, 0, '', 'Do not trigger Kaw the Mammoth Destroyer Event unless player has quest');
