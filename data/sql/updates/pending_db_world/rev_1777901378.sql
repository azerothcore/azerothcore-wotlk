
-- Add Stitches to legacy spawn group.
DELETE FROM `spawn_group` WHERE `spawnId` = 300000;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(1, 0, 300000);
