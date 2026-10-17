-- DB update 2025_09_02_00 -> 2025_09_02_01
DELETE FROM `creature` WHERE `guid` = 1741 AND `id1` = 14724;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(1741, 14724, 0, 0, 0, 0, 0, 1, 1, 0, -4823.649, -1299.3605, 501.95117, 0.959931075572967529, 300, 0, 0, 1220, 0, 0, 0, 0, 0, '', 45613, 1, NULL);
