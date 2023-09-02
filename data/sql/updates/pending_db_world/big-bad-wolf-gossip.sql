--
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (7423, 7424, 7425) AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(7423, 0, 0, 'Oh, grandmother, what big ears you have.', 14217, 0, 0, 0, 0, 0, 0, NULL, 0, 0),
(7424, 0, 0, 'Oh, grandmother, what big eyes you have.', 14219, 0, 0, 0, 0, 0, 0, NULL, 0, 0),
(7425, 0, 0, 'Oh, grandmother, what phat lewts you have.', 14221, 0, 0, 0, 0, 0, 0, NULL, 0, 0);

DELETE FROM `gossip_menu` WHERE `MenuID` IN (7423, 7424, 7425) AND `TextID` IN (9009, 9010, 9011);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7423, 9009),
(7424, 9010),
(7425, 9011);
