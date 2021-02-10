INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612936373912315500');

DELETE FROM `creature` WHERE (`id` = 25582) AND (`guid` IN (118406));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(118406, 25582, 571, 0, 0, 1, 1, 23916, 0, 2191.93, 5401.03, 39.1387, 5.90105, 300, 0, 0, 6986, 2991, 0, 0, 0, 0, '', 0);
