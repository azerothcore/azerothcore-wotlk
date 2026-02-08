-- DB update 2024_01_14_08 -> 2024_01_14_09
-- Update gameobject 180665 'Draconic for Dummies' with sniffed values
DELETE FROM `gameobject` WHERE (`id` = 180665) AND (`guid` IN (268645));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(268645, 180665, 0, 0, 0, 1, 1, -8340.1962890625, 413.749908447265625, 124.4896774291992187, 2.827429771423339843, 0, 0, 0.987688064575195312, 0.156436234712600708, 120, 255, 1, "", 50664, NULL);
