-- DB update 2025_09_04_01 -> 2025_09_04_02
-- Update gameobject 'Gravestone' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (192256)) AND (`guid` IN (76993));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76993, 192256, 571, 0, 0, 1, 1, 9025.6845703125, -1178.6163330078125, 1058.107666015625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 46368, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192257, 192258, 192260, 192265, 192380)) AND (`guid` BETWEEN 265 AND 269);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(265, 192257, 571, 0, 0, 1, 1, 8094.673828125, -995.29864501953125, 936.18206787109375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 53788, NULL),
(266, 192258, 571, 0, 0, 1, 1, 7832.95556640625, -2018.984375, 1224.683349609375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 52237, NULL),
(267, 192260, 571, 0, 0, 1, 1, 7463.06689453125, -3326.37841796875, 897.74884033203125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 47720, NULL),
(268, 192265, 571, 0, 0, 1, 1, 6942.8603515625, -552.515625, 914.403564453125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 50664, NULL),
(269, 192380, 571, 0, 0, 1, 1, 6431.64404296875, -1186.592041015625, 446.2081298828125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 47720, NULL);

-- remaining spawns (no sniffed values available)
-- (`guid` IN (77187))
