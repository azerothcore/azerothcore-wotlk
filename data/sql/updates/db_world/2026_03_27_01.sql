-- DB update 2026_03_27_00 -> 2026_03_27_01
-- Doomrel (9039): Create "Continue..." menu and chain from initial gossip
DELETE FROM `gossip_menu` WHERE `MenuID` = 1950;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (1950, 2605);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 1950;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1950, 0, 0, 'Continue...', 5256, 1, 1, 0, 0, 0, 0, '', 0, 0);

UPDATE `gossip_menu_option` SET `ActionMenuID` = 1950 WHERE `MenuID` = 1947 AND `OptionID` = 0;

-- Gloomrel (9037): Create "Continue..." menus for smelt and chalice paths
DELETE FROM `gossip_menu` WHERE `MenuID` IN (1952, 1953);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(1952, 2606),
(1953, 2604);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (1952, 1953);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1952, 0, 0, 'Continue...', 5256, 1, 1, 0, 0, 0, 0, '', 0, 0),
(1953, 0, 0, 'Continue...', 5256, 1, 1, 0, 0, 0, 0, '', 0, 0);

UPDATE `gossip_menu_option` SET `ActionMenuID` = 1952 WHERE `MenuID` = 1945 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 1953 WHERE `MenuID` = 1945 AND `OptionID` = 1;

-- Gloomrel: Conditional gossip text when quest completed
DELETE FROM `gossip_menu` WHERE `MenuID` = 1945 AND `TextID` = 2605;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (1945, 2605);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 1945 AND `SourceEntry` = 2605;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 1945, 2605, 0, 0, 8, 0, 4083, 0, 0, 0, 0, 0, '', 'Gloomrel - text requires quest 4083 rewarded'),
(14, 1945, 2605, 0, 0, 7, 0, 186, 230, 0, 0, 0, 0, '', 'Gloomrel - text requires Mining >= 230'),
(14, 1945, 2605, 0, 0, 16, 0, 14891, 0, 0, 1, 0, 0, '', 'Gloomrel - text requires NOT having Smelt Dark Iron');

-- Gloomrel: Conditions for gossip options
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 1945 AND `SourceEntry` IN (0, 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1945, 0, 0, 0, 8, 0, 4083, 0, 0, 0, 0, 0, '', 'Gloomrel - option 0 requires quest 4083 rewarded'),
(15, 1945, 0, 0, 0, 7, 0, 186, 230, 0, 0, 0, 0, '', 'Gloomrel - option 0 requires Mining >= 230'),
(15, 1945, 0, 0, 0, 16, 0, 14891, 0, 0, 1, 0, 0, '', 'Gloomrel - option 0 requires NOT having Smelt Dark Iron'),
(15, 1945, 1, 0, 0, 8, 0, 4083, 0, 0, 1, 0, 0, '', 'Gloomrel - option 1 requires quest 4083 NOT rewarded'),
(15, 1945, 1, 0, 0, 7, 0, 186, 230, 0, 0, 0, 0, '', 'Gloomrel - option 1 requires Mining >= 230');
