--Thrall
DELETE FROM `creature` WHERE (`id1` = 4949) AND (`guid` IN (4770));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(4770, 4949, 0, 0, 1, 0, 0, 1, 1, 1, 1920.01, -4123.95, 43.7161, 4.834561824798584, 7200, 0, 0, 5578000, 127740, 0, 0, 0, 0, '', 0);
