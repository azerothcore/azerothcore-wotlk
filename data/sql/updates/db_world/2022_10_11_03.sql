-- DB update 2022_10_11_02 -> 2022_10_11_03
--
DELETE FROM `pool_creature` WHERE `pool_entry`=1004 AND `guid` IN (33621, 34520);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
(33621, 1004, 'Spawn of Hakkar (5708) - Spawn 1'),
(34520, 1004, 'Spawn of Hakkar (5708) - Spawn 2');

DELETE FROM `pool_template` WHERE `entry`=1004;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(1004, 1, 'Spawn of Hakkar (5708)');
