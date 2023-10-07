--
DELETE FROM `pool_template` WHERE `entry`=11699;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (11699, 1, 'Truesilver Vein - Desolace');

DELETE FROM `pool_gameobject` WHERE `guid` IN (9256,9257,9258);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9256, 11699, 0, 'Truesilver Vein 1 - Desolace'),
(9257, 11699, 0, 'Truesilver Vein 2 - Desolace'),
(9258, 11699, 0, 'Truesilver Vein 3 - Desolace');
