-- DB update 2026_02_03_00 -> 2026_02_03_01
-- DB/Gameobject: Update "Dangerous!" sign with sniffed values
-- Closes https://github.com/azerothcore/azerothcore-wotlk/issues/16834
DELETE FROM `gameobject` WHERE `guid` = 17154 AND `id` = 2008;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(17154, 2008, 0, 267, 272, 1, 1, -19.4826393127441406, -935.3038330078125, 58.09708786010742187, 2.65289926528930664, -0.04655265808105468, 0.011606216430664062, 0.969178199768066406, 0.241643846035003662, 120, 255, 1, 42328);
