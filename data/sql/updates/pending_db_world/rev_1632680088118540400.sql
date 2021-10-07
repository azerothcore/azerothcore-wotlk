INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632680088118540400');

DELETE FROM `creature` WHERE (`id` = 5930);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(16400, 5930, 1, 406, 465, 1, 1, 10875, 0, 684.793, 1458.34, -12.6599, 0.93, 43200, 10, 0, 2196, 1512, 1, 0, 0, 0, '', 0),
(29213, 5930, 1, 406, 465, 1, 1, 10875, 0, 657.605, 1796.68, -13.2473, 3.28, 43200, 20, 0, 2196, 1512, 1, 0, 0, 0, '', 0);

DELETE FROM `pool_creature` WHERE `guid` IN (16400, 29213);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(16400, 359, 0, 'Sister Riven Spawn 1'),
(29213, 359, 0, 'Sister Riven Spawn 2');
