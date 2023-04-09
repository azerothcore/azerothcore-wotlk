-- DB update 2022_09_06_09 -> 2022_09_06_10
-- Araga (14222)
DELETE FROM `creature_addon` WHERE (`guid` IN (17066));

DELETE FROM `creature` WHERE `guid` IN (17066, 23431, 23434);
INSERT INTO `creature` (`guid`, `id1`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `wander_distance`, `MovementType`) VALUES 
(17066, 14222, 153.893, -62.1832, 100.034, 4.13847, 95400, 1342, 50, 1),
(23431, 14222, -203.155, -308.609, 157.801, 0.395757, 95400, 1342, 50, 1),
(23434, 14222, -105.383, -85.8896, 139.728, 1.88409, 95400, 1342, 50, 1);

DELETE FROM `pool_template` WHERE `entry`=1108 AND `description`='Araga Rare Spawn';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1108, 1, 'Araga Rare Spawn');

DELETE FROM `pool_creature` WHERE `pool_entry`=1108 AND `guid` IN (17066, 23431, 23434);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
(17066, 1108, 'Araga (14222) Spawn 1'),
(23431, 1108, 'Araga (14222) Spawn 2'),
(23434, 1108, 'Araga (14222) Spawn 3');
