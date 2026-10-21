-- DB update 2026_09_28_01 -> 2026_09_28_02
-- Zul'Aman hostages: move the hardcoded gossip option to the DB (credit: TrinityCore)
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (8799, 8874, 8881, 8927) AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8799, 0, 0, 'Nalorakk is dead, you\'re free to go.', 23015, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(8874, 0, 0, 'The coast is clear. You\'re free!', 22965, 1, 1, 0, 0, 0, 0, '', 0, 11723),
(8881, 0, 0, 'We\'ve killed your captors. You\'re free to go.\n', 23090, 1, 1, 0, 0, 0, 0, '', 0, 0),
(8927, 0, 0, 'It\'s safe, little gnome. You can come out now.', 23154, 1, 1, 0, 0, 0, 0, '', 0, 0);
