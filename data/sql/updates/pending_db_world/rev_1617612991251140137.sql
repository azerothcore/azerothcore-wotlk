INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617612991251140137');

DELETE FROM `creature` WHERE (`id` = 3273) AND (`guid` IN (20534));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(20534, 3273, 1, 0, 0, 1, 1, 9443, 1, 1.525501, -1759.818481, 95.022011, 1.5666, 275, 0, 0, 253, 264, 0, 0, 0, 0, '', 0);

