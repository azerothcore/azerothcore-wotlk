INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613754823292962300');

DELETE FROM `creature` WHERE (`id` = 6670) AND (`guid` IN (45520));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(45520, 6670, 0, 0, 0, 1, 1, 3264, 1, -10635.487305, 1192.840332, 34.679794, 6.131781, 300, 0, 0, 102, 0, 0, 0, 0, 0, '', 0);
