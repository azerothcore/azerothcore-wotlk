-- ZAP FARFLINGER (Engineering(260 / Goblin Engineer)) - Dimensional Ripper: Everlook

-- Update NPC Text for base gossip to fix spacing
UPDATE `npc_text` SET `text0_0` = 'I have just completed a new dimensional imploder that will make me rich beyond my wildest goblin dreams! All I need to do is get a skilled Goblin Engineer to build a dimensional ripper that connects to it and try it!' WHERE (`ID` = 7249);DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6092) AND (`SourceEntry` = 7249) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23486) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

-- Dimensional Ripper gossip option already updated in Kablamm Farflinger update / Both brothers share post learn gossip texts

-- Add gossip option (0) to learn schematic
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 6092) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(6092, 0, 0, 'This Dimensional Imploder sounds dangerous! How can I make one?', 9994, 1, 1, 8309, 0, 0, 0, '', 0, 0);

-- Add gossip text for already learned schematic
DELETE FROM `gossip_menu` WHERE (`MenuID` = 6092) AND (`TextID` IN (10366));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6092, 10366);

-- Add condition to show gossip option if engineering >= 260
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 6092) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 7) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 202) AND (`ConditionValue2` = 260) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6092, 0, 0, 0, 7, 0, 202, 260, 0, 0, 0, 0, '', 'Show option to learn Dimensional Ripper: Everlook if engineering >= 260');

-- Add condition to show gossip option if player has Goblin Engineer
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 6092) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20222) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6092, 0, 0, 0, 25, 0, 20222, 0, 0, 0, 0, 0, '', 'Show option to learn Dimensional Ripper: Everlook if player has Goblin Engineer');

-- Add condition to show gossip option if player does NOT have schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 6092) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23486) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6092, 0, 0, 0, 25, 0, 23486, 0, 0, 1, 0, 0, '', 'Show option to learn Dimensional Ripper: Everlook if player does NOT already have schematic');

-- Add condition to show alt gossip text if player has schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6092) AND (`SourceEntry` = 10366) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23486) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6092, 10366, 0, 0, 25, 0, 23486, 0, 0, 0, 0, 0, '', 'Show learned schematic gossip text if player already has Dimensional Ripper: Everlook schematic');

-- Add condition to show base gossip text if player does NOT have schematic
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6092) AND (`SourceEntry` = 7249) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 25) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23486) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6092, 7249, 0, 0, 25, 0, 23486, 0, 0, 1, 0, 0, '', 'Show base gossip text if player does not have Dimensional Ripper: Everlook schematic');

-- Update Zap to use SMART-AI and FORCE-GOSSIP
UPDATE `creature_template` SET `type_flags` = 134217728, `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 14742) AND (`name` = 'Zap Farflinger');

-- Add Smart-AI to learn spell Dimensional Ripper: Everlook to invoker(player)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14742) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14742, 0, 0, 0, 62, 0, 100, 0, 6092, 0, 0, 0, 0, 0, 134, 23490, 2, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Zap Farflinger - On Gossip Option 0 Selected - Invoker Cast \'Dimension Ripper - Everlook\'');
