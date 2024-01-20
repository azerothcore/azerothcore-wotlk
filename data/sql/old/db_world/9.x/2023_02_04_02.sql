-- DB update 2023_02_04_01 -> 2023_02_04_02
-- fix 6899 gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `MenuID`=6899;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(6899, 0, 0, 'Where is Elder Darkcore?', 11493, 1, 1, 21086, 0, 0, 0, '', 0, 0),
(6899, 1, 0, 'Where is Elder Ironband?', 11507, 1, 1, 6854, 0, 0, 0, '', 0, 0),
(6899, 2, 0, 'Where is Elder Wheathoof?', 11582, 1, 1, 6895, 0, 0, 0, '', 0, 0),
(6899, 3, 0, 'Where is Elder Runetotem?', 11588, 1, 1, 21122, 0, 0, 0, '', 0, 0),
(6899, 4, 0, 'Where is Elder Windtotem?', 11576, 1, 1, 21147, 0, 0, 0, '', 0, 0);
