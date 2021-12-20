INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639812684867509600');

-- Source: TBC Classic 2.5.2.41446
/* Grell Camp stay mobs placement */
delete from creature where guid=47284 or guid=47286;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (47284, 1988, 0, 0, 0, 1, 1, 0, 0, 10267.1, 964.477, 1340.85, 0.844044, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (47286, 1988, 0, 0, 0, 1, 1, 0, 0, 10265.5, 967.318, 1340.81, 6.18836, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

/* Grellkin Camp stay mobs placement */
delete from creature where guid=47334 or guid=47344;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (47334, 1989, 0, 0, 0, 1, 1, 0, 0, 10331.1, 1036.3, 1339.32, 5.85673, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (47344, 1989, 0, 0, 0, 1, 1, 0, 0, 10339.1, 1040.53, 1339.32, 4.86607, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);
