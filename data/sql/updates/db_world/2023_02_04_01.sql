-- DB update 2023_02_04_00 -> 2023_02_04_01
-- fix 6815 gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `MenuID`=6815;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(6815, 4, 0, 'Where is Elder Darkhorn?', 11584, 1, 1, 6896, 0, 0, 0, '', 0, 0),
(6815, 3, 0, 'Where is Elder Windtotem?', 11576, 1, 1, 21147, 0, 0, 0, '', 0, 0),
(6815, 2, 0, 'Where is Elder Moonwarden?', 11580, 1, 1, 21107, 0, 0, 0, '', 0, 0),
(6815, 1, 0, 'Where is Elder High Mountain?', 11578, 1, 1, 21097, 0, 0, 0, '', 0, 0);
