-- Add missing gossip menu option for Brann Bronzebeard (MenuID 9670)
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9670 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9670, 0, 0, 'Let\'s move Brann, enough of the history lessons!', 27618, 1, 1, 0, 0, 0, 0, '', 0, 0);
