INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609414989791132104');
DELETE FROM `creature` WHERE (`id` = 1766) AND (`guid` IN (17952));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(17952, 1766, 0, 0, 0, 1, 1, 246, 0, 1016.2447, 1489.1141, 41.584156, 0.199946, 275, 5, 0, 222, 0, 1, 0, 0, 0, '', 0);

