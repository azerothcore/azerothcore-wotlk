INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624655271618733500');

DELETE FROM `creature` WHERE (`id` = 23602) AND (`guid` IN (31046));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(31046, 23602, 1, 0, 0, 1, 1, 21640, 0, -3647.61, -4449.4, 15.008, 0.536, 360, 0, 0, 1009, 1067, 2, 0, 0, 0, '', 0);