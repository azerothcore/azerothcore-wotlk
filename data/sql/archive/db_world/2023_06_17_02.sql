-- DB update 2023_06_17_01 -> 2023_06_17_02
--
UPDATE `gameobject` SET `spawnMask` = `spawnMask`&~2 WHERE `guid`=9890 AND `id` = 184465;

DELETE FROM `gameobject` WHERE `guid` = 9891 AND `id` = 184849;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(9891, 184849, 554, 3849, 3849, 2, 222.543, 70.6106, -0.00479339, 4.67748, -0.719339, 0.694659, 7200, 255, 1, 46924);
