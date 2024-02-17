-- Update gameobject 19878 'Parts Crate' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` = 19878) AND (`guid` IN (15));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(15, 19878, 1, 0, 0, 1, 1, -6232.25537109375, -3854.71875, -58.7500534057617187, 4.084071159362792968, 0, 0, -0.8910064697265625, 0.453990638256072998, 120, 255, 1, "", 51943, NULL);
