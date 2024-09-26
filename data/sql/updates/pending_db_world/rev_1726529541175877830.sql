--
SET @RADIUS:=24; -- radius unknown
-- arrival events, play zeppelin horn
DELETE FROM `event_scripts` WHERE `command` = 16 and `id` IN (15312, 15314, 15318, 15320, 15322, 15324, 15430, 15431, 19126, 19127, 19137, 19139, 21868, 21870);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(15312, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15314, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15318, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15320, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15322, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15324, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15430, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15431, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19126, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19127, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19137, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19139, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(21868, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(21870, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0);

-- The Iron Eagle - Grom'Gol to Orgrimmar
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_the_iron_eagle' WHERE (`entry` = 175080);

-- Snurk Bucksquick Master Orgrimmar The Iron Eagle
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 3841;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3841, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8764, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 3841) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 11) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 175080) AND (`ConditionValue2` = 15322) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3841, 0, 0, 0, 11, 0, 175080, 15322, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Orgrimmar');

-- Zez'raz Master Grom'gol The Iron Eagle
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 2441;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(2441, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8764, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 2441); INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (15, 2441, 0, 0, 0, 11, 0, 175080, 15324, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Grom\'gol'); -- Krixx Engineer Orgrimmar The Iron Eagle, The Thundercaller
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8764);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8764, 11167, 0, 0, 11, 0, 175080, 15324, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Grom\'gol'),
(14, 8764, 11169, 0, 1, 11, 0, 175080, 15322, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Orgrimmar'),
(14, 8764, 11170, 0, 2, 11, 0, 175080, 15323, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Orgrimmar'),
(14, 8764, 11172, 0, 3, 11, 0, 175080, 15325, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Grom\'gol');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8765);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8765, 11165, 0, 0, 11, 0, 164871, 15318, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Orgrimmar'),
(14, 8765, 11173, 0, 1, 11, 0, 164871, 15320, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Undercity'),
(14, 8765, 11174, 0, 2, 11, 0, 164871, 15319, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Orgrimmar'),
(14, 8765, 11175, 0, 3, 11, 0, 164871, 15321, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Undercity');

-- The Thundercaller - Undercity to Orgrimmar
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_the_thundercaller' WHERE (`entry` = 164871);

-- Frezza Master Orgrimmar The Thundercaller
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 1969;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1969, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8765, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 1969) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1969, 0, 0, 0, 11, 0, 164871, 15318, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Orgrimmar');

-- Zapetta Master Undercity The Thundercaller
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 1971;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1971, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8765, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 1971) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1971, 0, 0, 0, 11, 0, 164871, 15320, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Undercity');
DELETE FROM `creature_text` WHERE (`CreatureID` = 9566) AND (`GroupID` = 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9566, 1, 0, 'There goes the zeppelin to Orgrimmar. I hope there\'s no explosions this time.', 12, 0, 100, 0, 0, 0, 22080, 0, 'Zapetta - Departure');
UPDATE `creature_text` SET `comment` = 'Zapetta - Arrival' WHERE (`CreatureID` = 9566) AND (`GroupID` = 0);

-- The Purple Princess - Grom'Gol to Undercity
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_the_purple_princess' WHERE (`entry` = 176495);

-- Hin Denburg Master Undercity The Purple Princess
DELETE FROM `gossip_menu` WHERE `MenuID` = 8766 AND `TextID` IN (11179, 11182);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8766, 11179),
(8766, 11182);
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 2101;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(2101, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8766, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 2101) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 2101, 0, 0, 0, 11, 0, 176495, 15312, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Undercity');

-- Squibby Overspeck Master Grom'gol The Purple Princess
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 3842;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3842, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8766, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 3842) AND (`SourceEntry` = 0) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3842, 0, 0, 0, 11, 0, 176495, 15314, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Grom\'gol');

-- Kraxx Engineer Undercity The Thundercaller, The Purple Princess
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8786;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8786, 0, 0, 'Where is the zeppelin to Orgrimmar right now?', 22108, 1, 1, 8765, 0, 0, 0, '', 0, 0),
(8786, 1, 0, 'Where is the zeppelin to Grom\'gol right now?', 22109, 1, 1, 8766, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8766);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8766, 11179, 0, 0, 11, 0, 176495, 15312, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Undercity'),
(14, 8766, 11180, 0, 1, 11, 0, 176495, 15314, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Grom\'gol'),
(14, 8766, 11182, 0, 2, 11, 0, 176495, 15313, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Undercity'),
(14, 8766, 11181, 0, 3, 11, 0, 176495, 15315, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Grom\'gol');
