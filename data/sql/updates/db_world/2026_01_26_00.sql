-- DB update 2026_01_24_01 -> 2026_01_26_00
--
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (7815, 7820, 8760, 10363) AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`,
`OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7815, 1, 1, 'Let me browse your goods.', 8097, 3, 128, 0, 0, 0, 0, '', 0, 0),
(7820, 1, 1, 'Let me browse your goods.', 8097, 3, 128, 0, 0, 0, 0, '', 0, 0),
(8760, 1, 1, 'Let me browse your goods.', 8097, 3, 128, 0, 0, 0, 0, '', 0, 0),
(10363, 1, 1, 'Let me browse your goods.', 8097, 3, 128, 0, 0, 0, 0, '', 0, 0);
