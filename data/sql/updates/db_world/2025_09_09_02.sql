-- DB update 2025_09_09_01 -> 2025_09_09_02
-- Update gameobject 'Death's Gaze Orb' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192917)) AND (`guid` IN (174, 175, 176));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(174, 192917, 571, 0, 0, 1, 1, 6475.67822265625, 3399.67529296875, 599.08349609375, 2.059488296508789062, 0, 0, 0.857167243957519531, 0.515038192272186279, 120, 255, 1, "", 46368, NULL),
(175, 192917, 571, 0, 0, 1, 1, 6514.7314453125, 3273.22216796875, 667.54388427734375, 3.926995515823364257, 0, 0, -0.92387866973876953, 0.38268551230430603, 120, 255, 1, "", 46368, NULL),
(176, 192917, 571, 0, 0, 1, 1, 6705.81982421875, 3528.986328125, 673.74957275390625, 0.715584874153137207, 0, 0, 0.350207328796386718, 0.936672210693359375, 120, 255, 1, "", 46368, NULL);
