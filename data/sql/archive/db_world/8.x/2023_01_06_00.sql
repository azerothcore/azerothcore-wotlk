-- DB update 2023_01_05_02 -> 2023_01_06_00
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 3651 AND `OptionID` IN (0, 1, 2);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3651, 0, 0, 'May I have another Dawn\'s Gambit, Betina?  I want to test it again...', 7198, 1, 1, 0, 0, 0, 0, '', 0, 0),
(3651, 1, 0, 'Betina, I\'d like a replacement Seal of the Dawn please!', 10458, 1, 1, 0, 0, 0, 0, '', 0, 0),
(3651, 2, 0, 'Betina, I\'d like a replacement Rune of the Dawn please!', 10462, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 3651 AND `SourceId` IN (0, 1, 2);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3651, 0, 0, 0, 2, 0, 12368, 1, 0, 1, 0, 0, '', 'If player does not have \'Dawn\'s Gambit\' in inventory'),
(15, 3651, 0, 0, 0, 2, 0, 12368, 1, 1, 1, 0, 0, '', 'If player does not have \'Dawn\'s Gambit\' in bank'),
(15, 3651, 0, 0, 0, 8, 0, 4771, 0, 0, 0, 0, 0, '', 'If player has quest \'Dawn\'s Gambit\' rewarded'),
(15, 3651, 1, 0, 0, 2, 0, 13209, 1, 0, 1, 0, 0, '', 'If player does not have \'Seal of the Dawn\' in inventory'),
(15, 3651, 1, 0, 0, 2, 0, 13209, 1, 1, 1, 0, 0, '', 'If player does not have \'Seal of the Dawn\' in bank'),
(15, 3651, 1, 0, 0, 2, 0, 19812, 1, 0, 1, 0, 0, '', 'If player does not have \'Rune of the Dawn\' in inventory'),
(15, 3651, 1, 0, 0, 2, 0, 19812, 1, 1, 1, 0, 0, '', 'If player does not have \'Rune of the Dawn\' in bank'),
(15, 3651, 1, 0, 0, 8, 0, 5213, 0, 0, 0, 0, 0, '', 'If player has quest \'The Active Agent\' rewarded'),
(15, 3651, 2, 0, 0, 2, 0, 13209, 1, 0, 1, 0, 0, '', 'If player does not have \'Seal of the Dawn\' in inventory'),
(15, 3651, 2, 0, 0, 2, 0, 13209, 1, 1, 1, 0, 0, '', 'If player does not have \'Seal of the Dawn\' in bank'),
(15, 3651, 2, 0, 0, 2, 0, 19812, 1, 0, 1, 0, 0, '', 'If player does not have \'Rune of the Dawn\' in inventory'),
(15, 3651, 2, 0, 0, 2, 0, 19812, 1, 1, 1, 0, 0, '', 'If player does not have \'Rune of the Dawn\' in bank'),
(15, 3651, 2, 0, 0, 8, 0, 5213, 0, 0, 0, 0, 0, '', 'If player has quest \'The Active Agent\' rewarded');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11035;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 11035 AND `source_type` = 0 AND `id` IN (1, 2, 3, 4, 5, 6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11035, 0, 1, 2, 62, 0, 100, 0, 3651, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Betina Bigglezink - On Gossip Option 0 Selected - Close Gossip'),
(11035, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 18367, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Betina Bigglezink - On Link - Cast \'Create Dawn\'s Gambit\''),
(11035, 0, 3, 4, 62, 0, 100, 0, 3651, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Betina Bigglezink - On Gossip Option 1 Selected - Close Gossip'),
(11035, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24179, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Betina Bigglezink - On Link - Cast \'Create Rune of the Dawn\''),
(11035, 0, 5, 6, 62, 0, 100, 0, 3651, 2, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Betina Bigglezink - On Gossip Option 2 Selected - Close Gossip'),
(11035, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24201, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Betina Bigglezink - On Link - Cast \'Create Seal of the Dawn\'');
