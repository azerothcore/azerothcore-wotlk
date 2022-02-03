INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643931984499831200');

UPDATE `gossip_menu` SET `TextId`=9192 WHERE `MenuID`=6648 AND `TextID`=9190;
UPDATE `conditions` SET `SourceEntry`=9192 WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6648 AND `SourceEntry`=9190;
