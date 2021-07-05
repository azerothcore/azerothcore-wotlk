INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625481187426686000');

-- Fix https://github.com/azerothcore/azerothcore-wotlk/issues/4173
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 5851) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(5851, 0, 0, 'I know this is rather silly but a young ward who is a bit shy would like your hoofprint.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);
