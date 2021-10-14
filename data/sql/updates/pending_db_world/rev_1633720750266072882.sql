INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633720750266072882');

##6209 fix Young Wetlands Crocolisk
DELETE FROM `creature` WHERE (`id` = 1417) AND (`guid` IN (10859));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(10859, 1417, 0, 0, 0, 1, 1, 1035, 0, -3142.84, -1901.37, 7.25187, 4.08753, 300, 10, 0, 531, 0, 1, 0, 0, 0, '', 0);
