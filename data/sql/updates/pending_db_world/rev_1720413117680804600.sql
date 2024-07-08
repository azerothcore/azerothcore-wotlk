--
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 4004) AND (`OptionID` IN (1));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(4004, 1, 0, 'Merideth, could I have some more manna-enriched horse feed please?', 9792, 1, 1, 0, 0, 0, 0, '', 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2357;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 2357);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2357, 0, 0, 1, 62, 0, 100, 0, 4004, 1, 0, 0, 0, 0, 11, 23304, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merideth Carlson - On Gossip Option 1 Selected - Cast \'Manna-Enriched Horse Feed\''),
(2357, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merideth Carlson - On Gossip Option 1 Selected - Close Gossip');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 4004) AND (`SourceEntry` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 4004, 1, 0, 0, 47, 0, 7645, 64, 0, 0, 0, 0, '', 'Player can request another Manna-Enriched Horse Feed if player completed quest'),
(15, 4004, 1, 0, 0, 2, 0, 18775, 1, 0, 1, 0, 0, '', 'Player can request another Manna-Enriched Horse Feed if does not already have it'),
(15, 4004, 1, 0, 0, 2, 0, 18775, 1, 1, 1, 0, 0, '', 'Player can request another Manna-Enriched Horse Feed if does not already have it');
