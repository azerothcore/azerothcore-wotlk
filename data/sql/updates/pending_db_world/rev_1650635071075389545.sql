INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650635071075389545');

DELETE FROM `creature` WHERE (`guid` = 38336) AND (`id1` = 1535);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(38336, 1535, 0, 0, 0, 0, 0, 1, 1, 1, 2319.13, 1614.74, 38.1725, 3.14159, 300, 10, 0, 120, 0, 0, 0, 0, 0, '', 0);
