DELETE FROM `lfg_dungeon_template` WHERE `dungeonId` IN (2, 44, 276);
INSERT INTO `lfg_dungeon_template`
(`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`,
`VerifiedBuild`)
VALUES
(2, 'Scholomance', 196.37, 127.05, 134.91, 6.09, 0),
(276, 'Blackrock Depths - Upper City', 458.32, 26.52, -70.67, 4.95, 0),
(44, 'Upper Blackrock Spire', 78.5083, -225.044, 49.839, 5.1, 0);

