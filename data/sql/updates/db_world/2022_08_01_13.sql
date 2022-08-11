-- DB update 2022_08_01_12 -> 2022_08_01_13
DELETE FROM `creature` WHERE `guid` IN (161044, 161045, 161046);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(161044, 1128, 0, 0, 0, 0, 0, 1, 1, 0, -4310.01, -1447.54, 400.56363, 3.93681, 120, 19, 0, 122, 0, 1, 0, 0, 0, '', 0),
(161045, 1128, 0, 0, 0, 0, 0, 1, 1, 0, -4293.55, -1431.15, 390.08798, 2.1588, 120, 13, 0, 144, 0, 1, 0, 0, 0, '', 0),
(161046, 1129, 0, 0, 0, 0, 0, 1, 1, 0, -4300.36, -1420.53, 391.496, 5.16617, 120, 0, 0, 144, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_addon` WHERE `guid` = 161046;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES (161046, 0, 0, 1, 0, 0, 0, NULL);
