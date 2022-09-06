-- DB update 2022_09_06_05 -> 2022_09_06_06
DELETE FROM `lfg_dungeon_template` WHERE `dungeonId` IN (2, 276);
INSERT INTO `lfg_dungeon_template`
(`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`,
`VerifiedBuild`)
VALUES
(2, 'Scholomance', 196.37, 127.05, 134.91, 6.09, 0),
(276, 'Blackrock Depths - Upper City', 458.32, 26.52, -70.67, 4.95, 0);
