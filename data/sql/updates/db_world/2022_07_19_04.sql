-- DB update 2022_07_19_03 -> 2022_07_19_04
--
/* Maintenance on ZG Entranceway mobs part 2 Pooling */
DELETE FROM `creature` WHERE `guid` IN (49116, 49117, 49118, 49119);
DELETE FROM `creature_addon` WHERE `guid` IN (49116, 49117, 49118, 49119);
DELETE FROM `waypoint_data` WHERE `id` IN (49116, 49117, 49118, 49119);

/* 20 Pools of V( (Themselves Pooled) to represent every possibility;  this is the only way I know how to represent every possibility I am open to other suggestions; 72 snakes

INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+, 0, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- Empty Occasionally 1 slot, front facing exit 
(@GUID+, 0, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- Empty Occasionally 2 slot left facing exit
(@GUID+, 0, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3 slot center slot
(@GUID+, 0, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0); -- 4 slot right slot

@POOL+0 Master Pool of all of the following Pools

8 Pools are 6.25% to create a 50% chance of 3 mobs spawning, let E1 and E2 represent empty xyz slots that have been witnessed empty

@POOL+1 E1 A@GUID+0 S@GUID+1 X@GUID+2
@POOL+2 E1 A@GUID+3 X@GUID+4 S@GUID+5
@POOL+3 E1 S@GUID+6 A@GUID+7 X@GUID+8
@POOL+4 E1 S@GUID+9 X@GUID+10 A@GUID+11
@POOL+5 A@GUID+12 E2 S@GUID+13 X@GUID+14
@POOL+6 A@GUID+15 E2 X@GUID+16 S@GUID+17
@POOL+7 S@GUID+18 E2 A@GUID+19 X@GUID+20
@POOL+8 S@GUID+21 E2 X@GUID+22 A@GUID+23

11 Pools of 4.16% and 1 of 4.24% to create a 50% chance of 4 mobs spawning 1-3 of each type
@POOL+9 A@GUID+24 S@GUID+25 X@GUID+26 X@GUID+27
@POOL+10 A@GUID+28 X@GUID+29 S@GUID+30 X@GUID+31
@POOL+11 A@GUID+32 X@GUID+33 X@GUID+34 S@GUID+35
@POOL+12 S@GUID+36 A@GUID+37 X@GUID+38 X@GUID+39
@POOL+13 S@GUID+40 X@GUID+41 A@GUID+42 X@GUID+43
@POOL+14 S@GUID+44 X@GUID+45 X@GUID+46 A@GUID+47
@POOL+15 X@GUID+48 A@GUID+49 S@GUID+50 X@GUID+51
@POOL+16 X@GUID+52 A@GUID+53 X@GUID+54 S@GUID+55
@POOL+17 X@GUID+56 S@GUID+57 A@GUID+58 X@GUID+59
@POOL+18 X@GUID+60 S@GUID+61 X@GUID+62 A@GUID+63
@POOL+19 X@GUID+64 X@GUID+65 A@GUID+66 S@GUID+67
@POOL+20 X@GUID+68 X@GUID+69 S@GUID+70 A@GUID+71 */

SET @GUID :=86939;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+71;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
-- 3 Packs
-- @POOL+1 E1 11372, 0, 0,@GUID+0 11371, 0, 0,@GUID+1 11371, 11372, 0,@GUID+2
(@GUID+0, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+1, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+2, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+2 E1 11372, 0, 0,@GUID+3 11371, 11372, 0,@GUID+4 11371, 0, 0,@GUID+5 
(@GUID+3, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+4, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+5, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+3 E1 11371, 0, 0,@GUID+6 11372, 0, 0,@GUID+7 11371, 11372, 0,@GUID+8 
(@GUID+6, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+7, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+8, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+4 E1 11371, 0, 0,@GUID+9 11371, 11372, 0,@GUID+10 11372, 0, 0,@GUID+11 
(@GUID+9, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+10, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+11, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+5 11372, 0, 0,@GUID+12 E2 11371, 0, 0,@GUID+13 11371, 11372, 0,@GUID+14
(@GUID+12, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+13, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+14, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+6 11372, 0, 0,@GUID+15 E2 11371, 11372, 0,@GUID+16 11371, 0, 0,@GUID+17
(@GUID+15, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+16, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+17, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+7 11371, 0, 0,@GUID+18 E2 11372, 0, 0,@GUID+19 11371, 11372, 0,@GUID+20
(@GUID+18, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+19, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+20, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+8 11371, 0, 0,@GUID+21 E2 11371, 11372, 0,@GUID+22 11372, 0, 0,@GUID+23
(@GUID+21, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+22, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+23, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- 4 Packs
-- @POOL+9 11372, 0, 0,@GUID+24 11371, 0, 0,@GUID+25 11371, 11372, 0,@GUID+26 11371, 11372, 0,@GUID+27
(@GUID+24, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+25, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+26, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+27, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+10 11372, 0, 0,@GUID+28 11371, 11372, 0,@GUID+29 11371, 0, 0,@GUID+30 11371, 11372, 0,@GUID+31
(@GUID+28, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+29, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+30, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+31, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+11 11372, 0, 0,@GUID+32 11371, 11372, 0,@GUID+33 11371, 11372, 0,@GUID+34 11371, 0, 0,@GUID+35
(@GUID+32, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+33, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+34, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+35, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+12 11371, 0, 0,@GUID+36 11372, 0, 0,@GUID+37 11371, 11372, 0,@GUID+38 11371, 11372, 0,@GUID+39
(@GUID+36, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+37, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+38, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+39, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+13 11371, 0, 0,@GUID+40 11371, 11372, 0,@GUID+41 11372, 0, 0,@GUID+42 11371, 11372, 0,@GUID+43
(@GUID+40, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+41, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+42, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+43, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+14 11371, 0, 0,@GUID+44 11371, 11372, 0,@GUID+45 11371, 11372, 0,@GUID+46 11372, 0, 0,@GUID+47
(@GUID+44, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+45, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+46, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+47, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+15 11371, 11372, 0,@GUID+48 11372, 0, 0,@GUID+49 11371, 0, 0,@GUID+50 11371, 11372, 0,@GUID+51
(@GUID+48, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+49, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+50, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+51, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+16 11371, 11372, 0,@GUID+52 11372, 0, 0,@GUID+53 11371, 11372, 0,@GUID+54 11371, 0, 0,@GUID+55
(@GUID+52, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+53, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+54, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+55, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+17 11371, 11372, 0,@GUID+56 11371, 0, 0,@GUID+57 11372, 0, 0,@GUID+58 11371, 11372, 0,@GUID+59
(@GUID+56, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+57, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+58, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+59, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+18 11371, 11372, 0,@GUID+60 11371, 0, 0,@GUID+61 11371, 11372, 0,@GUID+62 11372, 0, 0,@GUID+63
(@GUID+60, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+61, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+62, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+63, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+19 11371, 11372, 0,@GUID+64 11371, 11372, 0,@GUID+65 11372, 0, 0,@GUID+66 11371, 0, 0,@GUID+67
(@GUID+64, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+65, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+66, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+67, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 4
-- @POOL+20 11371, 11372, 0,@GUID+68 11371, 11372, 0,@GUID+69 11371, 0, 0,@GUID+70 11372, 0, 0,@GUID+71
(@GUID+68, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11884.3, -1379.01, 66.4316, 3.36848, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 1 
(@GUID+69, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11896.4, -1365.13, 69.8727, 2.42601, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 2
(@GUID+70, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11885, -1368.42, 68.8007, 5.53269, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0), -- 3
(@GUID+71, 11372, 0, 0, 309, 0, 0, 1, 1, 0, -11878.2, -1368.68, 69.7661, 3.90954, 7200, 3, 0, 15260, 0, 1, 0, 0, 0, '', 0); -- 4

SET @POOL :=448;
DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL+0 AND @POOL+20;
DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+71;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0, 1, 'ZG Entrance Snake 3-4 Pack Pool of Pools'),
(@POOL+1, 3, 'ZG Entrance Snake as 3 Pack 1/8'),
(@POOL+2, 3, 'ZG Entrance Snake as 3 Pack 2/8'),
(@POOL+3, 3, 'ZG Entrance Snake as 3 Pack 3/8'),
(@POOL+4, 3, 'ZG Entrance Snake as 3 Pack 4/8'),
(@POOL+5, 3, 'ZG Entrance Snake as 3 Pack 5/8'),
(@POOL+6, 3, 'ZG Entrance Snake as 3 Pack 6/8'),
(@POOL+7, 3, 'ZG Entrance Snake as 3 Pack 7/8'),
(@POOL+8, 3, 'ZG Entrance Snake as 3 Pack 8/8'),
(@POOL+9, 4, 'ZG Entrance Snake as 4 Pack 1/12'),
(@POOL+10, 4, 'ZG Entrance Snake as 4 Pack 2/12'),
(@POOL+11, 4, 'ZG Entrance Snake as 4 Pack 3/12'),
(@POOL+12, 4, 'ZG Entrance Snake as 4 Pack 4/12'),
(@POOL+13, 4, 'ZG Entrance Snake as 4 Pack 5/12'),
(@POOL+14, 4, 'ZG Entrance Snake as 4 Pack 6/12'),
(@POOL+15, 4, 'ZG Entrance Snake as 4 Pack 7/12'),
(@POOL+16, 4, 'ZG Entrance Snake as 4 Pack 8/12'),
(@POOL+17, 4, 'ZG Entrance Snake as 4 Pack 9/12'),
(@POOL+18, 4, 'ZG Entrance Snake as 4 Pack 10/12'),
(@POOL+19, 4, 'ZG Entrance Snake as 4 Pack 11/12'),
(@POOL+20, 4, 'ZG Entrance Snake as 4 Pack 12/12');

DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN @POOL+0 AND @POOL+20;
DELETE FROM `pool_pool` WHERE `mother_pool` BETWEEN @POOL+0 AND @POOL+20;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES 
(@POOL+1, @POOL+0, 6, 'ZG Entrance Snake as 3 Pack 1/8'),
(@POOL+2, @POOL+0, 6, 'ZG Entrance Snake as 3 Pack 2/8'),
(@POOL+3, @POOL+0, 6, 'ZG Entrance Snake as 3 Pack 3/8'),
(@POOL+4, @POOL+0, 7, 'ZG Entrance Snake as 3 Pack 4/8'),
(@POOL+5, @POOL+0, 6, 'ZG Entrance Snake as 3 Pack 5/8'),
(@POOL+6, @POOL+0, 6, 'ZG Entrance Snake as 3 Pack 6/8'),
(@POOL+7, @POOL+0, 6, 'ZG Entrance Snake as 3 Pack 7/8'),
(@POOL+8, @POOL+0, 7, 'ZG Entrance Snake as 3 Pack 8/8'),
(@POOL+9, @POOL+0, 5, 'ZG Entrance Snake as 4 Pack 1/12'),
(@POOL+10, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 2/12'),
(@POOL+11, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 3/12'),
(@POOL+12, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 4/12'),
(@POOL+13, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 5/12'),
(@POOL+14, @POOL+0, 5, 'ZG Entrance Snake as 4 Pack 6/12'),
(@POOL+15, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 7/12'),
(@POOL+16, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 8/12'),
(@POOL+17, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 9/12'),
(@POOL+18, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 10/12'),
(@POOL+19, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 11/12'),
(@POOL+20, @POOL+0, 4, 'ZG Entrance Snake as 4 Pack 12/12');

INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
-- @POOL+1 E1 A@GUID+0 S@GUID+1 X@GUID+2
(@GUID+0, @POOL+1, 'ZG Entrance Snake as 3 Pack 1/8 Adder'),
(@GUID+1, @POOL+1, 'ZG Entrance Snake as 3 Pack 1/8 Serpent'),
(@GUID+2, @POOL+1, 'ZG Entrance Snake as 3 Pack 1/8 Xsnake'),
-- @POOL+2 E1 A@GUID+3 X@GUID+4 S@GUID+5
(@GUID+3, @POOL+2, 'ZG Entrance Snake as 3 Pack 2/8 Adder'),
(@GUID+4, @POOL+2, 'ZG Entrance Snake as 3 Pack 2/8 Xsnake'),
(@GUID+5, @POOL+2, 'ZG Entrance Snake as 3 Pack 2/8 Serpent'),
-- @POOL+3 E1 S@GUID+6 A@GUID+7 X@GUID+8
(@GUID+6, @POOL+3, 'ZG Entrance Snake as 3 Pack 3/8 Serpent'),
(@GUID+7, @POOL+3, 'ZG Entrance Snake as 3 Pack 3/8 Adder'),
(@GUID+8, @POOL+3, 'ZG Entrance Snake as 3 Pack 3/8 Xsnake'),
-- @POOL+4 E1 S@GUID+9 X@GUID+10 A@GUID+11
(@GUID+9, @POOL+4, 'ZG Entrance Snake as 3 Pack 4/8 Serpent'),
(@GUID+10, @POOL+4, 'ZG Entrance Snake as 3 Pack 4/8 Xsnake'),
(@GUID+11, @POOL+4, 'ZG Entrance Snake as 3 Pack 4/8 Adder'),
-- @POOL+5 A@GUID+12 E2 S@GUID+13 X@GUID+14
(@GUID+12, @POOL+5, 'ZG Entrance Snake as 3 Pack 5/8 Adder'),
(@GUID+13, @POOL+5, 'ZG Entrance Snake as 3 Pack 5/8 Serpent'),
(@GUID+14, @POOL+5, 'ZG Entrance Snake as 3 Pack 5/8 Xsnake'),
-- @POOL+6 A@GUID+15 E2 X@GUID+16 S@GUID+17
(@GUID+15, @POOL+6, 'ZG Entrance Snake as 3 Pack 6/8 Adder'),
(@GUID+16, @POOL+6, 'ZG Entrance Snake as 3 Pack 6/8 Xsnake'),
(@GUID+17, @POOL+6, 'ZG Entrance Snake as 3 Pack 6/8 Serpent'),
-- @POOL+7 S@GUID+18 E2 A@GUID+19 X@GUID+20
(@GUID+18, @POOL+7, 'ZG Entrance Snake as 3 Pack 7/8 Serpent'),
(@GUID+19, @POOL+7, 'ZG Entrance Snake as 3 Pack 7/8 Adder'),
(@GUID+20, @POOL+7, 'ZG Entrance Snake as 3 Pack 7/8 Xsnake'),
-- @POOL+8 S@GUID+21 E2 X@GUID+22 A@GUID+23
(@GUID+21, @POOL+8, 'ZG Entrance Snake as 3 Pack 8/8 Serpent'),
(@GUID+22, @POOL+8, 'ZG Entrance Snake as 3 Pack 8/8 Xsnake'),
(@GUID+23, @POOL+8, 'ZG Entrance Snake as 3 Pack 8/8 Adder'),
-- @POOL+9 A@GUID+24 S@GUID+25 X@GUID+26 X@GUID+27
(@GUID+24, @POOL+9, 'ZG Entrance Snake as 4 Pack 1/12 Adder'),
(@GUID+25, @POOL+9, 'ZG Entrance Snake as 4 Pack 1/12 Serpent'),
(@GUID+26, @POOL+9, 'ZG Entrance Snake as 4 Pack 1/12 Xsnake'),
(@GUID+27, @POOL+9, 'ZG Entrance Snake as 4 Pack 1/12 Xsnake'),
-- @POOL+10 A@GUID+28 X@GUID+29 S@GUID+30 X@GUID+31
(@GUID+28, @POOL+10, 'ZG Entrance Snake as 4 Pack 2/12 Adder'),
(@GUID+29, @POOL+10, 'ZG Entrance Snake as 4 Pack 2/12 Xsnake'),
(@GUID+30, @POOL+10, 'ZG Entrance Snake as 4 Pack 2/12 Serpent'),
(@GUID+31, @POOL+10, 'ZG Entrance Snake as 4 Pack 2/12 Xsnake'),
-- @POOL+11 A@GUID+32 X@GUID+33 X@GUID+34 S@GUID+35
(@GUID+32, @POOL+11, 'ZG Entrance Snake as 4 Pack 3/12 Adder'),
(@GUID+33, @POOL+11, 'ZG Entrance Snake as 4 Pack 3/12 Xsnake'),
(@GUID+34, @POOL+11, 'ZG Entrance Snake as 4 Pack 3/12 Xsnake'),
(@GUID+35, @POOL+11, 'ZG Entrance Snake as 4 Pack 3/12 Serpent'),
-- @POOL+12 S@GUID+36 A@GUID+37 X@GUID+38 X@GUID+39
(@GUID+36, @POOL+12, 'ZG Entrance Snake as 4 Pack 4/12 Serpent'),
(@GUID+37, @POOL+12, 'ZG Entrance Snake as 4 Pack 4/12 Adder'),
(@GUID+38, @POOL+12, 'ZG Entrance Snake as 4 Pack 4/12 Xsnake'),
(@GUID+39, @POOL+12, 'ZG Entrance Snake as 4 Pack 4/12 Xsnake'),
-- @POOL+13 S@GUID+40 X@GUID+41 A@GUID+42 X@GUID+43
(@GUID+40, @POOL+13, 'ZG Entrance Snake as 4 Pack 5/12 Serpent'),
(@GUID+41, @POOL+13, 'ZG Entrance Snake as 4 Pack 5/12 Xsnake'),
(@GUID+42, @POOL+13, 'ZG Entrance Snake as 4 Pack 5/12 Adder'),
(@GUID+43, @POOL+13, 'ZG Entrance Snake as 4 Pack 5/12 Xsnake'),
-- @POOL+14 S@GUID+44 X@GUID+45 X@GUID+46 A@GUID+47
(@GUID+44, @POOL+14, 'ZG Entrance Snake as 4 Pack 6/12 Serpent'),
(@GUID+45, @POOL+14, 'ZG Entrance Snake as 4 Pack 6/12 Xsnake'),
(@GUID+46, @POOL+14, 'ZG Entrance Snake as 4 Pack 6/12 Xsnake'),
(@GUID+47, @POOL+14, 'ZG Entrance Snake as 4 Pack 6/12 Adder'),
-- @POOL+15 X@GUID+48 A@GUID+49 S@GUID+50 X@GUID+51
(@GUID+48, @POOL+15, 'ZG Entrance Snake as 4 Pack 7/12 Xsnake'),
(@GUID+49, @POOL+15, 'ZG Entrance Snake as 4 Pack 7/12 Adder'),
(@GUID+50, @POOL+15, 'ZG Entrance Snake as 4 Pack 7/12 Serpent'),
(@GUID+51, @POOL+15, 'ZG Entrance Snake as 4 Pack 7/12 Xsnake'),
-- @POOL+16 X@GUID+52 A@GUID+53 X@GUID+54 S@GUID+55
(@GUID+52, @POOL+16, 'ZG Entrance Snake as 4 Pack 8/12 Xsnake'),
(@GUID+53, @POOL+16, 'ZG Entrance Snake as 4 Pack 8/12 Adder'),
(@GUID+54, @POOL+16, 'ZG Entrance Snake as 4 Pack 8/12 Xsnake'),
(@GUID+55, @POOL+16, 'ZG Entrance Snake as 4 Pack 8/12 Serpent'),
-- @POOL+17 X@GUID+56 S@GUID+57 A@GUID+58 X@GUID+59
(@GUID+56, @POOL+17, 'ZG Entrance Snake as 4 Pack 9/12 Xsnake'),
(@GUID+57, @POOL+17, 'ZG Entrance Snake as 4 Pack 9/12 Serpent'),
(@GUID+58, @POOL+17, 'ZG Entrance Snake as 4 Pack 9/12 Adder'),
(@GUID+59, @POOL+17, 'ZG Entrance Snake as 4 Pack 9/12 Xsnake'),
-- @POOL+18 X@GUID+60 S@GUID+61 X@GUID+62 A@GUID+63
(@GUID+60, @POOL+18, 'ZG Entrance Snake as 4 Pack 10/12 Xsnake'),
(@GUID+61, @POOL+18, 'ZG Entrance Snake as 4 Pack 10/12 Serpent'),
(@GUID+62, @POOL+18, 'ZG Entrance Snake as 4 Pack 10/12 Xsnake'),
(@GUID+63, @POOL+18, 'ZG Entrance Snake as 4 Pack 10/12 Adder'),
-- @POOL+19 X@GUID+64 X@GUID+65 A@GUID+66 S@GUID+67
(@GUID+64, @POOL+19, 'ZG Entrance Snake as 4 Pack 11/12 Xsnake'),
(@GUID+65, @POOL+19, 'ZG Entrance Snake as 4 Pack 11/12 Xsnake'),
(@GUID+66, @POOL+19, 'ZG Entrance Snake as 4 Pack 11/12 Adder'),
(@GUID+67, @POOL+19, 'ZG Entrance Snake as 4 Pack 11/12 Serpent'),
-- @POOL+20 X@GUID+68 X@GUID+69 S@GUID+70 A@GUID+71
(@GUID+68, @POOL+20, 'ZG Entrance Snake as 4 Pack 12/12 Xsnake'),
(@GUID+69, @POOL+20, 'ZG Entrance Snake as 4 Pack 12/12 Xsnake'),
(@GUID+70, @POOL+20, 'ZG Entrance Snake as 4 Pack 12/12 Serpent'),
(@GUID+71, @POOL+20, 'ZG Entrance Snake as 4 Pack 12/12 Adder');
