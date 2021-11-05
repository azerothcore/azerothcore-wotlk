INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635875025536424855');

-- Add missing gosip for Witch Doctor Uzer'i
DELETE FROM `gossip_menu` WHERE `MenuID` IN (1289);
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (1289,1924);
