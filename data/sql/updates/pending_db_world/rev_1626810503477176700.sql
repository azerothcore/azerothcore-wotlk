INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626810503477176700');

UPDATE `graveyard_zone` SET `Faction`=67 WHERE `Id`=97 AND `GhostZone`=209;
UPDATE `graveyard_zone` SET `Faction`=469 WHERE `Id`=149 AND `GhostZone`=209;

DELETE FROM `graveyard_zone` WHERE `ID`=1256 AND `GhostZone`=209;
INSERT INTO `graveyard_zone` VALUES
(1256,209,0,'Silverpine Forest, South GY - Silverpine Forest');
