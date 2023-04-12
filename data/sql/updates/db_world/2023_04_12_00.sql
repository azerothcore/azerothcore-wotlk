-- DB update 2023_04_09_12 -> 2023_04_12_00
-- ID 20985 (Captain Saeed)
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8228;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8228, 0, 0, 'I am that fleshling, Saeed. Let\'s go!', 18639, 0, 1, 0, 0, 0, 0, '', 0, 0),
(8228, 1, 0, 'I am ready. Let\'s make history!', 18641, 0, 1, 0, 0, 0, 0, '', 0, 0);

-- ID 20907 (Professor Dabiri)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 20907;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20907);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20907, 0, 0, 1, 62, 0, 100, 0, 8207, 0, 0, 0, 0, 85, 35780, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Professor Dabiri - On Gossip Option 0 Selected - Invoker Cast \'Summon Phase Disruptor\''),
(20907, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Professor Dabiri - On Gossip Option 0 Selected - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8207;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8207, 0, 0, 0, 2, 0, 29778, 1, 0, 1, 0, 0, '', '(AND) Professor Dabiri - Show gossip option 0 if item 29778 is NOT in inventory.'),
(15, 8207, 0, 0, 0, 47, 0, 10438, 10, 0, 0, 0, 0, '', '(AND) Professor Dabiri - Show gossip option 0 if quest 10438 is complete or incomplete.');
