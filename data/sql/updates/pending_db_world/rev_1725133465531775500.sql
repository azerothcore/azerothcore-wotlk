-- Update gameobject 'Irradiator 3000' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (202922))
AND (`guid` IN (30));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(30, 202922, 0, 0, 0, 1, 1, -4934.0380859375, 726.23956298828125, 261.645111083984375, 3.054326534271240234, 0, 0, 0.999048233032226562, 0.043619260191917419, 120, 255, 1, "", 53788, NULL);
