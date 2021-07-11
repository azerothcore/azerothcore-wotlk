INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621544089475974100');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 9676) AND (`TextID` IN (13287));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9676, 13287);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 9676) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9676, 0, 0, 'I''m ready to battle the dreadlord, sire.', 28508, 1, 1, 0, 0, 0, 0, '', 0, 0);
