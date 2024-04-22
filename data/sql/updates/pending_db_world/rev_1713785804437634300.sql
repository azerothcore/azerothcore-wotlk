-- Update gameobject 'Doodad_DwarfSign_Alchemist01' with sniffed values
-- this spawn was using the (incorrect) ID 34357 before
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (175664, 34357))
AND (`guid` IN (14232));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(14232, 175664, 369, 0, 0, 1, 1, 146.4382476806640625, 27.88295173645019531, -0.14269599318504333, 3.878999233245849609, 0, 0, -0.93279552459716796, 0.360406070947647094, 7200, 255, 1, "", 50250, NULL);
