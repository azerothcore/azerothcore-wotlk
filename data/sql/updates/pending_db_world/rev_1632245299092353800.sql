INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632245299092353800');

DELETE FROM `graveyard_zone` WHERE `ID` = 101 AND `GhostZone` = 135;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES
(101, 135, 469, 'Frostmane Hold, Kharanos GY - Dun Morogh');
