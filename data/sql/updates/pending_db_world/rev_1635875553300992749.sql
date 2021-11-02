INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635875553300992749');

-- Fix Broadcast text for Jero'me
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`= 17583 WHERE `MenuID`=8060 AND `OptionID`=1;
