INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629217819213526612');

-- Slightly changes position_z so that the mob doesn't fall through the floor on respawn
DELETE FROM `creature` WHERE (`id` = 7448) AND (`guid` IN (41253));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(41253, 7448, 1, 0, 0, 1, 1, 10810, 0, 6034.82, -5179.02, 867.5, 1.72181, 333, 15, 0, 3529, 0, 1, 0, 0, 0, '', 0);
