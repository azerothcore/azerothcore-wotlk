-- DB update 2025_10_16_03 -> 2025_10_16_04
--
-- Argent Dawn Initiate
UPDATE `creature_template` SET `gossip_menu_id` = 7230, `npcflag` = `npcflag` | 1 WHERE (`entry` = 16384);
-- Argent Dawn Cleric
UPDATE `creature_template` SET `gossip_menu_id` = 7231, `npcflag` = `npcflag` | 1 WHERE (`entry` = 16435);
-- Argent Dawn Priest
UPDATE `creature_template` SET `gossip_menu_id` = 7232, `npcflag` = `npcflag` | 1 WHERE (`entry` = 16436);

DELETE FROM `gossip_menu` WHERE `MenuID` IN (7230, 7231, 7232);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7230, 8543),
(7231, 8544),
(7232, 8545);

DELETE FROM `npc_text` WHERE (`ID` IN (8543, 8544, 8545));
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(8543, '', '', 12301, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8544, '', '', 12300, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8545, '', '', 12299, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` IN (7230, 7231, 7232));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7230, 0, 0, 'Give me one of your magic items.', 12302, 1, 1, 0, 0, 0, 0, '', 0, 0),
(7231, 0, 0, 'Give me one of your magic items.', 12302, 1, 1, 0, 0, 0, 0, '', 0, 0),
(7232, 0, 0, 'Give me one of your magic items.', 12302, 1, 1, 0, 0, 0, 0, '', 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (16384, 16435, 16436);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (16384, 16435, 16436) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16384, 0, 0, 0, 62, 0, 100, 0, 7230, 0, 0, 0, 0, 0, 11, 28319, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Dawn Initiate - On Gossip Option 0 Selected - Cast \'Create Lesser Mark of the Dawn\''),
(16435, 0, 0, 0, 62, 0, 100, 0, 7231, 0, 0, 0, 0, 0, 11, 28320, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Dawn Cleric - On Gossip Option 0 Selected - Cast \'Create Mark of the Dawn\''),
(16436, 0, 0, 0, 62, 0, 100, 0, 7232, 0, 0, 0, 0, 0, 11, 28321, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Dawn Priest - On Gossip Option 0 Selected - Cast \'Create Greater Mark of the Dawn\'');
