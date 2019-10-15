INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571179939629745569');

-- Quest "The Exorcism of Colonel Jules": Remove duplicate gossip entry
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8539;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES
(8539,0,0,'I am ready, Anchorite.  Let us begin the exorcism.',20396,1,3,0,0,0,0,NULL,0,0);
