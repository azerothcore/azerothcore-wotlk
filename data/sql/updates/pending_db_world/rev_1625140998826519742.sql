INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625140998826519742');

-- Silithid Harvester - wander_distance to 15, MovementType to 1
DELETE FROM `creature` WHERE `id` = 3253 AND `guid` = 51814;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51814, 3253, 1, 0, 0, 1, 1, 0, 0, -3122.22, -1741.87, 92.0056, 2.34818, 9900, 15, 0, 664, 0, 1, 0, 0, 0, '', 0);
