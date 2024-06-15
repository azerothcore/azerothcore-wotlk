-- DB update 2022_09_19_01 -> 2022_09_19_02
--
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (1946, 1986);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(1986, 'near_scarshield_infiltrator'),
(1946, 'at_scarshield_infiltrator');

-- Update Position and set kneel animation
-- VMangos Position: https://github.com/vmangos/core/blob/5073ba81290178612580acba6991bfba8bed632d/sql/migrations/20220402225440_world.sql
UPDATE `creature` SET `position_x`=57.0545, `position_y`=-399.681, `position_z`=64.4311, `orientation`=2.94961, `MovementType`=0 WHERE `guid`=42798;
DELETE FROM `creature_addon` WHERE `guid` = 42798;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES (42798, 0, 0, 8, 0, 0, 0, NULL);

-- Add condition to show gossip option
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 12039);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 12039, 1, 0, 0, 2, 0, 12219, 1, 0, 0, 0, 0, '', 'Show gossip option if player has Unadorned Seal of Ascension'),
(15, 12039, 1, 0, 0, 27, 0,   57, 3, 0, 0, 0, 0, '', 'Show gossip option if player is at least level 57'),
(15, 12039, 0, 0, 0, 2, 0, 12219, 1, 0, 1, 0, 0, '', 'Show gossip option if player does not have Unadorned Seal of Ascension'),
(15, 12039, 0, 0, 0, 27, 0,   57, 3, 0, 0, 0, 0, '', 'Show gossip option if player is at least level 57');

-- Add condition to send the right gossip text
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 10299);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 10299, 0, 0,  2, 0, 12219, 1, 0, 1, 0, 0, '', 'Show gossip text if player does not have Unadorned Seal of Ascension'),
(22, 4, 10299, 0, 1, 27, 0,    57, 3, 0, 1, 0, 0, '', 'Show gossip text if player is below level 57'),
(22, 5, 10299, 0, 0,  2, 0, 12219, 1, 0, 0, 0, 0, '', 'Show gossip text if player has Unadorned Seal of Ascension'),
(22, 5, 10299, 0, 0, 27, 0,    57, 3, 0, 0, 0, 0, '', 'Show gossip text if player is at least level 57');

-- Link npc_text with gossip_menu
DELETE FROM `gossip_menu` WHERE `MenuID` IN (12039, 12040, 12041, 12042, 12043, 12044, 12045, 12046, 12047, 12048);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (12039, 3301), (12039, 3311), (12040, 3302), (12041, 3303), (12042, 3304), (12043, 3305), (12044, 3306), (12045, 3307), (12046, 3308), (12047, 3309), (12048, 3310);

-- Vaelan, Remove static Vaelan
DELETE FROM `creature` WHERE `guid` = 42797 AND `id1`= 10296;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `npcflag`=1|2, `gossip_menu_id` = 12039, `MovementType` = 0, `minlevel` = 55 WHERE (`entry` = 10296);
-- Scarshield Infiltrator
UPDATE `creature_template` SET `AIName` = 'SmartAI', `gossip_menu_id` = 0, `npcflag` = 0, `MovementType` = 0, `minlevel` = 55 WHERE (`entry` = 10299);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10299);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10299, 0, 0, 0, 38, 0, 100, 1, 0, 1, 0, 0, 0, 80, 1029900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - On Data Set 0 1 - Run Script (No Repeat)'),
(10299, 0, 1, 0, 62, 0, 100, 0, 12039, 1, 0, 0, 0, 80, 1029901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - On Gossip Option 1 Selected - Run Script'),
(10299, 0, 2, 0, 62, 0, 100, 0, 12048, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - On Gossip Option 0 Selected - Close Gossip'),
(10299, 0, 3, 0, 64, 0, 100, 0, 12039, 0, 0, 0, 0, 98, 12039, 3301, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - On Gossip Hello - Send Gossip'),
(10299, 0, 4, 0, 64, 0, 100, 0, 12039, 0, 0, 0, 0, 98, 12039, 3311, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - On Gossip Hello - Send Gossip');

-- Actionlist
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1029900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1029900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 16037, 0, 0, 0, 0, 0, 21, 90, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Cast \'Mind Probe\''),
(1029900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Remove FlagStandstate Kneel'),
(1029900, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 36, 10296, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Update Template To \'Vaelan\''),
(1029900, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Remove Npc Flags Gossip & Questgiver'),
(1029900, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 90, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Set Orientation Closest Player'),
(1029900, 9, 5, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Say Line 0'),
(1029900, 9, 6, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Say Line 1'),
(1029900, 9, 7, 0, 0, 0, 100, 0, 10500, 10500, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Set Npc Flags Gossip');
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1029901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1029901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Close Gossip'),
(1029901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Remove Npc Flags Gossip'),
(1029901, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Play Emote 1'),
(1029901, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 11, 16051, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Cast \'Barrier of Light\''),
(1029901, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Say Line 2'),
(1029901, 9, 5, 0, 0, 0, 100, 0, 7500, 7500, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Say Line 3'),
(1029901, 9, 6, 0, 0, 0, 100, 0, 11500, 11500, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Actionlist - Add Npc Flags Questgiver');
