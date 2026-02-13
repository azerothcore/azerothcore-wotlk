-- JHORDY LAPFORGE (Engineering(260 / Gnomish Engineer)) - Ultrasafe Transporter: Gadgetzan

-- Update Broadcast Text for base gossip to fix spacing
UPDATE `broadcast_text` SET `MaleText` = 'With some of the technology that was recovered by bold gnomes venturing into Gnomeregan, I have managed to construct my greatest invention: The Matter Transporter!$B$BAll I need now is a skilled Gnomish Engineer to build a powerful beacon attuned to the transporter.' WHERE (`ID` = 9996);

-- Update NPC Text for base gossip to fix spacing
UPDATE `npc_text` SET `text0_0` = 'With some of the technology that was recovered by bold gnomes venturing into Gnomeregan, I have managed to construct my greatest invention: The Matter Transporter!$B$BAll I need now is a skilled Gnomish Engineer to build a powerful beacon attuned to the transporter.' WHERE (`ID` = 7251);

-- Update Broadcast Text for learn schematic gossip
UPDATE `broadcast_text` SET `MaleText` = 'Once you have built the device, you simply activate the device to be whisked away to lovely Gadgetzan! Nearly everyone who has used the device has arrived on the pad here looking just the way they did when they began!$B$BThere have been some reported problems with transportees being replaced by their evil selves from an alternate universe, but I''m sure we will have that worked out soon...' WHERE (`ID` = 9998);

-- Update NPC Text for learn schematic gossip
UPDATE `npc_text` SET `text0_0` = 'Once you have built the device, you simply activate the device to be whisked away to lovely Gadgetzan! Nearly everyone who has used the device has arrived on the pad here looking just the way they did when they began!$B$BThere have been some reported problems with transportees being replaced by their evil selves from an alternate universe, but I''m sure we will have that worked out soon...' WHERE (`ID` = 7252);

-- Add gossip option (0) to learn schematic
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 6094) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(6094, 0, 0, 'I must build a beacon for this marvelous device!', 9997, 1, 1, 6095, 0, 0, 0, '', 0, 0);

-- Add gossip menu for learn schematic
DELETE FROM `gossip_menu` WHERE (`MenuID` = 6095) AND (`TextID` IN (7252));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6095, 7252);

-- Add gossip text for already learned schematic
DELETE FROM `gossip_menu` WHERE (`MenuID` = 6094) AND (`TextID` IN (7253));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6094, 7253);

-- Add condition to show gossip option if engineering >= 260
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 6094) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 7) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 202) AND (`ConditionValue2` = 260) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6094, 0, 0, 0, 7, 0, 202, 260, 0, 0, 0, 0, '', 'Show option to learn Ultrasafe Transporter: Gadgetzan if engineering >= 260');

-- Add condition to show gossip option if player has Gnomish Engineer
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 6094) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20219) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6094, 0, 0, 0, 25, 0, 20219, 0, 0, 0, 0, 0, '', 'Show option to learn Ultrasafe Transporter: Gadgetzan if player has Gnomish Engineer');

-- Add condition to show gossip option if player does NOT have schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 6094) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23489) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6094, 0, 0, 0, 25, 0, 23489, 0, 0, 1, 0, 0, '', 'Show option to learn Ultrasafe Transporter: Gadgetzan if player does NOT already have schematic');

-- Add condition to show alt gossip text if player has schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6094) AND (`SourceEntry` = 7253) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23489) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6094, 7253, 0, 0, 25, 0, 23489, 0, 0, 0, 0, 0, '', 'Show learned schematic gossip text if player already has Ultrasafe Transporter: Gadgetzan schematic');

-- Add condition to show base gossip text if player does NOT have schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6094) AND (`SourceEntry` = 7251) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23489) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6094, 7251, 0, 0, 25, 0, 23489, 0, 0, 1, 0, 0, '', 'Show base gossip text if player does not have Ultrasafe Transporter: Gadgetzan schematic');

-- Update Jhordy to use SMART-AI and FORCE-GOSSIP
UPDATE `creature_template` SET `type_flags` = 134217728, `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 14743) AND (`name` = 'Jhordy Lapforge');

-- Add Smart-AI to learn spell Ultrasafe Transporter: Gadgetzan to invoker(player)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14743) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14743, 0, 0, 0, 62, 0, 100, 0, 6094, 0, 0, 0, 0, 0, 134, 23491, 2, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Jhordy Lapforge - On Gossip Option 0 Selected - Invoker Cast \'Ultrasafe Transporter: Gadgetzan\'');
