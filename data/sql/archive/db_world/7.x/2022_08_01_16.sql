-- DB update 2022_08_01_15 -> 2022_08_01_16
--
-- Maintenance on ZG Before Bats Part 3:  Pooling Part 2 Troll Pack before Bat Area
-- Formations shouldn't be needed on this pack (they agro properly without) 

-- Pool Troll pack before Bat area (49120, 49121, 49122) with it's counterpart, (created as 12814, 12815, 12816) 
DELETE FROM `creature` WHERE `guid` BETWEEN 12814 AND 12816;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(12814, 11831, 0, 0, 309, 0, 0, 1, 1, 1, -12007.2, -1492.45, 82.0241, 1.39626, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(12815, 11831, 0, 0, 309, 0, 0, 1, 1, 1, -12008.5, -1484.79, 79.1498, 4.87654, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(12816, 11351, 0, 0, 309, 0, 0, 1, 1, 1, -12004.5, -1483.46, 79.5746, 4.71553, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `pool_template` WHERE `entry` BETWEEN 476 AND 478;
DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN 476 AND 478;
DELETE FROM `pool_pool` WHERE `mother_pool` BETWEEN 476 AND 478;
DELETE FROM `pool_creature` WHERE `pool_entry` BETWEEN 476 AND 478;
DELETE FROM `pool_creature` WHERE `guid` IN (49120, 49121, 49122, 12814, 12815, 12816);


INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(476, 1, 'ZG Before Bats Troll 3-Pack'),
(477, 3, 'ZG Before Bats Troll 3-Pack with 2x entry 11831 50% 1/2'),
(478, 3, 'ZG Before Bats Troll 3-Pack with 2x entry 11351 50% 2/2');

INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES 
(477, 476, 50, 'ZG Before Bats Troll 3-Pack with 2x entry 11831'),
(478, 476, 50, 'ZG Before Bats Troll 3-Pack with 2x entry 11351');

INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
(12814, 477, 'ZG Before Bats Troll 3-Pack entry 11831'),
(12815, 477, 'ZG Before Bats Troll 3-Pack entry 11831'),
(12816, 477, 'ZG Before Bats Troll 3-Pack entry 11351'),

(49120, 478, 'ZG Before Bats Troll 3-Pack entry 11351'),
(49121, 478, 'ZG Before Bats Troll 3-Pack entry 11351'),
(49122, 478, 'ZG Before Bats Troll 3-Pack entry 11831');
