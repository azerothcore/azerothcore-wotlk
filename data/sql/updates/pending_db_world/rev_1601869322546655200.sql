INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601869322546655200');

DELETE FROM `creature` WHERE (`id` = 18956) AND (`guid` IN (132569));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(132569, 18956, 556, 0, 0, 3, 1, 18347, 1, -160.813, 157.043, 0.094095, 1.0821, 86400, 0, 0, 6326, 0, 0, 0, 0, 0, '', 0);
