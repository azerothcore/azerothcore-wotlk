INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618169871194421039');

DELETE FROM `creature` WHERE (`id` = 9164) AND (`guid` IN (24506));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(24506, 9164, 1, 0, 0, 1, 1, 8512, 0, -7306.250977, -375.499695, -268.558746, 0.703892, 300, 5, 0, 3293, 0, 1, 0, 0, 0, '', 0);
