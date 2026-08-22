-- DB update 2026_08_22_02 -> 2026_08_22_03
DELETE FROM `spawn_group` WHERE `spawnType` = 0 AND `spawnId` = 135823;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES (1, 0, 135823);
