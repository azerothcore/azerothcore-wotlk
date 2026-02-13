SET @MOVE_TYPE := 3; -- Fly
DELETE FROM `waypoint_data` WHERE `id` IN (304490, 304520, 304510);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
-- Vesperon  patrol waypoints for Vesperon (circular patrol above Sartharion)
(304490, 1, 3296.785, 555.0555, 87.29027, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 2, 3266.8242, 575.95245, 89.76242, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 3, 3227.2224, 577.1228, 89.87349, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 4, 3197.2644, 553.5248, 88.651405, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 5, 3195.9875, 507.7954, 87.45695, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 6, 3224.5435, 481.11807, 84.70684, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 7, 3265.2356, 481.7216, 83.595764, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304490, 8, 3299.8765, 506.4301, 83.87355, 0, 0, @MOVE_TYPE, 0, 100, 0),
-- Tenebron patrol waypoints for Tenebron (circular patrol above Sartharion)
(304520, 1, 3232.0261, 569.16376, 97.53158, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 2, 3203.6875, 548.84595, 98.50729, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 3, 3206.0713, 513.54425, 99.3684, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 4, 3234.5671, 489.96832, 99.47933, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 5, 3265.446, 490.026, 98.423836, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 6, 3287.5674, 503.39835, 97.645226, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 7, 3288.8157, 549.16187, 96.70078, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304520, 8, 3264.5164, 568.97516, 95.97868, 0, 0, @MOVE_TYPE, 0, 100, 0),
-- Shadron patrol waypoints for Shadron (circular patrol above Sartharion)
(304510, 1, 3196.095, 548.7049, 115.83286, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 2, 3224.809, 573.8922, 116.08303, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 3, 3270.8267, 572.1468, 112.77744, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 4, 3295.5364, 547.12506, 109.66705, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 5, 3296.5833, 503.22397, 106.95133, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 6, 3254.0688, 489.25906, 108.92368, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 7, 3223.111, 488.90338, 110.53484, 0, 0, @MOVE_TYPE, 0, 100, 0),
(304510, 8, 3197.9263, 511.4375, 113.22937, 0, 0, @MOVE_TYPE, 0, 100, 0);

-- +512	NO_MOVE_FLAGS_UPDATE - Creature won't update movement flags
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 512 WHERE (`entry` IN (30452, 30451, 30449));
