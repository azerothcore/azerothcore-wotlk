INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612709699286458572');

DELETE FROM `creature` WHERE (`id` = 2164) AND (`guid` IN (37191));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(37191, 2164, 1, 0, 0, 1, 1, 8840, 0, 6892.373047, 9.62545, 24.915615, 0.547067, 275, 5, 0, 341, 0, 1, 0, 0, 0, '', 0);

