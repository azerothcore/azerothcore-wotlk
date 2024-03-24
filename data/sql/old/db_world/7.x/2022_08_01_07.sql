-- DB update 2022_08_01_06 -> 2022_08_01_07
--
/* Maintenance on ZG Before Bats Part 2:  Pooling Part 1 */
DELETE FROM `creature` WHERE `guid` BETWEEN 91480 AND 91484;

/* Crocolisk Packs:  This method can be exported into all Crocolisk Packs, it requires 25 creature entries and 6 pools.
50% Chance to spawn 5, 10% chance for each location to spawn empty creating a 4 pack

INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(@GUID+, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903.1, -1490.94, 12.5739, 1.91973, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11895.3, -1503.19, 15.1803, 5.42918, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11892.8, -1498.98, 13.7794, 4.75143, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11912.7, -1494.4, 12.0913, 3.05153, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903, -1502.04, 14.7285, 0.400987, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
*/

SET @GUID :=61271;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+24;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
-- 5 Pack
(@GUID+0, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903.1, -1490.94, 12.5739, 1.91973, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+1, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11895.3, -1503.19, 15.1803, 5.42918, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+2, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11892.8, -1498.98, 13.7794, 4.75143, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+3, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11912.7, -1494.4, 12.0913, 3.05153, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+4, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903, -1502.04, 14.7285, 0.400987, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
-- 4 Pack Missing First
(@GUID+5, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11895.3, -1503.19, 15.1803, 5.42918, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+6, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11892.8, -1498.98, 13.7794, 4.75143, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+7, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11912.7, -1494.4, 12.0913, 3.05153, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+8, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903, -1502.04, 14.7285, 0.400987, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
-- 4 Pack Missing Second
(@GUID+9, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903.1, -1490.94, 12.5739, 1.91973, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+10, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11892.8, -1498.98, 13.7794, 4.75143, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+11, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11912.7, -1494.4, 12.0913, 3.05153, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+12, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903, -1502.04, 14.7285, 0.400987, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
-- 4 Pack Missing Third
(@GUID+13, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903.1, -1490.94, 12.5739, 1.91973, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+14, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11895.3, -1503.19, 15.1803, 5.42918, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+15, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11912.7, -1494.4, 12.0913, 3.05153, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+16, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903, -1502.04, 14.7285, 0.400987, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
-- 4 Pack Missing Fourth
(@GUID+17, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903.1, -1490.94, 12.5739, 1.91973, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+18, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11895.3, -1503.19, 15.1803, 5.42918, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+19, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11892.8, -1498.98, 13.7794, 4.75143, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+20, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903, -1502.04, 14.7285, 0.400987, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
-- 4 Pack Missing Final 
(@GUID+21, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11903.1, -1490.94, 12.5739, 1.91973, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+22, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11895.3, -1503.19, 15.1803, 5.42918, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+23, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11892.8, -1498.98, 13.7794, 4.75143, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0),
(@GUID+24, 15043, 0, 0, 309, 0, 0, 1, 1, 0, -11912.7, -1494.4, 12.0913, 3.05153, 7200, 0, 0, 9156, 0, 0, 0, 0, 0, '', 0);

SET @POOL :=469;
DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL+0 AND @POOL+6;
DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+24;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0, 1, 'ZG Before Bats 4-5 Pack Pool of Zulian Crocs Pool of Pools'),
(@POOL+1, 5, 'ZG Before Bats 5 Pack of Zulian Crocs 15043 50% 1/6'),
(@POOL+2, 4, 'ZG Before Bats 4 Pack of Zulian Crocs 15043 10% 2/6'),
(@POOL+3, 4, 'ZG Before Bats 4 Pack of Zulian Crocs 15043 10% 3/6'),
(@POOL+4, 4, 'ZG Before Bats 4 Pack of Zulian Crocs 15043 10% 4/6'),
(@POOL+5, 4, 'ZG Before Bats 4 Pack of Zulian Crocs 15043 10% 5/6'),
(@POOL+6, 4, 'ZG Before Bats 4 Pack of Zulian Crocs 15043 10% 6/6');

DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN @POOL+0 AND @POOL+6;
DELETE FROM `pool_pool` WHERE `mother_pool` BETWEEN @POOL+0 AND @POOL+6;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES 
(@POOL+1, @POOL+0, 50, 'ZG Before Bats 5 Pack of Zulian Crocs 1/1'),
(@POOL+2, @POOL+0, 10, 'ZG Before Bats 4 Pack of Zulian Crocs 1/5'),
(@POOL+3, @POOL+0, 10, 'ZG Before Bats 4 Pack of Zulian Crocs 2/5'),
(@POOL+4, @POOL+0, 10, 'ZG Before Bats 4 Pack of Zulian Crocs 3/5'),
(@POOL+5, @POOL+0, 10, 'ZG Before Bats 4 Pack of Zulian Crocs 4/5'),
(@POOL+6, @POOL+0, 10, 'ZG Before Bats 4 Pack of Zulian Crocs 5/5');

INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
--
(@GUID+0, @POOL+1, 'ZG Before Bats 5 Pack of Zulian Crocs 1/1 Croc 1'),
(@GUID+1, @POOL+1, 'ZG Before Bats 5 Pack of Zulian Crocs 1/1 Croc 2'),
(@GUID+2, @POOL+1, 'ZG Before Bats 5 Pack of Zulian Crocs 1/1 Croc 3'),
(@GUID+3, @POOL+1, 'ZG Before Bats 5 Pack of Zulian Crocs 1/1 Croc 4'),
(@GUID+4, @POOL+1, 'ZG Before Bats 5 Pack of Zulian Crocs 1/1 Croc 5'),
--
(@GUID+5, @POOL+2, 'ZG Before Bats 4 Pack of Zulian Crocs 1/5 Croc 1'),
(@GUID+6, @POOL+2, 'ZG Before Bats 4 Pack of Zulian Crocs 1/5 Croc 2'),
(@GUID+7, @POOL+2, 'ZG Before Bats 4 Pack of Zulian Crocs 1/5 Croc 3'),
(@GUID+8, @POOL+2, 'ZG Before Bats 4 Pack of Zulian Crocs 1/5 Croc 4'),
--
(@GUID+9, @POOL+3, 'ZG Before Bats 4 Pack of Zulian Crocs 2/5 Croc 1'),
(@GUID+10, @POOL+3, 'ZG Before Bats 4 Pack of Zulian Crocs 2/5 Croc 2'),
(@GUID+11, @POOL+3, 'ZG Before Bats 4 Pack of Zulian Crocs 2/5 Croc 3'),
(@GUID+12, @POOL+3, 'ZG Before Bats 4 Pack of Zulian Crocs 2/5 Croc 4'),
--
(@GUID+13, @POOL+4, 'ZG Before Bats 4 Pack of Zulian Crocs 3/5 Croc 1'),
(@GUID+14, @POOL+4, 'ZG Before Bats 4 Pack of Zulian Crocs 3/5 Croc 2'),
(@GUID+15, @POOL+4, 'ZG Before Bats 4 Pack of Zulian Crocs 3/5 Croc 3'),
(@GUID+16, @POOL+4, 'ZG Before Bats 4 Pack of Zulian Crocs 3/5 Croc 4'),
--
(@GUID+17, @POOL+5, 'ZG Before Bats 4 Pack of Zulian Crocs 4/5 Croc 1'),
(@GUID+18, @POOL+5, 'ZG Before Bats 4 Pack of Zulian Crocs 4/5 Croc 2'),
(@GUID+19, @POOL+5, 'ZG Before Bats 4 Pack of Zulian Crocs 4/5 Croc 3'),
(@GUID+20, @POOL+5, 'ZG Before Bats 4 Pack of Zulian Crocs 4/5 Croc 4'),
--
(@GUID+21, @POOL+6, 'ZG Before Bats 4 Pack of Zulian Crocs 5/5 Croc 1'),
(@GUID+22, @POOL+6, 'ZG Before Bats 4 Pack of Zulian Crocs 5/5 Croc 2'),
(@GUID+23, @POOL+6, 'ZG Before Bats 4 Pack of Zulian Crocs 5/5 Croc 3'),
(@GUID+24, @POOL+6, 'ZG Before Bats 4 Pack of Zulian Crocs 5/5 Croc 4');

DELETE FROM `creature_formations` WHERE `memberGUID` BETWEEN @GUID+0 AND @GUID+24;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(@GUID+0, @GUID+0, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+1, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+2, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+3, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+4, 0, 0, 3, 0, 0),
--
(@GUID+5, @GUID+5, 0, 0, 3, 0, 0),
(@GUID+5, @GUID+6, 0, 0, 3, 0, 0),
(@GUID+5, @GUID+7, 0, 0, 3, 0, 0),
(@GUID+5, @GUID+8, 0, 0, 3, 0, 0),
--
(@GUID+9, @GUID+9, 0, 0, 3, 0, 0),
(@GUID+9, @GUID+10, 0, 0, 3, 0, 0),
(@GUID+9, @GUID+11, 0, 0, 3, 0, 0),
(@GUID+9, @GUID+12, 0, 0, 3, 0, 0),
--
(@GUID+13, @GUID+13, 0, 0, 3, 0, 0),
(@GUID+13, @GUID+14, 0, 0, 3, 0, 0),
(@GUID+13, @GUID+15, 0, 0, 3, 0, 0),
(@GUID+13, @GUID+16, 0, 0, 3, 0, 0),
--
(@GUID+17, @GUID+17, 0, 0, 3, 0, 0),
(@GUID+17, @GUID+18, 0, 0, 3, 0, 0),
(@GUID+17, @GUID+19, 0, 0, 3, 0, 0),
(@GUID+17, @GUID+20, 0, 0, 3, 0, 0),
--
(@GUID+21, @GUID+21, 0, 0, 3, 0, 0),
(@GUID+21, @GUID+22, 0, 0, 3, 0, 0),
(@GUID+21, @GUID+23, 0, 0, 3, 0, 0),
(@GUID+21, @GUID+24, 0, 0, 3, 0, 0);
