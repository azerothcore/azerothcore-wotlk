-- Wooly Mammoth Bull SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25743);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25743, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 46221, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Death - Cast Animal Blood'),
(25743, 0, 1, 0, 27, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Passenger board - Set react state passive'),
(25743, 0, 2, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Passenger remove - Despawn');
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
-- Kaw NON_ATTACKABLE until the start of the event
UPDATE `creature_template` SET `unit_flags` = 770 WHERE (`entry` = 25802);
-- Kaw speach on event start
DELETE FROM `creature_text` WHERE `CreatureID`= 25802;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(25802, 0, 0, 'You challenge Kaw, destroyer of mammoths? Then face me and feel my thunder!', 14, 0, 100, 22, 0, 0, 25071, 0, 'Kaw the Mammoth Destroyer'),
(25802, 1, 0, 'Kaw\'s halberd breaks in two and falls to the ground!', 41, 0, 100, 0, 0, 930, 25087, 0, 'Kaw the Mammoth Destroyer Death');
-- Kaw SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25802, 0, 0, 0, 101, 0, 100, 1, 1, 25, 0, 0, 0, 0, 80, 2580200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Min Players in Range - Run Script (No Repeat)'),
(25802, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On Just Died - Cast \'Drop War Halberd\''),
(25802, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw the Mammoth Destroyer - On just died - Alert Message');
-- Kaw SAI Timed Actionlists
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2580200) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(2580200, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw - Timed - Enable Running'),
(2580200, 9, 3, 0, 0, 0, 100, 1, 2500, 2500, 0, 0, 0, 0, 11, 46260, 2, 0, 0, 0, 0, 19, 25881, 100, 0, 0, 0, 0, 0, 0, 'Kaw - Timed - Mount to Moria'),
(2580200, 9, 2, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3974.17, 5476.31, 35.602, 5.564, 'Kaw - Timed - Move to Moria'),
(2580200, 9, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw - Timed - Yell');
-- Kaw Update Loot
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25802);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25802, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Kaw the Mammoth Destroyer - Book of Glyph Mastery');
-- Moria NON_ATTACKABLE until the start of the event
UPDATE `creature_template` SET `unit_flags` = 770 WHERE (`entry` = 25881);
-- Moria SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25881);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25881, 0, 0, 0, 27, 0, 100, 1, 0, 0, 0, 0, 0, 0, 19, 770, 0, 0, 0, 0, 0, 19, 25802, 100, 0, 0, 0, 0, 0, 0, 'Moria - Passenger Boarded - Remove Flags Immune To Kaw'),
(25881, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 0, 0, 28, 46260, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moria - Out of Combat - Remove Aura \'Riding Wooly Mammoth Bull\''),
(25881, 0, 2, 0, 27, 0, 100, 1, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Moria - Passenger Boarded - Attak Start On Player'),
(25881, 0, 3, 0, 27, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 770, 0, 0, 0, 0, 0, 19, 25881, 0, 0, 0, 0, 0, 0, 0, 'Moria - Passenger Boarded - Remove Flags Immune To Moria');
-- Delete old Action List Moria
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2588100);
