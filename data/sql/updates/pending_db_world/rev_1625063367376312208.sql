INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625063367376312208');

-- Azzere the Skyblade 5834 - MovementType to 1, wander_distance to 20
DELETE FROM `creature` WHERE `id` = 5834 AND `guid` = 51813;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51813, 5834, 1, 0, 0, 1, 1, 0, 0, -2685.14, -1940.75, 98.2187, 3.55377, 9900, 20, 0, 622, 982, 1, 0, 0, 0, '', 0);
