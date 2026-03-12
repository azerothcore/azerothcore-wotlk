-- DB update 2024_11_11_04 -> 2024_11_12_00
-- Update gameobject 'Zul' Aman Misc' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (186733, 187359))
AND (`guid` IN (12647, 20584));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- The Map of Zul'Aman
(12647, 186733, 568, 0, 0, 1, 1, -150.912109375, 1343.1505126953125, 49.78499984741210937, 5.253442287445068359, 0, 0, -0.49242305755615234, 0.870355963706970214, 7200, 255, 1, "", 49345, NULL),
-- Strange Gong
(20584, 187359, 568, 0, 0, 1, 1, 134.0087890625, 1642.7974853515625, 42.08407974243164062, 3.141592741012573242, 0, 0, -1, 0, 7200, 255, 1, "", 49345, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (186430, 186748, 186865))
AND (`guid` BETWEEN 381 AND 384);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- Zungam's Ball and Chain
(381, 186430, 568, 0, 0, 1, 1, 251.4287109375, 996.85614013671875, 10.91197776794433593, 2.111847877502441406, 0, 0, 0.870355606079101562, 0.492423713207244873, 7200, 255, 1, "", 49345, NULL),
-- Harkor's Brew Keg
(382, 186748, 568, 0, 0, 1, 1, 99.88021087646484375, 694.3485107421875, 45.11137771606445312, 0.837757468223571777, 0, 0, 0.406736373901367187, 0.913545548915863037, 7200, 255, 1, "", 53788, NULL),
-- Amani Drum
(383, 186865, 568, 0, 0, 1, 1, 148.782989501953125, 707.01702880859375, 45.11137771606445312, 3.071766138076782226, 0, 0, 0.999390602111816406, 0.034906134009361267, 7200, 255, 1, "", 50375, NULL),
(384, 186865, 568, 0, 0, 1, 1, 92.7647552490234375, 707.51788330078125, 45.11137771606445312, 0.017452461645007133, 0, 0, 0.008726119995117187, 0.999961912631988525, 7200, 255, 1, "", 53788, NULL);
