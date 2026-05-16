-- DB update 2026_03_19_00 -> 2026_03_19_01
-- Update gameobject 'Eye of Eternity' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (193070, 193958, 193960, 193908)) AND (`guid` IN (268037, 268038, 268039, 268040));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(268037, 193070, 616, 0, 0, 3, 1, 754.34552001953125, 1300.8697509765625, 256.24853515625, 3.141592741012573242, 0, 0, -1, 0, 7200, 0, 1, "", 45942, NULL),
(268038, 193958, 616, 0, 0, 1, 1, 754.25457763671875, 1301.7197265625, 266.170318603515625, 4.677483558654785156, 0, 0, -0.71933937072753906, 0.694658815860748291, 7200, 255, 1, "", 45942, NULL),
(268039, 193960, 616, 0, 0, 2, 1, 754.25457763671875, 1301.7197265625, 266.170318603515625, 4.677483558654785156, 0, 0, -0.71933937072753906, 0.694658815860748291, 7200, 255, 1, "", 45942, NULL),
(268040, 193908, 616, 0, 0, 3, 1, 724.6837158203125, 1332.9215087890625, 267.23419189453125, 5.480334281921386718, 0, 0, -0.39073085784912109, 0.920504987239837646, 7200, 255, 1, "", 45942, NULL);

-- TODO: should be spawned by script / SAI
-- new spawns
-- DELETE FROM `gameobject` WHERE (`id` IN (193908)) AND (`guid` IN (57));
-- INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- (57, 193908, 616, 0, 0, 3, 1, 724.66497802734375, 1332.969970703125, 220, 5.131268978118896484, 0, 0, -0.54463863372802734, 0.838670849800109863, 7200, 255, 1, "", 45942, NULL);
