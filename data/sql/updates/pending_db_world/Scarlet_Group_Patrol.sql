
DELETE FROM `creature_formations` WHERE `leaderGUID` = 128736;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(128736, 128736, 0, 0, 515, 0, 0),
(128736, 128705, 4, 90, 515, 0, 0),
(128736, 128706, 4, 180, 515, 0, 0),
(128736, 128707, 4, 270, 515, 0, 0),
(128736, 128708, 4, 112.5, 515, 0, 0),
(128736, 128709, 4, 135, 515, 0, 0),
(128736, 128710, 4, 157.5, 515, 0, 0),
(128736, 128711, 4, 202.5, 515, 0, 0),
(128736, 128712, 4, 225, 515, 0, 0),
(128736, 128713, 4, 247.5, 515, 0, 0);


DELETE FROM `waypoint_data` WHERE `id` = 12873600;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12873600, 1, 1544.95, -5795.18, 120.667, NULL, 0, 0, 0, 100, 0),
(12873600, 2, 1522.59, -5795.45, 129.724, NULL, 0, 0, 0, 100, 0),
(12873600, 3, 1484.63, -5807.62, 131.214, NULL, 0, 0, 0, 100, 0),
(12873600, 4, 1492.49, -5851.44, 131.213, NULL, 0, 0, 0, 100, 0),
(12873600, 5, 1498.15, -5872.21, 131.225, NULL, 0, 0, 0, 100, 0),
(12873600, 6, 1527.43, -5892.07, 129.977, NULL, 0, 0, 0, 100, 0),
(12873600, 7, 1566.22, -5898.54, 122.884, NULL, 0, 0, 0, 100, 0),
(12873600, 8, 1598.12, -5909.41, 116.52, NULL, 0, 0, 0, 100, 0),
(12873600, 9, 1637.11, -5913.14, 116.275, NULL, 0, 0, 0, 100, 0),
(12873600, 10, 1650.59, -5913.4, 116.919, NULL, 0, 0, 0, 100, 0),
(12873600, 11, 1654.76, -5902.66, 116.139, NULL, 0, 0, 0, 100, 0),
(12873600, 12, 1694.49, -5881.2, 116.138, NULL, 0, 0, 0, 100, 0),
(12873600, 13, 1733.43, -5907.17, 116.13, NULL, 0, 0, 0, 100, 0),
(12873600, 14, 1802.39, -5935.09, 115.84, NULL, 0, 0, 0, 100, 0),
(12873600, 15, 1830.96, -5925.82, 110.366, NULL, 0, 0, 0, 100, 0),
(12873600, 16, 1853.76, -5918.6, 105.046, NULL, 0, 0, 0, 100, 0),
(12873600, 17, 1879.17, -5911.24, 103.938, NULL, 0, 0, 0, 100, 0),
(12873600, 18, 1895.67, -5879.18, 101.68, NULL, 0, 0, 0, 100, 0),
(12873600, 19, 1895.8, -5843.01, 101.117, NULL, 0, 0, 0, 100, 0),
(12873600, 20, 1870.93, -5831.12, 101.044, NULL, 0, 0, 0, 100, 0),
(12873600, 21, 1859.37, -5818.12, 100.012, NULL, 0, 0, 0, 100, 0),
(12873600, 22, 1827.84, -5817.97, 102.027, NULL, 0, 0, 0, 100, 0),
(12873600, 23, 1802.23, -5817.88, 108.723, NULL, 0, 0, 0, 100, 0),
(12873600, 24, 1780.31, -5818.1, 114.565, NULL, 0, 0, 0, 100, 0),
(12873600, 25, 1759.2, -5819, 116.116, NULL, 0, 0, 0, 100, 0),
(12873600, 26, 1729.87, -5820.43, 116.125, NULL, 0, 0, 0, 100, 0),
(12873600, 27, 1719.68, -5804.49, 116.845, NULL, 0, 0, 0, 100, 0),
(12873600, 28, 1698.36, -5784.1, 113.976, NULL, 0, 0, 0, 100, 0),
(12873600, 29, 1673.47, -5780.68, 115.893, NULL, 0, 0, 0, 100, 0),
(12873600, 30, 1645.65, -5779.68, 116.155, NULL, 0, 0, 0, 100, 0),
(12873600, 31, 1605.2, -5779.08, 116.113, NULL, 0, 0, 0, 100, 0),
(12873600, 32, 1572.25, -5783.7, 118.883, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` = 12873500;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12873500, 1, 1773.9238, -5832.1016, 116.31873, NULL, 0, 0, 0, 100, 0),
(12873500, 2, 1756.1492, -5834.704, 116.430405, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` = 12873700;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12873700, 1, 1783.6888, -5806.3467, 114.37271, NULL, 0, 0, 0, 100, 0),
(12873700, 2, 1765.1584, -5808.4717, 116.48846, NULL, 0, 0, 0, 100, 0);


UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = 128736 AND `id1` = 28530;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128705 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128706 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128707 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128708 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128709 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128710 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128711 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128712 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 0, `wander_distance` = 0 WHERE `guid` = 128713 AND `id1` = 28529;
UPDATE `creature` SET `MovementType`= 2, `position_x`= 1756.1492, `position_y`= -5834.704, `position_z`= 116.430405 WHERE `guid` = 128735 AND `id1` = 28530;
UPDATE `creature` SET `MovementType`= 2, `position_x`= 1765.1584, `position_y`= -5808.4717, `position_z`= 116.48846 WHERE `guid` = 128737 AND `id1` = 28530;


DELETE FROM `creature_addon` WHERE (`guid` IN (128735));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(128735, 12873500, 2404, 0, 0, 0, 0, NULL);

DELETE FROM `creature_addon` WHERE (`guid` IN (128736));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(128736, 12873600, 2404, 0, 0, 0, 0, NULL);

DELETE FROM `creature_addon` WHERE (`guid` IN (128737));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(128737, 12873700, 2404, 0, 0, 0, 0, NULL);
