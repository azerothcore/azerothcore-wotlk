INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617634980911314885');

DELETE FROM `creature` WHERE (`id` = 7318) AND (`guid` IN (46818));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(46818, 7318, 1, 0, 0, 1, 1, 6231, 1, 9843.19, 1496.22, 1257.25, 2.34654, 300, 0, 0, 186, 191, 2, 0, 0, 0, '', 0);

