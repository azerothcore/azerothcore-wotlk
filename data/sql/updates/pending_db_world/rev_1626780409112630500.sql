INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626780409112630500');

-- Added 2 more spwn points and movement on them
DELETE FROM `creature` WHERE (`id` = 14343);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51897, 14343, 1, 0, 0, 1, 1, 0, 0, 5875.65, -1242.83, 403.304, 5.35714, 9900, 20, 0, 3082, 0, 1, 0, 0, 0, '', 0),
(301303, 14343, 1, 0, 0, 1, 1, 0, 0, 6091.22, -1485.77, 438.13, 0.18, 9900, 20, 0, 1, 0, 1, 0, 0, 0, '', 0),
(301304, 14343, 1, 0, 0, 1, 1, 0, 0, 6307.9, -1637.18, 474.611, 0, 9900, 20, 0, 1, 0, 1, 0, 0, 0, '', 0);

