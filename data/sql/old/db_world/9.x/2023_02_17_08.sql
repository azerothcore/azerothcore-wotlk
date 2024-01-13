-- DB update 2023_02_17_07 -> 2023_02_17_08
--
DELETE FROM `creature` WHERE `id1`=16854;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(24908, 16854, 530, 1, 9402.33, -7926.69, 12.2609, 0.730068, 5400, 10, 1),
(24909, 16854, 530, 1, 9472.51, -7946.23, 11.6341, 1.48537, 7200, 10, 1),
(24910, 16854, 530, 1, 9580.48, -7874.78, 12.7841, 0.261714, 9000, 10, 1);

DELETE FROM `pool_template` WHERE `entry`=1113 AND `description`='Eldinarcus (16854)';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1113, 1, 'Eldinarcus (16854)');

DELETE FROM `pool_creature` WHERE `pool_entry`=1113 AND `description`='Eldinarcus (16854)';
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(24908, 1113, 0, 'Eldinarcus (16854)'),
(24909, 1113, 0, 'Eldinarcus (16854)'),
(24910, 1113, 0, 'Eldinarcus (16854)');
