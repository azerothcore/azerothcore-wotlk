-- DB update 2026_03_07_00 -> 2026_03_07_01

-- Create new Guid.
DELETE FROM `creature` WHERE (`id1` = 33430) AND (`guid` IN (136607));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(136607, 33430, 0, 0, 603, 0, 0, 3, 1, 0, 2221.8308, -14.313417, 423.59442, 3.60960, 604800, 5, 0, 195495, 0, 1, 0, 0, 0, '', NULL, 49345);
