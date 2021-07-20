INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626782944130753700');

-- Changed the spawn point of Spellmaw closer to the ground and added patrolling around
DELETE FROM `creature` WHERE (`id` = 10662) AND (`guid` IN (42265));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(42265, 10662, 1, 0, 0, 1, 1, 9995, 0, 6247.134, -4412.64, 687.228, 4.67879, 600, 20, 0, 16194, 0, 1, 0, 0, 0, '', 0);

