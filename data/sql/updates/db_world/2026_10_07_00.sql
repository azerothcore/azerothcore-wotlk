-- DB update 2026_10_06_06 -> 2026_10_07_00
-- Priestess Delrissa: compatibility respawn keeps the same object, so her Reset() respawns the same helpers
DELETE FROM `spawn_group` WHERE `spawnType` = 0 AND `spawnId` = 96966;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(1, 0, 96966);
