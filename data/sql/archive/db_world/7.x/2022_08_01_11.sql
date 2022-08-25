-- DB update 2022_08_01_10 -> 2022_08_01_11
--
-- Maintenance on ZG Before Bats Part 4:  Pooling Part 3 Standing Bats Pack
-- Old Locations Pre-work
DELETE FROM `creature` WHERE `guid` IN (49190, 49191, 49192, 49193);
DELETE FROM `creature_addon` WHERE `guid` IN (49190, 49191, 49192, 49193);

/* Bat Pack in ZG Bat Rider (14750) should shift spawn positions with 11368 and they agro together as one

INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(@GUID+, , 0, 0, 309, 0, 0, 1, 1, 0, -11985.9, -1475.85, 79.7788, 1.59486, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+, , 0, 0, 309, 0, 0, 1, 1, 0, -11978.2, -1464.7, 80.1628, 1.46608, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+, , 0, 0, 309, 0, 0, 1, 1, 0, -11988.6, -1467.06, 80.3768, 1.98968, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+, , 0, 0, 309, 0, 0, 1, 1, 0, -11981.1, -1475.36, 79.7364, 0.874606, 7200, 2, 0, 31440, 0, 1, 0, 0, 0, '', 0);

This ZG Bat Rider had a row in creautre_addon--I could not find it anywhere in the sniff so it is not included, however noting it here for historical purposes:

INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES 
(XRIDERX, 0, 0, 0, 4097, 0, 0, NULL);

*/

-- Setup and auto-cleanup for pooling, creatures, and formations
SET @GUID :=56934;
SET @POOL :=479;
DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL+0 AND @POOL+4;
DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+15;
DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN @POOL+0 AND @POOL+4;
DELETE FROM `pool_pool` WHERE `mother_pool` BETWEEN @POOL+0 AND @POOL+4;
DELETE FROM `creature_formations` WHERE `memberGUID` BETWEEN @GUID+0 AND @GUID+15;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+15;

-- Insert Creatures
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -11985.9, -1475.85, 79.7788, 1.59486, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+1, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11978.2, -1464.7, 80.1628, 1.46608, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+2, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11988.6, -1467.06, 80.3768, 1.98968, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+3, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11981.1, -1475.36, 79.7364, 0.874606, 7200, 2, 0, 31440, 0, 1, 0, 0, 0, '', 0),

(@GUID+4, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11985.9, -1475.85, 79.7788, 1.59486, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+5, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -11978.2, -1464.7, 80.1628, 1.46608, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+6, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11988.6, -1467.06, 80.3768, 1.98968, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+7, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11981.1, -1475.36, 79.7364, 0.874606, 7200, 2, 0, 31440, 0, 1, 0, 0, 0, '', 0),

(@GUID+8, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11985.9, -1475.85, 79.7788, 1.59486, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+9, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11978.2, -1464.7, 80.1628, 1.46608, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+10, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -11988.6, -1467.06, 80.3768, 1.98968, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+11, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11981.1, -1475.36, 79.7364, 0.874606, 7200, 2, 0, 31440, 0, 1, 0, 0, 0, '', 0),

(@GUID+12, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11985.9, -1475.85, 79.7788, 1.59486, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+13, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11978.2, -1464.7, 80.1628, 1.46608, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+14, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -11988.6, -1467.06, 80.3768, 1.98968, 7200, 2, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(@GUID+15, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -11981.1, -1475.36, 79.7364, 0.874606, 7200, 2, 0, 31440, 0, 1, 0, 0, 0, '', 0);

-- Insert Pooling 

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0, 1, 'ZG Before Bats Bat Pack Rider Location Shuffle'),
(@POOL+1, 4, 'ZG Before Bats Bat Pack Loc 1/4'),
(@POOL+2, 4, 'ZG Before Bats Bat Pack Loc 2/4'),
(@POOL+3, 4, 'ZG Before Bats Bat Pack Loc 3/4'),
(@POOL+4, 4, 'ZG Before Bats Bat Pack Loc 4/4');

INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES 
(@POOL+1, @POOL+0, 25, 'ZG Before Bats Bat Pack Loc 1'),
(@POOL+2, @POOL+0, 25, 'ZG Before Bats Bat Pack Loc 2'),
(@POOL+3, @POOL+0, 25, 'ZG Before Bats Bat Pack Loc 3'),
(@POOL+4, @POOL+0, 25, 'ZG Before Bats Bat Pack Loc 4');

INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES

(@GUID+0, @POOL+1, 'ZG Before Bats Bat Pack Loc 1 Rider'),
(@GUID+1, @POOL+1, 'ZG Before Bats Bat Pack Loc 1 Bat'),
(@GUID+2, @POOL+1, 'ZG Before Bats Bat Pack Loc 1 Bat'),
(@GUID+3, @POOL+1, 'ZG Before Bats Bat Pack Loc 1 Bat'),

(@GUID+4, @POOL+2, 'ZG Before Bats Bat Pack Loc 2 Bat'),
(@GUID+5, @POOL+2, 'ZG Before Bats Bat Pack Loc 2 Rider'),
(@GUID+6, @POOL+2, 'ZG Before Bats Bat Pack Loc 2 Bat'),
(@GUID+7, @POOL+2, 'ZG Before Bats Bat Pack Loc 2 Bat'),

(@GUID+8, @POOL+3, 'ZG Before Bats Bat Pack Loc 3 Bat'),
(@GUID+9, @POOL+3, 'ZG Before Bats Bat Pack Loc 3 Bat'),
(@GUID+10, @POOL+3, 'ZG Before Bats Bat Pack Loc 3 Rider'),
(@GUID+11, @POOL+3, 'ZG Before Bats Bat Pack Loc 3 Bat'),

(@GUID+12, @POOL+4, 'ZG Before Bats Bat Pack Loc 4 Bat'),
(@GUID+13, @POOL+4, 'ZG Before Bats Bat Pack Loc 4 Bat'),
(@GUID+14, @POOL+4, 'ZG Before Bats Bat Pack Loc 4 Bat'),
(@GUID+15, @POOL+4, 'ZG Before Bats Bat Pack Loc 4 Rider');

-- Insert Formations

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(@GUID+0, @GUID+0, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+1, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+2, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+3, 0, 0, 3, 0, 0),

(@GUID+4, @GUID+4, 0, 0, 3, 0, 0),
(@GUID+4, @GUID+5, 0, 0, 3, 0, 0),
(@GUID+4, @GUID+6, 0, 0, 3, 0, 0),
(@GUID+4, @GUID+7, 0, 0, 3, 0, 0),

(@GUID+8, @GUID+8, 0, 0, 3, 0, 0),
(@GUID+8, @GUID+9, 0, 0, 3, 0, 0),
(@GUID+8, @GUID+10, 0, 0, 3, 0, 0),
(@GUID+8, @GUID+11, 0, 0, 3, 0, 0),

(@GUID+12, @GUID+12, 0, 0, 3, 0, 0),
(@GUID+12, @GUID+13, 0, 0, 3, 0, 0),
(@GUID+12, @GUID+14, 0, 0, 3, 0, 0),
(@GUID+12, @GUID+15, 0, 0, 3, 0, 0);

-- Maintenance on ZG Before Bats Part 5: Agro linking via creature_formations
DELETE FROM `creature_formations` WHERE `memberGUID` IN (49753, 49754, 49096, 49097);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(49753, 49753, 0, 0, 3, 0, 0),
(49753, 49754, 0, 0, 3, 0, 0),
(49753, 49096, 0, 0, 3, 0, 0),
(49753, 49097, 0, 0, 3, 0, 0);
