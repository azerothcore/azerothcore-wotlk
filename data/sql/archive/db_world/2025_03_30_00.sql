-- DB update 2025_03_29_02 -> 2025_03_30_00

-- Add Waypoints for 5 Geists
DELETE FROM `waypoint_data` WHERE `id` IN (12849500);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12849500, 1, 2184.4453, -5686.0376, 110.50503, NULL, 0, 1, 0, 100, 0),
(12849500, 2, 2183.694, -5675.777, 112.766205, NULL, 0, 1, 0, 100, 0),
(12849500, 3, 2202.3655, -5652.9795, 121.745995, NULL, 0, 1, 0, 100, 0),
(12849500, 4, 2235.4866, -5637.494, 133.76904, NULL, 0, 1, 0, 100, 0),
(12849500, 5, 2264.2124, -5630.3135, 143.5095, NULL, 0, 1, 0, 100, 0),
(12849500, 6, 2280.0022, -5644.066, 143.87833, NULL, 0, 1, 0, 100, 0),
(12849500, 7, 2263.4448, -5651.536, 138.61465, NULL, 0, 1, 0, 100, 0),
(12849500, 8, 2219.179, -5659.3193, 124.72987, NULL, 0, 1, 0, 100, 0),
(12849500, 9, 2190.8645, -5681.077, 111.893036, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (12849400);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12849400, 1, 2212.6875, -5663.709, 121.74327, NULL, 0, 0, 0, 100, 0),
(12849400, 2, 2254.4285, -5656.4272, 135.74115, NULL, 0, 0, 0, 100, 0),
(12849400, 3, 2268.116, -5652.7373, 140.11967, NULL, 0, 0, 0, 100, 0),
(12849400, 4, 2261.5894, -5641.087, 139.47206, NULL, 0, 0, 0, 100, 0),
(12849400, 5, 2219.6328, -5645.4023, 127.49414, NULL, 0, 0, 0, 100, 0),
(12849400, 6, 2180.576, -5671.811, 113.43524, NULL, 0, 0, 0, 100, 0),
(12849400, 7, 2186.8884, -5690.231, 109.98612, NULL, 0, 0, 0, 100, 0),
(12849400, 8, 2194.7139, -5682.186, 111.8599, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (12849600);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12849600, 1, 2427.4355, -5779.394, 144.87935, NULL, 0, 1, 0, 100, 0),
(12849600, 2, 2434.906, -5817.79, 121.40016, NULL, 0, 1, 0, 100, 0),
(12849600, 3, 2426.0208, -5839.6807, 112.726456, NULL, 0, 1, 0, 100, 0),
(12849600, 4, 2428.5986, -5806.8105, 127.7234, NULL, 0, 1, 0, 100, 0),
(12849600, 5, 2419.8975, -5778.0996, 146.97415, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (12849700);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12849700, 1, 2420.7751, -5783.0737, 144.95232, NULL, 0, 1, 0, 100, 0),
(12849700, 2, 2427.5361, -5805.041, 129.36699, NULL, 0, 1, 0, 100, 0),
(12849700, 3, 2430.0774, -5813.317, 123.742775, NULL, 0, 1, 0, 100, 0),
(12849700, 4, 2439.1846, -5831.0815, 117.0876, NULL, 0, 1, 0, 100, 0),
(12849700, 5, 2435.7063, -5807.673, 127.221405, NULL, 0, 1, 0, 100, 0),
(12849700, 6, 2428.2505, -5779.307, 144.81055, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (12848600);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12848600, 1, 2317.4883, -5661.696, 153.20062, NULL, 0, 1, 0, 100, 0),
(12848600, 2, 2339.5972, -5683.797, 153.92166, NULL, 0, 1, 0, 100, 0),
(12848600, 3, 2355.661, -5700.141, 153.92184, NULL, 0, 1, 0, 100, 0),
(12848600, 4, 2363.7747, -5709.2, 153.92166, NULL, 0, 1, 0, 100, 0),
(12848600, 5, 2385.4639, -5730.7314, 153.92166, NULL, 0, 1, 0, 100, 0),
(12848600, 6, 2407.2866, -5754.735, 153.90678, NULL, 0, 1, 0, 100, 0),
(12848600, 7, 2385.4639, -5730.7314, 153.92166, NULL, 0, 1, 0, 100, 0),
(12848600, 8, 2372.015, -5717.266, 153.95663, NULL, 0, 1, 0, 100, 0),
(12848600, 9, 2363.7747, -5709.2, 153.92166, NULL, 0, 1, 0, 100, 0),
(12848600, 10, 2355.661, -5700.141, 153.92184, NULL, 0, 1, 0, 100, 0),
(12848600, 11, 2339.5972, -5683.797, 153.92166, NULL, 0, 1, 0, 100, 0),
(12848600, 12, 2317.4883, -5661.696, 153.20062, NULL, 0, 1, 0, 100, 0);

-- Remove Wrong Spawns
DELETE FROM `creature` WHERE (`id1` = 28709) AND (`guid` IN (128491, 128498));
DELETE FROM `creature_addon` WHERE (`guid` IN (128491, 128498));

-- Edit Spawn points, movement types and wander distances
UPDATE `creature` SET  `position_x` = 2398.897, `position_y` = -5776.8403, `position_z` = 153.24074, `wander_distance` = 5, `MovementType` = 1 WHERE (`id1` = 28709) AND (`guid` IN (128493));
UPDATE `creature` SET  `position_x` = 2431.384, `position_y` = -5755.8965, `position_z` = 152.77269, `wander_distance` = 5, `MovementType` = 1 WHERE (`id1` = 28709) AND (`guid` IN (128487));
UPDATE `creature` SET  `position_x` = 2307.605, `position_y` = -5691.999, `position_z` = 154.04599, `wander_distance` = 5, `MovementType` = 1 WHERE (`id1` = 28709) AND (`guid` IN (128492));
UPDATE `creature` SET  `position_x` = 2295.295, `position_y` = -5663.873, `position_z` = 149.52167, `wander_distance` = 5, `MovementType` = 1 WHERE (`id1` = 28709) AND (`guid` IN (128499));
UPDATE `creature` SET  `position_x` = 2190.8645, `position_y` = -5681.077, `position_z` = 111.893036, `wander_distance` = 0, `MovementType` = 2 WHERE (`id1` = 28709) AND (`guid` IN (128495));
UPDATE `creature` SET  `position_x` = 2428.2505, `position_y` = -5779.307, `position_z` = 144.81055, `MovementType` = 2 WHERE (`id1` = 28709) AND (`guid` IN (128497));
UPDATE `creature` SET  `position_x` = 2419.8975, `position_y` = -5778.0996, `position_z` = 146.97415, `MovementType` = 2 WHERE (`id1` = 28709) AND (`guid` IN (128496));
UPDATE `creature` SET  `position_x` = 2194.7139, `position_y` = -5682.186, `position_z` = 111.8599, `MovementType` = 2 WHERE (`id1` = 28709) AND (`guid` IN (128494));
UPDATE `creature` SET  `wander_distance` = 5, `MovementType` = 1 WHERE (`id1` = 28709) AND (`guid` IN (128488, 128489));
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE (`id1` = 28709) AND (`guid` IN (128486));

-- Configure Waypoints
DELETE FROM `creature_addon` WHERE (`guid` IN (128486));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(128486, 12848600, 0, 0, 1, 0, 0, NULL);

UPDATE `creature_addon` SET `path_id` = 12849700 WHERE (`guid` IN (128497));
UPDATE `creature_addon` SET `path_id` = 12849600 WHERE (`guid` IN (128496));
UPDATE `creature_addon` SET `path_id` = 12849400 WHERE (`guid` IN (128494));
UPDATE `creature_addon` SET `path_id` = 12849500 WHERE (`guid` IN (128495));

-- Remove Dazed Aura from one of the geists
UPDATE `creature_addon` SET `auras` = '' WHERE (`guid` IN (128496, 128498));

-- Remove Wrong Death Knight Initiates
DELETE FROM `creature` WHERE (`id1` = 28406) AND (`guid` IN (129520, 129529, 129530, 129531, 129532, 129546, 129547, 129556));
DELETE FROM `creature_addon` WHERE (`guid` IN (129520, 129529, 129530, 129531, 129532, 129546, 129547, 129556));

-- Remove double mount from Baron Rivendare (phase 64)
UPDATE `creature_addon` SET `mount` = 0 WHERE (`guid` IN (130895));
