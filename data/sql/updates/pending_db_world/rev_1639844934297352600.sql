INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639844934297352600');

DELETE FROM `graveyard_zone` WHERE `ID`=1409 AND `GhostZone`=1497;
INSERT INTO `graveyard_zone` VALUES
(1409,1497,469,'Tirisfal Glades - Undercity - Alliance');
