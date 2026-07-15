--
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 6626 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`) VALUES
(6626, 0, 0, 'Please tell me the Phrase..', 0, 0, 0, 0, 0, 0, 0, '', 0);
