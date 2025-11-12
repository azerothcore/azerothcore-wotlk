-- DB update 2025_11_12_03 -> 2025_11_12_04
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 5440) AND (`SourceId` = 2) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 47219) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 5440, 2, 0, 1, 0, 47219, 0, 0, 0, 0, 0, '', 'Areatrigger 5440 require Cleared for Teleport (47219) ');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26619;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26619);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26619, 0, 0, 1, 62, 0, 100, 0, 9415, 0, 0, 0, 0, 0, 11, 47219, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Paratrooper - On Gossip Option 0 Selected - Cast \'Cleared for Teleport\''),
(26619, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Paratrooper - On Gossip Option 0 Selected - Close Gossip'),
(26619, 0, 2, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 98, 9429, 12687, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Paratrooper - On Gossip Hello - Send Gossip'),
(26619, 0, 3, 4, 62, 0, 100, 0, 9429, 1, 0, 0, 0, 0, 11, 47326, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Paratrooper - On Gossip Option 1 Selected - Cast \'Create Item - Fizzcrank Practice Parachute\''),
(26619, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Paratrooper - On Gossip Option 1 Selected - Close Gossip');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 5440;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5440, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5440) AND (`source_type` = 2) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5440, 2, 0, 0, 46, 0, 100, 0, 5440, 0, 0, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 4240.04, 5259.05, 72.3396, 2.274780035018921, 'Areatrigger - On Trigger - Teleport');

DELETE FROM `gossip_menu` WHERE `MenuID` = 9429;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9429, 12687);

DELETE FROM `gossip_menu_option` WHERE (`OptionID`=1 AND `MenuID`=9429);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9429, 1, 0, 'I\'ll show you!  Give me that practice parachute!', 25923, 1, 1, 0, 0, 0, 0, NULL, 0, 64270);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 3) AND (`SourceEntry` = 26619) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 188420) AND (`ConditionValue2` = 20) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 26619, 0, 0, 30, 0, 188420, 20, 0, 0, 0, 0, '', 'Requires Fizzcrank Parachute spell focus');

UPDATE `gameobject` SET `position_x` = 4227.6616, `position_y` = 5270.674, `position_z` = 71.928215 WHERE `guid` = 99767 AND `id` = 188420;
