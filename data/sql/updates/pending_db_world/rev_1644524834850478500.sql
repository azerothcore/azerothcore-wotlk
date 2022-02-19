INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644524834850478500');

DELETE FROM `gossip_menu` WHERE `MenuID`=2062 AND `TextID`=3496;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (2062, 3496);
