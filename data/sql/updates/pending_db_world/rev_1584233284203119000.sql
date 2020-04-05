INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584233284203119000');

DELETE FROM `gossip_menu` WHERE `MenuID`=55002 AND `TextID`=3550;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES 
(55002, 3550);
