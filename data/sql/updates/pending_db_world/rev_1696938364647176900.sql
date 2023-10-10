-- Unhatched Jubling Egg
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 23851);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6227) AND (`SourceEntry` = 7401);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 23851, 0, 0, 1, 0, 23852, 0, 0, 1, 0, 0, '', 'Allow using Unhatched Jubling Egg only if aura \'Jubling Cooldown\' (1 week) is missing.'),
(14, 6227, 7401, 0, 0, 8, 0, 7946, 0, 0, 0, 0, 0, '', 'Show gossip menu only if quest \'Spawn of Jubjub\' has been completed.');

-- Dark Iron Ale
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 165578) AND (`source_type` = 1) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(165578, 1, 3, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 14871, 5, 0, 0, 0, 0, 0, 0, 'Dark Iron Ale Mug - On Just Created - Set Data to Morja');

-- Morja
DELETE FROM `npc_text` WHERE `ID`=7401;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(7401, '', 'I\'m so happy that Jubjub returned!  I only hope that I don\'t run out of Dark Iron ale soon, or I fear my pet frog might once again escape!', 10169, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_text` WHERE `CreatureID`=14871;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14871, 0, 0, 'Hi Jubjub.  I missed you!', 12, 0, 100, 0, 0, 0, 10170, 0, 'Morja - Jubjub Summon'),
(14871, 1, 0, 'Jubjub?  Where are you, Jubjub?  Oh no!  Where did you go this time!', 12, 0, 100, 0, 0, 0, 10171, 0, 'Morja - Jubjub Despawn');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 6227) AND (`TextID` = 7401);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6227, 7401);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14871;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14871);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1487100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14871, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - On Respawn - Remove Npc Flags Questgiver'),
(14871, 0, 1, 0, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 0, 80, 1487100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - On Data Set 1 1 - Run Script'),
(1487100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Say Line 0'),
(1487100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Add Npc Flags Questgiver'),
(1487100, 9, 2, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Say Line 1'),
(1487100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Remove Npc Flags Questgiver');
