INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641340369241454365');

#closes AC issue #9996
DELETE FROM `creature` WHERE (`guid`=62817);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(62817,17374,530,0,0,1,1,0,0,-3525.93,-12480.8,15.5967,4.46185,300,5,0,137,0,1,0,0,0,'',0);