-- DB update 2023_04_09_01 -> 2023_04_09_02
-- Blood Elf Defender
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=8581;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8581);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8581, 0, 0, 0, 0, 0, 100, 0, 7000, 12000, 11000, 14000, 0, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - In Combat - Cast \'Shield Block\''),
(8581, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 8000, 13000, 0, 11, 12170, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - In Combat - Cast \'Revenge\''),
(8581, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 858100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - On Just Summoned - Run Script'),
(8581, 0, 3, 0, 2, 0, 100, 513, 0, 50, 0, 0, 0, 80, 858101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - Between 0-50% Health - Run Script (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 858100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(858100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 51347, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - Actionlist - Cast \'Teleport Visual Only\''),
(858100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - Actionlist - Start Attacking'),
(858100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - Actionlist - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 858101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(858101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 8578, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 4279.11, -6295.57, 95.56, 0.05, 'Blood Elf Defender - Actionlist - Summon Creature \'Magus Rimtori\''),
(858101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - Actionlist - Say Line 1'),
(858101, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Defender - Actionlist - Say Line 2');

DELETE FROM `creature_text` WHERE `CreatureID`=8581;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(8581,0,0,'Who dares?! I will destroy you!',12,0,100,0,0,0,4502,0,'Blood Elf Defender'),
(8581,1,0,'Mistress!! They seek to destroy your work!!',12,0,100,0,0,0,4491,0,'Blood Elf Defender'),
(8581,2,0,'Ha! Now your death is ensured!',12,0,100,0,0,0,4492,0,'Blood Elf Defender');

-- Magus Rimtori
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=8578;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8578 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8578,0,0,0,0,0,100,0,0,0,3000,5000,11,20823,64,0,0,0,0,2,0,0,0,0,0,0,0,'Magus Rimtori - In Combat - Cast \'Fireball\''),
(8578,0,1,0,9,0,100,0,0,8,13000,16000,11,11831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magus Rimtori - Within 0-8 Range - Cast \'Frost Nova\''),
(8578,0,2,0,54,0,100,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magus Rimtori - On Just Summoned - Cast \'Teleport Visual Only\''),
(8578,0,3,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magus Rimtori - On Aggro - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID`=8578;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(8578,0,0,'You dare! Now feel my wrath!',14,0,100,0,0,0,4495,0,'Magus Rimtori');

-- Move from Event Scripts to SAI
DELETE FROM `event_scripts` WHERE `id` = 3241;

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 150140;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 150140);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(150140, 1, 0, 0, 71, 0, 100, 0, 3241, 0, 0, 0, 0, 12, 8581, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 4279.11, -6295.57, 95.56, 0.05, 'Arcane Focusing Crystal - On Event 3241 Inform - Summon Creature \'Blood Elf Defender\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 150140);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 150140, 1, 0, 29, 1, 8581, 50, 0, 1, 0, 0, '', 'Event will not run if it has already started'),
(22, 1, 150140, 1, 0, 29, 1, 8578, 50, 0, 1, 0, 0, '', 'Event will not run if it has already started');
