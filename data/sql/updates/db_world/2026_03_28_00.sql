-- DB update 2026_03_27_04 -> 2026_03_28_00
-- Move Kalimdor gossip handlers from C++ to database
-- NPCs: Rivern Frostwind, Stone Watcher of Norgannon, Great Bear Spirit,
--        Braug Dimspirit, Steward of Time, Thrall Warchief

-- =====================================================
-- 1. npc_rivern_frostwind (10618) - zone_winterspring
-- Show vendor option only if Exalted with Wintersaber Trainers (faction 589)
-- =====================================================

-- Condition: gossip_menu_option MenuID=3130, OptionID=0 requires Exalted (rank 7, mask 128)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3130 AND `SourceEntry`=0 AND `ConditionTypeOrReference`=5;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3130, 0, 0, 0, 5, 0, 589, 128, 0, 0, 0, 0, '', 'Rivern Frostwind - Show vendor option only if Exalted with Wintersaber Trainers');

-- Remove ScriptName
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=10618;

-- =====================================================
-- 2. npc_stone_watcher_of_norgannon (7918) - zone_tanaris
-- 5-step gossip chain, quest 2954 credit at end
-- =====================================================

-- Add missing gossip_menu entries (MenuID -> TextID)
DELETE FROM `gossip_menu` WHERE `MenuID` IN (57000,57001,57002,57003,57004,57005);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(57000, 1674),
(57001, 1675),
(57002, 1676),
(57003, 1677),
(57004, 1678),
(57005, 1679);

-- Condition: show first option only if quest 2954 is taken (incomplete)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=57000 AND `SourceEntry`=0 AND `ConditionTypeOrReference`=9;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 57000, 0, 0, 0, 9, 0, 2954, 0, 0, 0, 0, 0, '', 'Stone Watcher of Norgannon - Show gossip option if quest 2954 is taken');

-- SAI: on final gossip select (menu 57005, option 0) -> close gossip + quest credit 2954
DELETE FROM `smart_scripts` WHERE `entryorguid`=7918 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7918, 0, 0, 1, 62, 0, 100, 512, 57005, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Stone Watcher of Norgannon - On Gossip Select - Close Gossip'),
(7918, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 15, 2954, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Stone Watcher of Norgannon - Linked - Quest Credit 2954');

-- Update creature_template: set gossip_menu_id, add gossip npcflag, set SmartAI
UPDATE `creature_template` SET `gossip_menu_id`=57000, `npcflag`=`npcflag`|1, `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=7918;

-- =====================================================
-- 3. npc_great_bear_spirit (11956) - zone_moonglade
-- 4-step gossip chain, quest 5929/5930 credit at end
-- =====================================================

-- Add quest-active text for menu 3882
DELETE FROM `gossip_menu` WHERE `MenuID`=3882 AND `TextID`=4719;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(3882, 4719);

-- Condition on gossip_menu: show TextID 4719 if quest 5929 OR 5930 is taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=3882 AND `SourceEntry`=4719;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 3882, 4719, 0, 0, 9, 0, 5929, 0, 0, 0, 0, 0, '', 'Great Bear Spirit - Show text 4719 if quest 5929 is taken'),
(14, 3882, 4719, 0, 1, 9, 0, 5930, 0, 0, 0, 0, 0, '', 'Great Bear Spirit - Show text 4719 if quest 5930 is taken');

-- Condition on gossip_menu_option: show option if quest 5929 OR 5930 is taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3882 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3882, 0, 0, 0, 9, 0, 5929, 0, 0, 0, 0, 0, '', 'Great Bear Spirit - Show gossip option if quest 5929 is taken'),
(15, 3882, 0, 0, 1, 9, 0, 5930, 0, 0, 0, 0, 0, '', 'Great Bear Spirit - Show gossip option if quest 5930 is taken');

-- Clean up duplicate OptionID=1 on menu 3884 (identical to OptionID=0)
DELETE FROM `gossip_menu_option` WHERE `MenuID`=3884 AND `OptionID`=1;

-- SAI: on gossip select (menu 3884, option 0) -> quest credit for both 5929 and 5930
DELETE FROM `smart_scripts` WHERE `entryorguid`=11956 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11956, 0, 0, 1, 62, 0, 100, 512, 3884, 0, 0, 0, 0, 0, 15, 5929, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Great Bear Spirit - On Gossip Select - Quest Credit 5929'),
(11956, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 15, 5930, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Great Bear Spirit - On Gossip Select - Quest Credit 5930');

-- Update creature_template
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=11956;

-- =====================================================
-- 4. npc_braug_dimspirit (4489) - zone_stonetalon_mountains
-- Quiz: 5 dragon options, Neltharion = correct, others = wrong spell
-- =====================================================

-- Add missing Nozdormu option (OptionID=4)
DELETE FROM `gossip_menu_option` WHERE `MenuID`=4763 AND `OptionID`=4;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`) VALUES
(4763, 4, 0, 'Nozdormu is my answer.', 0, 1, 1, 0, 0, 0, 0, '');

-- Condition on gossip_menu: show text 5820 (quiz text) if quest 6627 is taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=4763 AND `SourceEntry`=5820;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 4763, 5820, 0, 0, 9, 0, 6627, 0, 0, 0, 0, 0, '', 'Braug Dimspirit - Show quiz text if quest 6627 is taken');

-- Conditions on all 5 options: show only if quest 6627 is taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=4763 AND `SourceEntry` IN (0,1,2,3,4) AND `ConditionTypeOrReference`=9;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 4763, 0, 0, 0, 9, 0, 6627, 0, 0, 0, 0, 0, '', 'Braug Dimspirit - Show Ysera option if quest 6627 is taken'),
(15, 4763, 1, 0, 0, 9, 0, 6627, 0, 0, 0, 0, 0, '', 'Braug Dimspirit - Show Neltharion option if quest 6627 is taken'),
(15, 4763, 2, 0, 0, 9, 0, 6627, 0, 0, 0, 0, 0, '', 'Braug Dimspirit - Show Alexstrasza option if quest 6627 is taken'),
(15, 4763, 3, 0, 0, 9, 0, 6627, 0, 0, 0, 0, 0, '', 'Braug Dimspirit - Show Malygos option if quest 6627 is taken'),
(15, 4763, 4, 0, 0, 9, 0, 6627, 0, 0, 0, 0, 0, '', 'Braug Dimspirit - Show Nozdormu option if quest 6627 is taken');

-- SAI: Neltharion (option 1) = correct answer -> quest credit
--      All others (options 0,2,3,4) = wrong answer -> cast spell 6766
DELETE FROM `smart_scripts` WHERE `entryorguid`=4489 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4489, 0, 0, 0, 62, 0, 100, 512, 4763, 1, 0, 0, 0, 0, 15, 6627, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Braug Dimspirit - On Gossip Select Neltharion - Quest Credit 6627'),
(4489, 0, 1, 0, 62, 0, 100, 512, 4763, 0, 0, 0, 0, 0, 11, 6766, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Braug Dimspirit - On Gossip Select Ysera - Cast Wrong Answer'),
(4489, 0, 2, 0, 62, 0, 100, 512, 4763, 2, 0, 0, 0, 0, 11, 6766, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Braug Dimspirit - On Gossip Select Alexstrasza - Cast Wrong Answer'),
(4489, 0, 3, 0, 62, 0, 100, 512, 4763, 3, 0, 0, 0, 0, 11, 6766, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Braug Dimspirit - On Gossip Select Malygos - Cast Wrong Answer'),
(4489, 0, 4, 0, 62, 0, 100, 512, 4763, 4, 0, 0, 0, 0, 11, 6766, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Braug Dimspirit - On Gossip Select Nozdormu - Cast Wrong Answer');

-- Update creature_template
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=4489;

-- =====================================================
-- 5. npc_steward_of_time (20142) - zone_tanaris
-- Gossip shows flight option if quest 10279 incomplete or rewarded
-- On select casts spell 34891. Keep OnQuestAccept in C++.
-- =====================================================

-- Condition on gossip_menu: show text 9978 if quest 10279 is taken OR rewarded
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=8072 AND `SourceEntry`=9978;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8072, 9978, 0, 0, 9, 0, 10279, 0, 0, 0, 0, 0, '', 'Steward of Time - Show text 9978 if quest 10279 is taken'),
(14, 8072, 9978, 0, 1, 8, 0, 10279, 0, 0, 0, 0, 0, '', 'Steward of Time - Show text 9978 if quest 10279 is rewarded');

-- Condition on gossip_menu_option: show option if quest 10279 is taken OR rewarded
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8072 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8072, 0, 0, 0, 9, 0, 10279, 0, 0, 0, 0, 0, '', 'Steward of Time - Show gossip option if quest 10279 is taken'),
(15, 8072, 0, 0, 1, 8, 0, 10279, 0, 0, 0, 0, 0, '', 'Steward of Time - Show gossip option if quest 10279 is rewarded');

-- SAI: on gossip select (menu 8072, option 0) -> invoker self-casts spell 34891
-- Using SMART_ACTION_INVOKER_CAST (134) so the player casts on themselves,
-- matching original C++: player->CastSpell(player, 34891, true)
DELETE FROM `smart_scripts` WHERE `entryorguid`=20142 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20142, 0, 0, 0, 62, 0, 100, 512, 8072, 0, 0, 0, 0, 0, 134, 34891, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Steward of Time - On Gossip Select - Invoker Cast Flight Through Caverns');

-- Update creature_template: add SmartAI (keep ScriptName for OnQuestAccept)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=20142;

-- =====================================================
-- 6. npc_thrall_warchief (4949) - zone_orgrimmar
-- 7-step gossip chain, quest 6566 credit at end
-- Keep ScriptName for OnQuestReward + AI
-- =====================================================

-- Add missing gossip_menu entries for chain steps
DELETE FROM `gossip_menu` WHERE `MenuID` IN (3665,3666,3667,3668,3669,3670);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(3665, 5733),
(3666, 5734),
(3667, 5735),
(3668, 5736),
(3669, 5737),
(3670, 5738);

-- Fix menu 3670: ActionMenuID should be 0 (close), not 3664 (loop)
UPDATE `gossip_menu_option` SET `ActionMenuID`=0 WHERE `MenuID`=3670 AND `OptionID`=0;

-- Condition on gossip_menu_option: show first option only if quest 6566 is taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3664 AND `SourceEntry`=0 AND `ConditionTypeOrReference`=9;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3664, 0, 0, 0, 9, 0, 6566, 0, 0, 0, 0, 0, '', 'Thrall - Show gossip option if quest 6566 is taken');

-- Quest credit on final gossip step handled via sGossipSelect in C++ AI struct.
-- Cannot use SAI because Thrall's custom C++ AI (GetAI) takes precedence over SmartAI.
-- No AIName change needed.
