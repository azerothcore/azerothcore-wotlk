-- KABLAMM FARFLINGER (Engineering(350 / Goblin Engineer)) - Dimensional Ripper: Area 52

-- Update Broadcast Text for base gossip to fix spacing
UPDATE `broadcast_text` SET `MaleText` = 'With the help of my brother Zap in Everlook I have constructed a Dimensional Imploder right here in Area 52. Who needs a rocket when you have instant transportation via Goblin Engineering! Are you a skilled enough Goblin Engineer to learn how to build your own Imploder beacon?' WHERE (`ID` = 19134);

-- Update NPC Text for base gossip to fix spacing
UPDATE `npc_text` SET `text0_0` = 'With the help of my brother Zap in Everlook I have constructed a Dimensional Imploder right here in Area 52. Who needs a rocket when you have instant transportation via Goblin Engineering! Are you a skilled enough Goblin Engineer to lean how to build your own Imploder beacon?' WHERE (`ID` = 10365);

-- Update Broadcast Text for learn schematic gossip option (0)
UPDATE `broadcast_text` SET `MaleText` = 'This Dimensional Imploder sounds dangerous! How can I make one?', `FemaleText` = 'This Dimensional Imploder sounds dangerous! How can I make one?' WHERE (`ID` = 9994);

-- Update Broadcast Text for learn schematic gossip
UPDATE `broadcast_text` SET `MaleText` = 'The theory behind it is that we completely destroy you with a massive explosion wherever you are and send those particles through a dimensional rip and then re-implode you at the machine here. Instant Transport! It might not work ALL the time, but what kind of goblin engineer are you! If survival was your first priority you could never be a real Goblin Engineer!$B$BHere is the recipe you will need to make the Dimensional Ripper and try it out!' WHERE (`ID` = 9995);

-- Add NPC Text for learn schematic gossip
DELETE FROM `npc_text` WHERE (`ID` = 10367);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(10367, 'The theory behind it is that we completely destroy you with a massive explosion wherever you are and send those particles through a dimensional rip and then re-implode you at the machine here. Instant Transport! It might not work ALL the time, but what kind of goblin engineer are you! If survival was your first priority you could never be a real Goblin Engineer!$B$BHere is the recipe you will need to make the Dimensional Ripper and try it out!', '', 9995, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Update Broadcast Text for already learned schematic gossip text
UPDATE `broadcast_text` SET `MaleText` = 'It''s good to see an engineer brave enough to make the device. We goblin engineers laugh at danger!' WHERE (`ID` = 10000);

-- Add NPC Text for already learned schematic gossip text
DELETE FROM `npc_text` WHERE (`ID` = 10366);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(10366, 'It''s good to see an engineer brave enough to make the device. We goblin engineers laugh at danger!', '', 10000, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Update gossip option (0) to be correct (This NPC shouldn't be a trainer)
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 8308) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8308, 0, 0, 'This Dimensional Imploder sounds dangerous! How can I make one?', 9994, 1, 1, 8309, 0, 0, 0, '', 0, 0);

-- Add gossip menu for learn schematic
DELETE FROM `gossip_menu` WHERE (`MenuID` = 8309) AND (`TextID` IN (10367));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8309, 10367);

-- Add gossip text for already learned schematic
DELETE FROM `gossip_menu` WHERE (`MenuID` = 8308) AND (`TextID` IN (10366));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8308, 10366);

-- Add condition to show gossip option if engineering >= 350
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 8308) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 7) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 202) AND (`ConditionValue2` = 350) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8308, 0, 0, 0, 7, 0, 202, 350, 0, 0, 0, 0, '', 'Show option to learn Dimensional Ripper: Area 52 if engineering >= 350');

-- Add condition to show gossip option if player has Goblin Engineer
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 8308) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20222) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8308, 0, 0, 0, 25, 0, 20222, 0, 0, 0, 0, 0, '', 'Show option to learn Dimensional Ripper: Area 52 if player has Goblin Engineer');

-- Add condition to show gossip option if player does NOT have schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 8308) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 36954) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8308, 0, 0, 0, 25, 0, 36954, 0, 0, 1, 0, 0, '', 'Show option to learn Dimensional Ripper: Area 52 if player does NOT already have schematic');

-- Add condition to show alt gossip text if player has schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8308) AND (`SourceEntry` = 10366) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 36954) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8308, 10366, 0, 0, 25, 0, 36954, 0, 0, 0, 0, 0, '', 'Show learned schematic gossip text if player already has Dimensional Ripper: Area 52 schematic');

-- Add condition to show base gossip text if player does NOT have schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8308) AND (`SourceEntry` = 10365) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 36954) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8308, 10365, 0, 0, 25, 0, 36954, 0, 0, 1, 0, 0, '', 'Show base gossip text if player does not have Dimensional Ripper: Area 52 schematic');

-- Update Kablamm to use SMART-AI and FORCE-GOSSIP
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '', `type_flags` = 134217728 WHERE (`entry` = 21493) AND (`name` = 'Kablamm Farflinger');

-- Add Smart-AI to learn spell Dimensional Ripper: Area 52 to invoker(player)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21493) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21493, 0, 0, 0, 62, 0, 100, 0, 8308, 0, 0, 0, 0, 0, 134, 36956, 2, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '');
