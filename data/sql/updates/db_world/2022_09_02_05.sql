-- DB update 2022_09_02_04 -> 2022_09_02_05
--
DELETE FROM `gossip_menu` WHERE `MenuID` = 6644 AND `TextID` = 8701;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6644, 8701);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 6644 AND `SourceEntry` IN (7899, 8701, 8702);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6644, 7899, 0, 0, 13, 0, 7, 3, 2, 1, 0, 0, '', 'Andorgos show text 7899 if Twin Emperors is not done'),
(14, 6644, 8701, 0, 0, 13, 0, 7, 3, 2, 0, 0, 0, '', 'Andorgos show text 8701 if Twin Emperors is done'),
(14, 6644, 8701, 0, 0, 13, 0, 8, 3, 2, 1, 0, 0, '', 'Andorgos show text 8701 gossip if Ouro is not done'),
(14, 6644, 8702, 0, 0, 13, 0, 8, 3, 2, 0, 0, 0, '', 'Andorgos show text 8702 gossip if Ouro is done');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 6644 AND `SourceEntry` IN (0, 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6644, 0, 0, 0, 13, 0, 7, 3, 2, 0, 0, 0, '', 'Andorgos show gossip if Twin Emperors is done'),
(15, 6644, 1, 0, 0, 13, 0, 8, 3, 2, 0, 0, 0, '', 'Andorgos show gossip if Ouro is done');

DELETE FROM `gossip_menu_option` WHERE (`MenuID`=6644 AND `OptionID` IN (0, 1));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(6644, 0, 0, 'Teleport me to the lair of the Twin Emperors, please.', 12849, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(6644, 1, 0, 'Please teleport me to the final chamber.', 12851, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

DELETE FROM `spell_target_position` WHERE `ID` IN (29181, 29190);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(29181, 0, 531, -8971.81, 1321.47, -104.249, 0, 0),
(29190, 0, 531, -8632.84, 2055.87, 108.86, 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15502;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15502) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15502, 0, 0, 1, 62, 0, 100, 0, 6644, 0, 0, 0, 0, 11, 29182, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Andorgos - On Gossip Option 0 Selected - Cast \'Teleport to Twin Emperors\''),
(15502, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 29181, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Andorgos - On Gossip Option 0 Selected - Invoker Cast \'Teleport to Twin Emps Effect DND\''),
(15502, 0, 2, 3, 62, 0, 100, 0, 6644, 1, 0, 0, 0, 11, 29188, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Andorgos - On Gossip Option 1 Selected - Cast \'Teleport to Final Chamber\''),
(15502, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 29190, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Andorgos - On Gossip Option 1 Selected - Invoker Cast \'Teleport to Final Chamber Effect DND\'');
