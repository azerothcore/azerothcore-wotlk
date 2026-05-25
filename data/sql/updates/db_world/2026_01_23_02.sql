-- DB update 2026_01_23_01 -> 2026_01_23_02
-- Update gameobject 'Gravestone' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (193986)) AND (`guid` IN (77187));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(77187, 193986, 571, 0, 0, 1, 1, 7917.5458984375, -2461.020751953125, 1135.9365234375, 3.071766138076782226, 0, 0, 0.999390602111816406, 0.034906134009361267, 120, 255, 1, "", 45942, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192261)) AND (`guid` IN (48));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(48, 192261, 571, 0, 0, 1, 1, 7088.26123046875, -1432.3819580078125, 921.5340576171875, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 52237, NULL);
