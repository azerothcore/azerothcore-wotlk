--
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 1701 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1701, 0, 1, 'I''d like to purchase more Tharlendris seeds.', 4851, 3, 128, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (1701, 1922) AND `SourceEntry` = 0 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1922, 0, 0, 0, 8, 0, 3781, 0, 0, 0, 0, 0, '', 'Quintis Jonespyre - Show gossip option if player has rewarded quest 3781'),
(15, 1701, 0, 0, 0, 8, 0, 3782, 0, 0, 0, 0, 0, '', 'Bashana Runetotem - Show gossip option if player has rewarded quest 3782');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` IN (4217, 7879, 9087) AND `SourceEntry` IN (11020, 11022) AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 4217, 11020, 0, 0, 8, 0, 3781, 0, 0, 0, 0, 0, '', 'Mathrengyl Bearwalker - Sell Evergreen Pouch if player has rewarded quest 3781'),
(23, 4217, 11022, 0, 0, 8, 0, 3781, 0, 0, 0, 0, 0, '', 'Mathrengyl Bearwalker - Sell Packet of Tharlendris Seeds if player has rewarded quest 3781'),
(23, 7879, 11020, 0, 0, 8, 0, 3781, 0, 0, 0, 0, 0, '', 'Quintis Jonespyre - Sell Evergreen Pouch if player has rewarded quest 3781'),
(23, 7879, 11022, 0, 0, 8, 0, 3781, 0, 0, 0, 0, 0, '', 'Quintis Jonespyre - Sell Packet of Tharlendris Seeds if player has rewarded quest 3781'),
(23, 9087, 11020, 0, 0, 8, 0, 3782, 0, 0, 0, 0, 0, '', 'Bashana Runetotem - Sell Evergreen Pouch if player has rewarded quest 3782'),
(23, 9087, 11022, 0, 0, 8, 0, 3782, 0, 0, 0, 0, 0, '', 'Bashana Runetotem - Sell Packet of Tharlendris Seeds if player has rewarded quest 3782');
