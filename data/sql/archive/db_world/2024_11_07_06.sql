-- DB update 2024_11_07_05 -> 2024_11_07_06
-- Update gameobject 'Zul' Aman doors' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (186728, 186305))
AND (`guid` IN (18539, 47284));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- Massive Gate
(18539, 186728, 568, 0, 0, 1, 1, 120.293670654296875, 1605.67236328125, 63.18039703369140625, 3.138830423355102539, 0, 0, 0.999999046325683593, 0.001381067908369004, 7200, 255, 1, "", 49345, NULL),
-- Hexlord Entrance
(47284, 186305, 568, 0, 0, 1, 1, 124.2034759521484375, 1022.95068359375, 34.14412689208984375, 4.703663349151611328, 0, 0, -0.71018505096435546, 0.704015016555786132, 7200, 255, 1, "", 49345, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (186303, 186304, 186306, 186858, 186859))
AND (`guid` BETWEEN 357 AND 361);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- Lynx Temple Exit
(357, 186303, 568, 0, 0, 1, 1, 305.907958984375, 1112.0867919921875, 9.956597328186035156, 3.141592741012573242, 0, 0, -1, 0, 7200, 255, 1, "", 49345, NULL),
-- Lynx Temple Entrance
(358, 186304, 568, 0, 0, 1, 1, 375.409881591796875, 1057.67138671875, 9.861444473266601562, 4.712389945983886718, 0, 0, -0.70710659027099609, 0.707106947898864746, 7200, 255, 0, "", 49345, NULL),
-- Wooden Door
(359, 186306, 568, 0, 0, 1, 1, 123.2563705444335937, 914.42144775390625, 34.14412689208984375, 4.703663349151611328, 0, 0, -0.71018505096435546, 0.704015016555786132, 7200, 255, 1, "", 49345, NULL),
-- Doodad_ZulAman_WindDoor01
(360, 186858, 568, 0, 0, 1, 1, 337.066009521484375, 1396.0947265625, 74.1723175048828125, 3.429581403732299804, 0, 0, -0.98965072631835937, 0.143497169017791748, 7200, 255, 0, "", 49345, NULL),
-- Doodad_ZulAman_FireDoor01
(361, 186859, 568, 0, 0, 1, 1, 120.2938995361328125, 732.0076904296875, 45.01099395751953125, 1.562069892883300781, 0, 0, 0.704014778137207031, 0.71018528938293457, 7200, 255, 0, "", 49345, NULL);
