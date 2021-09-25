INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632554476888218890');

-- Add vendor option to Innkeeper Shaussiy
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 347 AND `OptionID` = 3;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(347, 3, 1, 'Let me browse your goods.', 2823, 3, 128, 0, 0, 0, 0, '', 0, 0);

