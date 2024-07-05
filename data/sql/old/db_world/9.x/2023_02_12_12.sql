-- DB update 2023_02_12_11 -> 2023_02_12_12
--
SET @CGUID := 2000102;
DELETE FROM `creature` WHERE `id1`=17578;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@CGUID,17578,540,3714,0,3,1,0,512.174,205.351,2.00779,0.698132,7200,0,0,0,0,0,0,0,0,'',14545),
(@CGUID+1,17578,540,3714,0,3,1,0,512.93,186.96,2.00013,0.767945,7200,0,0,0,0,0,0,0,0,'',14545),
(@CGUID+2,17578,540,3714,0,3,1,0,525.067,176.656,2.01602,2.35619,7200,0,0,0,0,0,0,0,0,'',14545),
(@CGUID+3,17578,540,3714,0,3,1,0,508.17,131.228,2.01886,1.22173,7200,0,0,0,0,0,0,0,0,'',14545),
(@CGUID+4,17578,540,3714,0,3,1,0,512.597,119.766,1.99459,0.663225,7200,0,0,0,0,0,0,0,0,'',14545),
(@CGUID+5,17578,540,3714,0,3,1,0,523.467,119.278,1.94614,2.04204,7200,0,0,0,0,0,0,0,0,'',14545);
