-- DB update 2026_02_02_00 -> 2026_02_02_01
-- Update gameobject 'Broken Cart' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (186807)) AND (`guid` IN (171));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(171, 186807, 1, 0, 0, 1, 1, 828.43792724609375, -4508.498046875, 6.702891826629638671, 3.94444584846496582, 0, 0, -0.92050457000732421, 0.3907318115234375, 120, 255, 1, "", 45613, NULL);
