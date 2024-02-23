-- DB update 2023_03_09_03 -> 2023_03_09_04
--
UPDATE `creature` SET `spawntimesecs`=900, `wander_distance`=10, `MovementType`=1 WHERE `id1`=23008;

DELETE FROM `pool_template` WHERE `entry`=109 AND `description`='Ethereum Jailor (23008)';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(109, 2, 'Ethereum Jailor (23008)');

DELETE FROM `pool_creature` WHERE `pool_entry`=109 AND `description`='Ethereum Jailor (23008)';
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(1975937, 109, 0, 'Ethereum Jailor (23008)'),
(1975938, 109, 0, 'Ethereum Jailor (23008)'),
(1975939, 109, 0, 'Ethereum Jailor (23008)'),
(1975940, 109, 0, 'Ethereum Jailor (23008)'),
(1975941, 109, 0, 'Ethereum Jailor (23008)'),
(1975942, 109, 0, 'Ethereum Jailor (23008)'),
(1975943, 109, 0, 'Ethereum Jailor (23008)'),
(1975944, 109, 0, 'Ethereum Jailor (23008)'),
(1975945, 109, 0, 'Ethereum Jailor (23008)'),
(1975946, 109, 0, 'Ethereum Jailor (23008)'),
(1975947, 109, 0, 'Ethereum Jailor (23008)'),
(1975948, 109, 0, 'Ethereum Jailor (23008)'),
(1975949, 109, 0, 'Ethereum Jailor (23008)'),
(1975950, 109, 0, 'Ethereum Jailor (23008)'),
(1975951, 109, 0, 'Ethereum Jailor (23008)'),
(1975952, 109, 0, 'Ethereum Jailor (23008)'),
(1975953, 109, 0, 'Ethereum Jailor (23008)'),
(1975954, 109, 0, 'Ethereum Jailor (23008)'),
(1975955, 109, 0, 'Ethereum Jailor (23008)'),
(1975956, 109, 0, 'Ethereum Jailor (23008)'),
(1975957, 109, 0, 'Ethereum Jailor (23008)');
