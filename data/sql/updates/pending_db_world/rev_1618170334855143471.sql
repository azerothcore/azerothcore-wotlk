INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618170334855143471');

DELETE FROM `creature` WHERE (`id` = 6491) AND (`guid` IN (950));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(950, 6491, 0, 0, 0, 1, 1, 0, 0, 2053.1, -5019.08, 75.2506, 0.0315629, 300, 0, 0, 4121, 0, 0, 0, 0, 0, '', 0);

