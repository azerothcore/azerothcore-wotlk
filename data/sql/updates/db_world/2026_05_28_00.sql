-- DB update 2026_05_26_00 -> 2026_05_28_00
--
DELETE FROM `spawn_group` WHERE `spawnId` IN (153154, 153155, 153156, 153157);
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(1, 0, 153154),
(1, 0, 153155),
(1, 0, 153156),
(1, 0, 153157);
