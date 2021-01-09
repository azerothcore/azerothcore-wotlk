INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609978307795332000');
DELETE FROM `graveyard_zone` WHERE (`ID` = 925) AND (`GhostZone` = 3479);
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES
(925, 3479, 0, 'Bloodmyst, Blood Watch GY - Bloodmyst Isle');
