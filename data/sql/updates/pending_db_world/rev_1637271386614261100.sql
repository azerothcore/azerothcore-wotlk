INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637271386614261100');

DELETE FROM `creature` WHERE `guid`=201207;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
('201207','2110','631','0','0','15','1','0','0','16.1163','2211.13','30.199','0.679835','86400','0','0','1','0','0','0','0','0','','0');

DELETE FROM `creature` WHERE `guid`=201208;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
('201208','38054','631','0','0','15','1','0','0','-46.5868','2251.06','30.7375','3.83972','86400','0','0','17880','8814','0','0','0','0','','0');
