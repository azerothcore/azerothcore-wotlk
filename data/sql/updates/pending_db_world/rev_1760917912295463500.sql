DELETE FROM `gossip_menu_option` WHERE `MenuID`=7866;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7866, 0, 0, 'Who is Talon King Ikiss?', 16067, 1, 1, 7876, 0, 0, 0, NULL, 0, 0),
(7866, 1, 0, 'Who are the Sethekk?', 16068, 1, 1, 7874, 0, 0, 0, NULL, 0, 0),
(7866, 2, 0, 'Who is this Terokk you keep mentioning?', 16070, 1, 1, 7877, 0, 0, 0, NULL, 0, 0);
