-- DB update 2024_10_21_02 -> 2024_10_21_03
-- Update gameobject 'Skull 01' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (186328))
AND (`guid` IN (39812, 39813, 39814));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(39812, 186328, 189, 0, 0, 1, 1, 1777.71875, 1349.599365234375, 18.26383590698242187, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 7200, 255, 1, "", 46158, NULL),
(39813, 186328, 189, 0, 0, 1, 1, 1775.78125, 1346.6591796875, 18.0011749267578125, 4.729844093322753906, 0, 0, -0.70090866088867187, 0.713251054286956787, 7200, 255, 1, "", 46158, NULL),
(39814, 186328, 189, 0, 0, 1, 1, 1777.6514892578125, 1347.40478515625, 18.11984443664550781, 0.017452461645007133, 0, 0, 0.008726119995117187, 0.999961912631988525, 7200, 255, 1, "", 46158, NULL);

-- enable all spawns for eventEntry 12
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 12)
AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (186328)));
INSERT INTO `game_event_gameobject` (SELECT 12, `guid` FROM `gameobject` WHERE `id` IN (186328));
