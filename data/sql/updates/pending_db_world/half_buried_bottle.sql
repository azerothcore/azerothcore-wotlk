--
DELETE FROM `gameobject` WHERE (`id` = 2560) AND (`guid` IN (11031, 11034, 11705));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(11031, 2560, 0, 33, 311, 1, 1, -13734.8, -255.343, 0.508326, 0.523599, 0, 0, 0.258819, 0.965926, 900, 100, 1, '', 0),
(11034, 2560, 0, 33, 302, 1, 1, -13912.6, -166.436, 2.541038, -0.296706, 0, 0, 0.147809, -0.989016, 900, 100, 1, '', 0),
(11705, 2560, 0, 33, 297, 1, 1, -14592.1, -83.6838, 0.853386, -3.01942, 0, 0, 0.998135, -0.061048, 900, 100, 1, '', 0);
