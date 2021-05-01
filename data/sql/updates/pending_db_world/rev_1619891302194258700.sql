INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619891302194258700');
DELETE FROM `graveyard_zone` WHERE `ID`=852 AND `GhostZone`=1537;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES
(852, 1537, 469, 'Ironforge');
