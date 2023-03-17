--
DELETE FROM `creature` WHERE (`id1` = 23272) AND (`guid` IN (2196));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(2196, 23272, 0, 0, 530, 0, 0, 1, 1, 0, -2139.45, 5554.06, 50.29, 0.433, 25, 0, 0, 5589, 3155, 0, 0, 0, 0, '', 0);
DELETE FROM `creature` WHERE `id1` = 23079;
DELETE FROM `creature` WHERE `id1` = 23719;
