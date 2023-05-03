-- DB update 2023_05_03_02 -> 2023_05_03_03
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8568;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8568, 1, 0, 0, 2, 0, 31880, 1, 0, 1, 0, 0, '', 'Must not have item 31880'),
(15, 8568, 1, 0, 0, 8, 0, 10942, 0, 0, 0, 0, 0, '', 'Quest 10942 must be rewarded'),
(15, 8568, 1, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Children\'s Week must be active'),
(15, 8568, 2, 0, 0, 2, 0, 31881, 1, 0, 1, 0, 0, '', 'Must not have item 31881'),
(15, 8568, 2, 0, 0, 8, 0, 10943, 0, 0, 0, 0, 0, '', 'Quest 10943 must be rewarded'),
(15, 8568, 2, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Children\'s Week must be active');

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 8568);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8568, 1, 0, 'I need a new Blood Elf Orphan Whistle.', 20452, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(8568, 2, 0, 'I need a new Draenei Orphan Whistle.', 20453, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22819);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22819, 0, 1, 3, 62, 0, 100, 0, 8568, 1, 0, 0, 0, 11, 39512, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orphan Matron Mercy - On Gossip Option 1 Selected - Cast \'OCW Create Blood Elf Orphan Whistle\''),
(22819, 0, 2, 3, 62, 0, 100, 0, 8568, 2, 0, 0, 0, 11, 39513, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orphan Matron Mercy - On Gossip Option 2 Selected - Cast \'OCW Create Draenei Orphan Whistle\''),
(22819, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orphan Matron Mercy - Linked - Close Gossip');
