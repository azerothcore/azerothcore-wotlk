-- DB update 2026_03_28_02 -> 2026_03_28_03
-- Move Northrend gossip handlers from C++ to database
-- NPCs: Iruk (26219), Razael & Lyana (23998, 23778), Roxi Ramrocket (31247), Avatar of Freya (27801)

-- =====================================================
-- 1. npc_iruk (26219) - zone_borean_tundra
-- Show gossip option if quest 11961 is incomplete
-- On select: player self-casts spell 46816 (Create Totem of Issliruk)
-- =====================================================

-- Condition on gossip_menu_option: show option if quest 11961 is in progress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9280 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9280, 0, 0, 0, 47, 0, 11961, 8, 0, 0, 0, 0, '', 'Iruk - Show option if quest 11961 is in progress');

-- SAI: on gossip select (menu 9280, option 0) -> close gossip + invoker self-cast spell 46816
DELETE FROM `smart_scripts` WHERE `entryorguid`=26219 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26219, 0, 0, 1, 62, 0, 100, 512, 9280, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Iruk - On Gossip Select - Close Gossip'),
(26219, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 134, 46816, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Iruk - Linked - Invoker Cast Create Totem of Issliruk');

-- Update creature_template
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=26219;

-- =====================================================
-- 2. npc_razael_and_lyana - zone_howling_fjord
-- Razael (23998), menu 8870 -> ActionMenuID 8869 (already wired)
-- Lyana (23778), menu 8879 -> ActionMenuID 8878 (already wired)
-- Both require quest 11221 incomplete, give TalkedToCreature credit on select
-- =====================================================

-- Condition on menu 8870 option 0: quest 11221 in progress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8870 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8870, 0, 0, 0, 47, 0, 11221, 8, 0, 0, 0, 0, '', 'Razael - Show gossip option if quest 11221 is in progress');

-- Condition on menu 8879 option 0: quest 11221 in progress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8879 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8879, 0, 0, 0, 47, 0, 11221, 8, 0, 0, 0, 0, '', 'Lyana - Show gossip option if quest 11221 is in progress');

-- SAI for Razael (23998): on gossip select (menu 8870, option 0) -> quest credit 23998
DELETE FROM `smart_scripts` WHERE `entryorguid`=23998 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23998, 0, 0, 0, 62, 0, 100, 512, 8870, 0, 0, 0, 0, 0, 33, 23998, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Razael - On Gossip Select - Quest Credit 23998');

-- Update Razael creature_template
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=23998;

-- SAI for Lyana (23778): append gossip handler to existing SAI (id 0 = OOC say already exists)
DELETE FROM `smart_scripts` WHERE `entryorguid`=23778 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23778, 0, 1, 0, 62, 0, 100, 512, 8879, 0, 0, 0, 0, 0, 33, 23778, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyana - On Gossip Select - Quest Credit 23778');

-- Update Lyana creature_template (already has SmartAI)
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=23778;

-- =====================================================
-- 3. npc_roxi_ramrocket (31247) - zone_storm_peaks
-- Trainer option already in DB (menu 10210, OptionID 0, type 5)
-- Add vendor option gated by HasSpell (60866 Mechano-Hog OR 60867 Mekgineer's Chopper)
-- =====================================================

-- Add vendor gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `MenuID`=10210 AND `OptionID`=1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10210, 1, 1, 'I want to browse your goods.', 3370, 3, 128, 0, 0, 0, 0, '', 0, 0);

-- Condition on vendor option: HasSpell 60866 (Mechano-Hog) OR HasSpell 60867 (Mekgineer's Chopper)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10210 AND `SourceEntry`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10210, 1, 0, 0, 25, 0, 60866, 0, 0, 0, 0, 0, '', 'Roxi Ramrocket - Show vendor option if player has Mechano-Hog'),
(15, 10210, 1, 0, 1, 25, 0, 60867, 0, 0, 0, 0, 0, '', 'Roxi Ramrocket - Show vendor option if player has Mekgineer''s Chopper');

-- Remove ScriptName
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=31247;

-- =====================================================
-- 4. npc_avatar_of_freya (27801) - zone_sholazar_basin
-- 3-step gossip chain already wired: 9720 -> 9721 -> 9722 -> close
-- Condition on first option: quest 12621 incomplete
-- SAI on final select: invoker self-cast spell 52045
-- =====================================================

-- Condition on menu 9720 option 0: quest 12621 in progress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9720 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9720, 0, 0, 0, 47, 0, 12621, 8, 0, 0, 0, 0, '', 'Avatar of Freya - Show gossip option if quest 12621 is in progress');

-- SAI: on gossip select (menu 9722, option 0) -> close gossip + invoker self-cast spell 52045
DELETE FROM `smart_scripts` WHERE `entryorguid`=27801 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27801, 0, 0, 1, 62, 0, 100, 512, 9722, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Freya - On Gossip Select - Close Gossip'),
(27801, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 134, 52045, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Freya - Linked - Invoker Cast Freya Conversation');

-- Update creature_template
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=27801;
