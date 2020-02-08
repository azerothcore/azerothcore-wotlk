INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1581196474128672400');

DELETE FROM `creature` WHERE `guid`=3110362;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (3110362, 15625, 0, 0, 0, 1, 1, 0, 0, -10325.9, -490.507, 50.3208, 5.67792, 300, 0, 0, 832750, 0, 0, 0, 0, 0, '', 0);
