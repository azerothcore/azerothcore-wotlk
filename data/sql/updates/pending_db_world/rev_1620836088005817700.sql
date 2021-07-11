INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620836088005817700');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 4042) AND `TextID` IN (4917, 4918);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(4042, 4917),
(4042, 4918);
