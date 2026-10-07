-- Mistress Nagmara's route to the lovers' stop. The last point turns her after arrival.
DELETE FROM `waypoint_data` WHERE `id` = 95001;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(95001, 1, 869.12384, -202.85149, -43.708836, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 2, 863.9559, -210.76521, -43.707447, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 3, 866.69403, -221.29358, -43.709167, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 4, 868.26624, -224.17285, -43.728756, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 5, 882.0711, -226.17651, -46.92732, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 6, 888.93, -221.56207, -49.944458, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 7, 886.03735, -218.21387, -49.942142, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 8, 878.1779, -222.06618, -49.967144, NULL, 0, 0, 0, 1, 0, 100, 0),
(95001, 9, 878.1779, -222.06618, -49.967144, 0.25003412, 0, 1, 0, 1, 0, 100, 0);
