INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629122909167793000');

DELETE FROM `creature` WHERE `guid` = 79330 AND `id` = 657;
DELETE FROM `creature` WHERE `guid` = 79338 AND `id` = 1732;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(79330, 657, 36, 0, 0, 1, 1, 0, 1, -36.8196, -794.341, 18.8055, 6.26542, 86400, 0, 0, 1347, 0, 0, 0, 0, 0, '', 0),
(79338, 1732, 36, 0, 0, 1, 1, 0, 1, -21.7653, -811.787, 19.5538, 1.62187, 86400, 0, 0, 1137, 2236, 0, 0, 0, 0, '', 0);
