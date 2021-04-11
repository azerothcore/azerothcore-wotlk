INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617475678754474649');

DELETE FROM `creature` WHERE (`id` = 2960) AND (`guid` IN (25623));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(25623, 2960, 1, 0, 0, 1, 1, 161, 0, -718.670898, -677.328979, -15.930156, 5.17604, 250, 20, 0, 176, 0, 1, 0, 0, 0, '', 0);

