INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625481187426686000');

-- Fix https://github.com/azerothcore/azerothcore-wotlk/issues/4173
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 5851) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(5851, 0, 0, 'I know this is rather silly but a young ward who is a bit shy would like your hoofprint.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);


-- Fix https://github.com/azerothcore/azerothcore-wotlk/issues/4147
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7582) AND (`OptionID` IN (1));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7582, 1, 0, 'I did not mean to deceive you, elder. The draenei of Telredor thought to approach you in a way that would seem familiar to you.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7582) AND (`OptionID` IN (2));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7582, 2, 0, 'I will tell them. Farewell, elder.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7560) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7560, 0, 0, 'Grant me your mark, mighty ancient.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7559) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7559, 0, 0, 'Grant me your mark, wise ancient.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);



