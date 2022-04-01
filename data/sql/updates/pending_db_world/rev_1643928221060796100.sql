INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643928221060796100');

UPDATE `gossip_menu` SET `TextID`=3218 WHERE `MenuID`=12726 AND `TextID`=17861;
DELETE FROM `npc_text` WHERE `ID`=17861;
