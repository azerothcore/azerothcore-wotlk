-- DB update 2026_03_28_01 -> 2026_03_28_02
-- Move Outland gossip handlers from C++ to database
-- NPCs: Shattrath Flask Vendors (23484, 23483), Zephyr (25967), Drake Dealer Hurlunk (23489)

-- =====================================================
-- 1. npc_shattrathflaskvendors - Aldor vendor (23484), menu 8751
-- Show vendor option only if Exalted with Aldor (932), Sha'tar (935), Cenarion Expedition (942)
-- Text 11085 = qualified, Text 11083 = rejection (default)
-- =====================================================

-- Condition on gossip_menu: show text 11085 if Exalted with all 3 factions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=8751 AND `SourceEntry`=11085;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8751, 11085, 0, 0, 5, 0, 932, 128, 0, 0, 0, 0, '', 'Haldor the Compulsive - Show text 11085 if Exalted with Aldor'),
(14, 8751, 11085, 0, 0, 5, 0, 935, 128, 0, 0, 0, 0, '', 'Haldor the Compulsive - Show text 11085 if Exalted with Sha''tar'),
(14, 8751, 11085, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', 'Haldor the Compulsive - Show text 11085 if Exalted with Cenarion Expedition');

-- Condition on gossip_menu_option: show vendor option only if Exalted with all 3 factions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8751 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8751, 0, 0, 0, 5, 0, 932, 128, 0, 0, 0, 0, '', 'Haldor the Compulsive - Show vendor option if Exalted with Aldor'),
(15, 8751, 0, 0, 0, 5, 0, 935, 128, 0, 0, 0, 0, '', 'Haldor the Compulsive - Show vendor option if Exalted with Sha''tar'),
(15, 8751, 0, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', 'Haldor the Compulsive - Show vendor option if Exalted with Cenarion Expedition');

-- Remove ScriptName
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=23484;

-- =====================================================
-- 2. npc_shattrathflaskvendors - Scryers vendor (23483), menu 8752
-- Show vendor option only if Exalted with Scryers (934), Sha'tar (935), Cenarion Expedition (942)
-- Text 11085 = qualified, Text 11084 = rejection (default)
-- =====================================================

-- Add qualified text 11085 to menu 8752 (only rejection text 11084 exists)
DELETE FROM `gossip_menu` WHERE `MenuID`=8752 AND `TextID`=11085;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8752, 11085);

-- Condition on gossip_menu: show text 11085 if Exalted with all 3 factions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=8752 AND `SourceEntry`=11085;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8752, 11085, 0, 0, 5, 0, 934, 128, 0, 0, 0, 0, '', 'Arcanist Xorith - Show text 11085 if Exalted with Scryers'),
(14, 8752, 11085, 0, 0, 5, 0, 935, 128, 0, 0, 0, 0, '', 'Arcanist Xorith - Show text 11085 if Exalted with Sha''tar'),
(14, 8752, 11085, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', 'Arcanist Xorith - Show text 11085 if Exalted with Cenarion Expedition');

-- Condition on gossip_menu_option: show vendor option only if Exalted with all 3 factions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8752 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8752, 0, 0, 0, 5, 0, 934, 128, 0, 0, 0, 0, '', 'Arcanist Xorith - Show vendor option if Exalted with Scryers'),
(15, 8752, 0, 0, 0, 5, 0, 935, 128, 0, 0, 0, 0, '', 'Arcanist Xorith - Show vendor option if Exalted with Sha''tar'),
(15, 8752, 0, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', 'Arcanist Xorith - Show vendor option if Exalted with Cenarion Expedition');

-- Remove ScriptName
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=23483;

-- =====================================================
-- 3. npc_zephyr (25967), menu 9205
-- Show teleport option if Revered+ with Keepers of Time (989)
-- On select: player casts spell 37778 (Teleport: Caverns of Time)
-- =====================================================

-- Condition on gossip_menu_option: show option if Revered or Exalted with Keepers of Time
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9205 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9205, 0, 0, 0, 5, 0, 989, 192, 0, 0, 0, 0, '', 'Zephyr - Show teleport option if Revered+ with Keepers of Time');

-- SAI: on gossip select (menu 9205, option 0) -> invoker self-casts spell 37778
DELETE FROM `smart_scripts` WHERE `entryorguid`=25967 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25967, 0, 0, 0, 62, 0, 100, 512, 9205, 0, 0, 0, 0, 0, 134, 37778, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Zephyr - On Gossip Select - Invoker Cast Teleport Caverns of Time');

-- Update creature_template: set SmartAI, remove ScriptName
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=25967;

-- =====================================================
-- 4. npc_drake_dealer_hurlunk (23489), menu 8754
-- Show vendor option only if Exalted with Netherwing (1015)
-- =====================================================

-- Condition on gossip_menu_option: show vendor option if Exalted with Netherwing
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8754 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8754, 0, 0, 0, 5, 0, 1015, 128, 0, 0, 0, 0, '', 'Drake Dealer Hurlunk - Show vendor option if Exalted with Netherwing');

-- Remove ScriptName
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=23489;

-- =====================================================
-- 5. npcs_flanis_swiftwing_and_kagrosh
-- Flanis Swiftwing (21727), menu 8356 - give item 30658 if quest 10583 incomplete
-- Kagrosh (21725), menu 8371 - give item 30659 if quest 10601 incomplete
-- =====================================================

-- Condition on menu 8356 option 0: quest 10583 incomplete AND player doesn't have item 30658
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8356 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8356, 0, 0, 0, 47, 0, 10583, 8, 0, 0, 0, 0, '', 'Flanis Swiftwing - Show option if quest 10583 is in progress'),
(15, 8356, 0, 0, 0, 2, 0, 30658, 1, 0, 1, 0, 0, '', 'Flanis Swiftwing - Show option if player does not have item 30658');

-- Condition on menu 8371 option 0: quest 10601 incomplete AND player doesn't have item 30659
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8371 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8371, 0, 0, 0, 47, 0, 10601, 8, 0, 0, 0, 0, '', 'Kagrosh - Show option if quest 10601 is in progress'),
(15, 8371, 0, 0, 0, 2, 0, 30659, 1, 0, 1, 0, 0, '', 'Kagrosh - Show option if player does not have item 30659');

-- SAI for Flanis (21727): on gossip select -> close gossip + add item 30658
DELETE FROM `smart_scripts` WHERE `entryorguid`=21727 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21727, 0, 0, 1, 62, 0, 100, 512, 8356, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Flanis Swiftwing - On Gossip Select - Close Gossip'),
(21727, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 56, 30658, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Flanis Swiftwing - Linked - Add Item 30658');

-- SAI for Kagrosh (21725): on gossip select -> close gossip + add item 30659
DELETE FROM `smart_scripts` WHERE `entryorguid`=21725 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21725, 0, 0, 1, 62, 0, 100, 512, 8371, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kagrosh - On Gossip Select - Close Gossip'),
(21725, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 56, 30659, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kagrosh - Linked - Add Item 30659');

-- Update creature_template: set SmartAI, remove ScriptName
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry` IN (21725, 21727);
