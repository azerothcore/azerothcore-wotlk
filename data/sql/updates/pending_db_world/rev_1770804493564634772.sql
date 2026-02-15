-- SMILES O'BYRON (Engineering(350 / Gnomish Engineer) - Ultrasafe Transporter: Toshley's Station)

-- Update NPC Text for base gossip to fix spacing
UPDATE `npc_text` SET `text0_0` = 'With the help of Engineer Lapforge from Gadgetzan I have built a powerful gnomish transporter here at Toshley''s Station! I would be happy to help any gnomish engineer with enough skill to build their own personal transport beacon.' WHERE (`ID` = 10410);

-- Update NPC Text for gossip option 1 to fix spacing
UPDATE `npc_text` SET `text0_0` = 'I cannot believe they made me move my transporter out of town! Most of the gnomes affected by the accident regained some sort of humanoid form within a few weeks and it should have been an honor to be a participant in such a grand gnomish experiment!$B$BBesides, we needed the eggs!' WHERE (`ID` = 10363);

-- Update NPC Text for already learned schematic gossip
UPDATE `npc_text` SET `text0_0` = 'I hope the Ultrasafe Transporter never lets you down! I just know it won''t but I would recommend carrying a parachute cloak just in case!' WHERE (`ID` = 10368);

-- Add NPC Text for learn Ultrasafe Transporter gossip concurrent to already learned schematic gossip
DELETE FROM `npc_text` WHERE (`ID` = 10369);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(10369, 'Once you have built the device, you simply activate the device to be transported to Toshley''s Station! A few people have reported being transformed into chickens, but I am sure they were exaggerating!$B$BIf possible I would try and not use the device on a day when someone else has, but it will probably work out alright even if you do!', '', 19133, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Add learn Ultrasafe Transporter: Toshley's Station gossip concurrent to Smiles' base gossip menu (8306) with correct text
DELETE FROM `gossip_menu` WHERE (`MenuID` = 8307) AND (`TextID` IN (10369));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8307, 10369);

-- Add gossip menu option (0)
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 8306) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8306, 0, 0, 'I must build a beacon for this marvelous device!', 9997, 1, 1, 8307, 0, 0, 0, '', 0, 0);

-- Add secondary gossip text for players that have already learned Ultrasafe Transporter
DELETE FROM `gossip_menu` WHERE (`MenuID` = 8306) AND (`TextID` IN (10368));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8306, 10368);

-- Add condition (Engineering >= 350) to show option 0
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 8306) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 7) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 202) AND (`ConditionValue2` = 350) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8306, 0, 0, 0, 7, 0, 202, 350, 0, 0, 0, 0, '', 'Show Ultrasafe Transporter gossip option if Engineering skill is >= 350');

-- Add condition (Has Gnomish Engineer) to show option 0
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 8306) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20219) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8306, 0, 0, 0, 25, 0, 20219, 0, 0, 0, 0, 0, '', 'Show Ultrasafe Transporter gossip option if player has Gnomish Engineer');

-- Add condition (NOT Learned Ultrasafe Transporter) to show option 0
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 8306) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 36955) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8306, 0, 0, 0, 25, 0, 36955, 0, 0, 1, 0, 0, '', 'Show Ultrasafe Transporter gossip option if not already learned');

-- Add condition to show base gossip text when Ultrasafe Transporter has NOT been learned
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8306) AND (`SourceEntry` = 10410) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 36955) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8306, 10410, 0, 0, 25, 0, 36955, 0, 0, 1, 0, 0, '', 'Show gossip text regarding ''Ultrasafe Transporter: Toshley''s Station'' if it has NOT been learned');

-- Add condition to show gossip text when Ultrasafe Transporter has already been learned
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8306) AND (`SourceEntry` = 10368) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 36955) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8306, 10368, 0, 0, 25, 0, 36955, 0, 0, 0, 0, 0, '', 'Show gossip text regarding ''Ultrasafe Transporter: Toshley''s Station'' if it has already been learned');

-- Update Smiles to use SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 21494) AND (`name` = 'Smiles O''Byron');

-- Add SmartAI to learn spell Ultrasafe Transporter: Toshley's Station to invoker(player) using triggered flag for spell (36957)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21494) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21494, 0, 0, 0, 62, 0, 100, 0, 8306, 0, 0, 0, 0, 0, 134, 36957, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Smiles O''Byron - On Gossip Option 0 Selected - Invoker Cast ''Ultrasafe Transporter - Toshley`s Station''');
