-- DB update 2026_02_25_05 -> 2026_02_25_06
-- Update gameobject 'Serpentshrine Console' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (185115, 185117, 185118)) AND (`guid` IN (191, 192, 193));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(191, 185115, 548, 0, 0, 1, 1, 373.139404296875, -465.10626220703125, 30.71641731262207031, 3.22885894775390625, 0, 0, -0.99904823303222656, 0.043619260191917419, 7200, 255, 0, "", 49345, NULL),
(192, 185117, 548, 0, 0, 1, 1, -245.729354858398437, -381.39300537109375, -0.18703900277614593, 2.879789113998413085, 0, 0, 0.991444587707519531, 0.130528271198272705, 7200, 255, 0, "", 49345, NULL),
(193, 185118, 548, 0, 0, 1, 1, 123.2582168579101562, -432.356719970703125, -1.19655394554138183, 4.799657344818115234, 0, 0, -0.67558956146240234, 0.737277925014495849, 7200, 255, 0, "", 49345, NULL);
