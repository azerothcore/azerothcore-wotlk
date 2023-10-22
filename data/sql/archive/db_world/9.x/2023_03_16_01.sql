-- DB update 2023_03_16_00 -> 2023_03_16_01
/*  Dark Iron Agent  - GUID 30132  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30132;
DELETE FROM `creature_addon` WHERE `guid` = 30132;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30132, 301320);

DELETE FROM `waypoint_data` WHERE `id` = 301320;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(301320, 1, -698.351, 559.918, -282.06, 6.01478, 0),
(301320, 2, -736.867, 569.914, -291.06, 4.36542, 0),
(301320, 3, -743.754, 581.403, -291.06, 2.05638, 0),
(301320, 4, -734.431, 619.357, -300.06, 1.31614, 0),
(301320, 5, -726.929, 649.513, -309.06, 1.34361, 0),
(301320, 6, -717.134, 687.832, -318.06, 1.26506, 0),
(301320, 7, -705.253, 694.829, -318.06, 0.471789, 0),
(301320, 8, -717.059, 687.506, -318.06, 4.36151, 0),
(301320, 9, -726.776, 650.171, -309.06, 4.389, 0),
(301320, 10, -734.225, 619.203, -300.06, 1.31416, 0),
(301320, 11, -743.649, 581.74, -291.06, 4.92503, 0),
(301320, 12, -736.919, 569.825, -291.06, 5.79487, 0);

/*  Mobile Alert System  - GUID 30141  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30141;
DELETE FROM `creature_addon` WHERE `guid` = 30141;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30141, 301410);

DELETE FROM `waypoint_data` WHERE `id` = 301410;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(301410, 1, -758.616, 389.631, -272.579, 1.40256, 0),
(301410, 2, -761.637, 372.061, -272.579, 4.54219, 0),
(301410, 3, -768.061, 323.265, -272.596, 4.58146, 0),
(301410, 4, -772.365, 295.195, -272.596, 1.37703, 0),
(301410, 5, -790.13, 282.946, -272.596, 3.7882, 0),
(301410, 6, -819.345, 286.603, -272.598, 6.16794, 0),
(301410, 7, -864.567, 292.906, -272.597, 6.12867, 0),
(301410, 8, -895.449, 297.227, -272.597, 2.26648, 0),
(301410, 9, -906.447, 310.256, -272.597, 5.90485, 0),
(301410, 10, -902.59, 343.969, -272.597, 4.61681, 0),
(301410, 11, -896.84, 389.165, -272.597, 1.42415, 0),
(301410, 12, -890.901, 423.192, -272.597, 0.456167, 0),
(301410, 13, -876.089, 431.872, -272.597, 6.08354, 0),
(301410, 14, -845.913, 427.768, -272.597, 2.98517, 0),
(301410, 15, -798.441, 421.119, -272.579, 3.01071, 0),
(301410, 16, -769.864, 417.263, -272.579, 3.07357, 0),
(301410, 17, -759.135, 400.802, -272.579, 4.76022, 0);

/*  Mobile Alert System  - GUID 30144  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30144;
DELETE FROM `creature_addon` WHERE `guid` = 30144;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30144, 301440);

DELETE FROM `waypoint_data` WHERE `id` = 301440;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(301440, 1, -772.734, 555.942, -291.118, 3.81156, 0),
(301440, 2, -797.767, 536.739, -295.577, 3.81156, 0),
(301440, 3, -819.414, 520.05, -301.901, 3.79782, 0),
(301440, 4, -830.148, 505.313, -303.937, 4.42418, 0),
(301440, 5, -828.69, 489.572, -303.937, 1.93055, 0),
(301440, 6, -814.887, 467.254, -308.104, 3.8116, 0),
(301440, 7, -820.513, 451.342, -308.104, 1.04307, 0),
(301440, 8, -864.515, 417.469, -316.155, 3.79396, 0),
(301440, 9, -869.029, 407.392, -316.437, 0.931181, 0),
(301440, 10, -861.123, 397.329, -316.427, 5.34115, 0),
(301440, 11, -868.891, 407.119, -316.437, 4.69518, 0),
(301440, 12, -864.446, 417.22, -316.179, 3.77824, 0),
(301440, 13, -820.258, 451.175, -308.104, 0.677901, 0),
(301440, 14, -814.775, 466.905, -308.104, 1.41029, 0),
(301440, 15, -828.675, 489.496, -303.937, 1.16682, 0),
(301440, 16, -829.898, 505.228, -303.937, 0.929236, 0),
(301440, 17, -819.117, 519.824, -301.871, 0.65042, 0);

/*  Peacekeeper Security Suit  - GUID 30186  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30186;
DELETE FROM `creature_addon` WHERE `guid` = 30186;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30186, 301860);

DELETE FROM `waypoint_data` WHERE `id` = 301860;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(301860, 1, -492.41, 575.988, -230.601, 5.57692, 0),
(301860, 2, -474.637, 560.585, -230.601, 5.56121, 0),
(301860, 3, -458.518, 528.807, -230.601, 2.2056, 0),
(301860, 4, -459.51, 487.275, -230.601, 4.68156, 0),
(301860, 5, -465.722, 465.272, -230.601, 4.05913, 0),
(301860, 6, -486.533, 438.766, -230.601, 0.840967, 0),
(301860, 7, -506.852, 422.549, -230.601, 0.62501, 0),
(301860, 8, -534.764, 409.005, -230.601, 0.570046, 0),
(301860, 9, -567.88, 413.814, -230.601, 5.96181, 0),
(301860, 10, -590.905, 420.801, -230.601, 2.54139, 0),
(301860, 11, -617.793, 440.393, -230.601, 2.10944, 0),
(301860, 12, -631.982, 460.05, -230.601, 5.20979, 0),
(301860, 13, -646.919, 496.166, -230.601, 1.42025, 0),
(301860, 14, -641.023, 531.507, -230.601, 1.09236, 0),
(301860, 15, -619.368, 570.172, -230.601, 0.546519, 0),
(301860, 16, -583.276, 591.49, -230.601, 0.202924, 0),
(301860, 17, -556.396, 597.001, -230.601, 6.10714, 0),
(301860, 18, -530.129, 592.646, -230.601, 4.57562, 0),
(301860, 19, -503.517, 584.473, -230.601, 5.61628, 0);

/*  Mechano-Frostwalker  - GUID 30193  */

UPDATE `creature` SET `position_x` = -814.733, `position_y` = 174.268, `position_z` = -273.079, `orientation` = 1.09651 WHERE `guid` = 30193;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30193;
DELETE FROM `creature_addon` WHERE `guid` = 30193;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30193, 301930);

DELETE FROM `waypoint_data` WHERE `id` = 301930;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(301930, 1, -814.733, 174.268, -273.079, 100.0, 0),
(301930, 2, -814.873, 139.446, -268.718, 100.0, 0),
(301930, 3, -813.763, 103.338, -264.732, 100.0, 0),
(301930, 4, -804.045, 95.6667, -264.732, 100.0, 0),
(301930, 5, -773.876, 95.1513, -260.566, 100.0, 0),
(301930, 6, -762.487, 83.9004, -260.566, 100.0, 0),
(301930, 7, -773.876, 95.1513, -260.566, 100.0, 0),
(301930, 8, -804.045, 95.6667, -264.732, 100.0, 0),
(301930, 9, -813.763, 103.338, -264.732, 100.0, 0),
(301930, 10, -814.873, 139.446, -268.718, 100.0, 0),
(301930, 11, -814.733, 174.268, -273.079, 100.0, 0),
(301930, 12, -809.044, 185.352, -273.079, 100.0, 0);

/*  Leprous Machinesmith  - GUID 30205  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30205;
DELETE FROM `creature_addon` WHERE `guid` = 30205;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30205, 302050);

DELETE FROM `waypoint_data` WHERE `id` = 302050;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302050, 1, -802.467, 189.663, -273.081, 0.674371, 0),
(302050, 2, -747.77, 231.514, -273.081, 0.595828, 0);

/*  Caverndeep Ambusher  - GUID 30213  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30213;
DELETE FROM `creature_addon` WHERE `guid` = 30213;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30213, 302130);

DELETE FROM `waypoint_data` WHERE `id` = 302130;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302130, 1, -374.979, 71.9299, -154.732, 3.96914, 0),
(302130, 2, -366.61, 79.9331, -154.743, 1.3675, 0),
(302130, 3, -366.909, 134.274, -154.743, 4.72115, 0),
(302130, 4, -366.947, 79.8181, -154.743, 4.70151, 0);

/*  Caverndeep Ambusher  - GUID 30214  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30214;
DELETE FROM `creature_addon` WHERE `guid` = 30214;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30214, 302140);

DELETE FROM `waypoint_data` WHERE `id` = 302140;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302140, 1, -529.971, 201.526, -155.239, 2.34138, 0),
(302140, 2, -542.939, 214.096, -156.042, 2.37083, 0),
(302140, 3, -564.822, 232.708, -159.428, 3.83167, 0),
(302140, 4, -586.961, 213.366, -165.678, 3.90823, 0),
(302140, 5, -621.054, 179.285, -178.199, 3.92394, 0),
(302140, 6, -586.676, 213.41, -165.678, 0.805912, 0),
(302140, 7, -564.663, 232.493, -159.428, 5.42798, 0),
(302140, 8, -542.745, 213.89, -155.992, 5.49867, 0);

/*  Caverndeep Ambusher  - GUID 30215  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30215;
DELETE FROM `creature_addon` WHERE `guid` = 30215;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30215, 302150);

DELETE FROM `waypoint_data` WHERE `id` = 302150;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302150, 1, -624.345, 125.145, -183.882, 0.000859, 0),
(302150, 2, -636.031, 139.795, -183.877, 1.47938, 0),
(302150, 3, -636.692, 161.618, -184.509, 4.66221, 0),
(302150, 4, -635.967, 140.212, -183.877, 1.46368, 0),
(302150, 5, -624.247, 125.5, -183.882, 0.368043, 0),
(302150, 6, -606.756, 125.234, -187.662, 0.000872, 0);

/*  Caverndeep Ambusher  - GUID 30217  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30217;
DELETE FROM `creature_addon` WHERE `guid` = 30217;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30217, 302170);

DELETE FROM `waypoint_data` WHERE `id` = 302170;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302170, 1, -482.355, 53.012, -156.967, 3.92591, 0),
(302170, 2, -467.895, 39.7155, -154.741, 5.50653, 0),
(302170, 3, -452.591, 38.5776, -154.743, 6.27229, 0),
(302170, 4, -467.011, 39.6066, -154.741, 2.90688, 0),
(302170, 5, -481.715, 53.2954, -156.965, 3.93181, 0),
(302170, 6, -504.289, 37.0398, -156.489, 0.419126, 0),
(302170, 7, -521.251, 23.2046, -156.485, 3.87881, 0);

/*  Mechanized Sentry  - GUID 30239  */

UPDATE `creature` SET `position_x` = -432.378, `position_y` = 240.297, `position_z` = -211.538, `orientation` = 4.7055 WHERE `guid` = 30239;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30239;
DELETE FROM `creature_addon` WHERE `guid` = 30239;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30239, 302390);

DELETE FROM `waypoint_data` WHERE `id` = 302390;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302390, 1, -432.378, 240.297, -211.538, 100.0, 0),
(302390, 2, -443.052, 265.788, -211.541, 100.0, 0),
(302390, 3, -469.447, 277.197, -211.54, 100.0, 0),
(302390, 4, -491.541, 277.134, -211.53, 100.0, 0),
(302390, 5, -516.2, 277.284, -211.539, 100.0, 0),
(302390, 6, -538.292, 286.529, -211.538, 100.0, 0),
(302390, 7, -547.458, 309.004, -216.948, 100.0, 0),
(302390, 8, -546.906, 330.915, -223.711, 100.0, 0),
(302390, 9, -546.482, 351.907, -231.019, 100.0, 0),
(302390, 10, -546.906, 330.915, -223.711, 100.0, 0),
(302390, 11, -547.458, 309.004, -216.948, 100.0, 0),
(302390, 12, -538.292, 286.529, -211.538, 100.0, 0),
(302390, 13, -516.2, 277.284, -211.539, 100.0, 0),
(302390, 14, -491.541, 277.134, -211.53, 100.0, 0),
(302390, 15, -469.447, 277.197, -211.54, 100.0, 0),
(302390, 16, -443.052, 265.788, -211.541, 100.0, 0),
(302390, 17, -432.383, 240.496, -211.538, 100.0, 0),
(302390, 18, -432.523, 220.204, -211.538, 100.0, 0);

/*  Mechanized Sentry  - GUID 30245  */

UPDATE `creature` SET `position_x` = -427.681, `position_y` = 228.466, `position_z` = -211.543, `orientation` = 4.71898 WHERE `guid` = 30245;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30245;
DELETE FROM `creature_addon` WHERE `guid` = 30245;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30245, 302450);

DELETE FROM `waypoint_data` WHERE `id` = 302450;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302450, 1, -428.941, 240.286, -211.544, 1.83461, 0),
(302450, 2, -440.727, 268.58, -211.544, 4.66792, 0),
(302450, 3, -470.311, 280.709, -211.544, 5.81657, 0),
(302450, 4, -516.12, 281.221, -211.544, 6.23088, 0),
(302450, 5, -534.256, 289.264, -211.544, 5.67916, 0),
(302450, 6, -543.399, 309.441, -216.936, 5.05284, 0),
(302450, 7, -542.733, 365.248, -231.507, 4.75439, 0),
(302450, 8, -543.37, 309.461, -216.935, 4.77403, 0),
(302450, 9, -534.104, 288.731, -211.544, 5.62815, 0),
(302450, 10, -515.837, 281.125, -211.546, 0.136236, 0),
(302450, 11, -469.957, 280.637, -211.545, 5.98942, 0),
(302450, 12, -440.513, 268.381, -211.544, 5.23152, 0),
(302450, 13, -428.555, 240.324, -211.543, 4.60712, 0),
(302450, 14, -428.707, 234.476, -211.544, 1.60102, 0);

/*  Caverndeep Reaver  - GUID 30271  */

UPDATE `creature` SET `position_x` = -561.427, `position_y` = 76.2373, `position_z` = -203.034, `orientation` = 1.83548 WHERE `guid` = 30271;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30271;
DELETE FROM `creature_addon` WHERE `guid` = 30271;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30271, 302710);

DELETE FROM `waypoint_data` WHERE `id` = 302710;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302710, 1, -561.427, 76.2373, -203.034, 100.0, 0),
(302710, 2, -582.791, 73.7128, -203.104, 100.0, 0),
(302710, 3, -582.274, 94.3503, -202.999, 100.0, 0),
(302710, 4, -573.71, 111.221, -201.717, 100.0, 0),
(302710, 5, -583.401, 134.578, -202.134, 100.0, 0),
(302710, 6, -573.048, 151.098, -202.146, 100.0, 0),
(302710, 7, -541.047, 139.806, -202.151, 100.0, 0),
(302710, 8, -538.994, 107.757, -204.531, 100.0, 0),
(302710, 9, -538.809, 73.1746, -201.544, 100.0, 0);

/*  Peacekeeper Security Suit  - GUID 30278  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30278;
DELETE FROM `creature_addon` WHERE `guid` = 30278;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30278, 302780);

DELETE FROM `waypoint_data` WHERE `id` = 302780;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302780, 1, -516.359, 504.355, -273.069, 1.47905, 0),
(302780, 2, -527.894, 529.571, -273.069, 2.00133, 0),
(302780, 3, -565.904, 542.708, -273.071, 3.76454, 0),
(302780, 4, -579.622, 531.967, -273.071, 0.683833, 0),
(302780, 5, -580.526, 492.073, -273.069, 5.26666, 0),
(302780, 6, -558.895, 472.93, -273.069, 2.31356, 0),
(302780, 7, -530.527, 478.087, -273.069, 3.38366, 0);

/*  Peacekeeper Security Suit  - GUID 30279  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30279;
DELETE FROM `creature_addon` WHERE `guid` = 30279;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30279, 302790);

DELETE FROM `waypoint_data` WHERE `id` = 302790;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(302790, 1, -626.307, 523.558, -273.063, 2.87491, 0),
(302790, 2, -596.255, 511.76, -273.074, 2.86903, 0),
(302790, 3, -589.815, 474.899, -273.077, 3.77421, 0),
(302790, 4, -646.191, 432.3, -273.063, 3.78796, 0),
(302790, 5, -679.516, 407.014, -273.063, 0.624733, 0),
(302790, 6, -689.248, 419.282, -273.063, 5.33517, 0),
(302790, 7, -679.703, 407.177, -273.063, 3.77421, 0),
(302790, 8, -646.316, 431.963, -273.063, 3.41293, 0),
(302790, 9, -590.223, 474.888, -273.078, 1.63597, 0),
(302790, 10, -596.733, 511.9, -273.076, 1.6772, 0);

/*  Mechano-Frostwalker  - GUID 30305  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30305;
DELETE FROM `creature_addon` WHERE `guid` = 30305;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30305, 303050);

DELETE FROM `waypoint_data` WHERE `id` = 303050;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303050, 1, -819.404, 286.624, -272.596, 3.01658, 0),
(303050, 2, -864.792, 293.053, -272.597, 6.18174, 0),
(303050, 3, -895.964, 297.33, -272.597, 3.01854, 0),
(303050, 4, -906.587, 310.34, -272.597, 1.72264, 0),
(303050, 5, -902.773, 343.887, -272.597, 1.48112, 0),
(303050, 6, -896.98, 389.278, -272.597, 1.34368, 0),
(303050, 7, -891.064, 423.548, -272.597, 0.823358, 0),
(303050, 8, -876.317, 431.944, -272.597, 0.467969, 0),
(303050, 9, -846.229, 427.836, -272.597, 6.19941, 0),
(303050, 10, -798.593, 421.184, -272.579, 6.17978, 0),
(303050, 11, -770.105, 417.315, -272.579, 5.42188, 0),
(303050, 12, -759.266, 400.881, -272.579, 5.31389, 0),
(303050, 13, -758.95, 389.493, -272.579, 4.68754, 0),
(303050, 14, -762.012, 371.894, -272.579, 1.45565, 0),
(303050, 15, -768.327, 323.191, -272.596, 1.45566, 0),
(303050, 16, -772.662, 295.294, -272.596, 1.24557, 0),
(303050, 17, -790.419, 283.001, -272.596, 0.544608, 0);

/*  Mechanized Sentry  - GUID 30331  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30331;
DELETE FROM `creature_addon` WHERE `guid` = 30331;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30331, 303310);

DELETE FROM `waypoint_data` WHERE `id` = 303310;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303310, 1, -645.307, 407.239, -230.625, 5.36468, 0),
(303310, 2, -654.78, 419.583, -230.625, 5.38236, 0),
(303310, 3, -622.559, 445.311, -230.6, 0.669968, 0),
(303310, 4, -654.917, 419.6, -230.625, 5.19584, 0),
(303310, 5, -644.873, 407.1, -230.625, 5.45698, 0),
(303310, 6, -634.388, 393.01, -238.959, 5.41575, 0),
(303310, 7, -617.641, 371.231, -247.271, 5.33133, 0),
(303310, 8, -639.759, 353.712, -255.604, 1.88541, 0),
(303310, 9, -679.271, 406.035, -273.063, 5.32938, 0),
(303310, 10, -639.871, 353.846, -255.604, 0.261605, 0),
(303310, 11, -618.001, 371.328, -247.27, 2.48034, 0),
(303310, 12, -634.419, 393.062, -238.959, 2.68651, 0);

/*  Dark Iron Agent  - GUID 30341  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30341;
DELETE FROM `creature_addon` WHERE `guid` = 30341;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30341, 303410);

DELETE FROM `waypoint_data` WHERE `id` = 303410;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303410, 1, -700.681, 547.331, -294.783, 6.01648, 0),
(303410, 2, -730.945, 554.848, -303.783, 6.02829, 0),
(303410, 3, -744.975, 558.601, -303.783, 2.10523, 0),
(303410, 4, -755.189, 575.778, -303.783, 5.12905, 0),
(303410, 5, -756.461, 582.71, -303.783, 4.72653, 0),
(303410, 6, -753.495, 595.336, -303.783, 4.46931, 0),
(303410, 7, -756.446, 582.983, -303.783, 5.38823, 0),
(303410, 8, -755.138, 575.766, -303.783, 1.59083, 0),
(303410, 9, -745.269, 558.951, -303.783, 6.01066, 0),
(303410, 10, -731.175, 555.246, -303.783, 6.01459, 0);

/*  Leprous Technician  - GUID 30365  */

UPDATE `creature` SET `position_x` = -622.269, `position_y` = 451.15, `position_z` = -273.062, `orientation` = 3.95292 WHERE `guid` = 30365;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30365;
DELETE FROM `creature_addon` WHERE `guid` = 30365;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30365, 303650);

DELETE FROM `waypoint_data` WHERE `id` = 303650;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303650, 1, -624.229, 449.824, -273.062, 3.78799, 0),
(303650, 2, -666.455, 416.913, -273.063, 3.79194, 0);

/*  Leprous Assistant  - GUID 30368  */

UPDATE `creature` SET `position_x` = -521.4, `position_y` = 539.471, `position_z` = -273.074, `orientation` = 5.12912 WHERE `guid` = 30368;

DELETE FROM `creature_formations` WHERE `memberGUID` = 30368;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(30369, 30368, 1.91798, 181.19675679453258, 519, 0, 0);

/*  Leprous Assistant  - GUID 30369  */

UPDATE `creature` SET `position_x` = -520.587, `position_y` = 537.734, `position_z` = -273.074, `orientation` = 5.12912 WHERE `guid` = 30369;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30369;
DELETE FROM `creature_addon` WHERE `guid` = 30369;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30369, 303690);

DELETE FROM `waypoint_data` WHERE `id` = 303690;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303690, 1, -509.634, 518.389, -273.074, 5.082, 0),
(303690, 2, -506.154, 503.229, -273.074, 4.91509, 0),
(303690, 3, -514.331, 486.942, -273.073, 4.17877, 0),
(303690, 4, -526.352, 469.8, -273.073, 4.01383, 0),
(303690, 5, -562.348, 462.477, -273.073, 0.179143, 0),
(303690, 6, -591.693, 488.522, -273.073, 5.54147, 0),
(303690, 7, -588.916, 532.764, -273.075, 5.38833, 0),
(303690, 8, -562.054, 552.939, -273.075, 3.33255, 0),
(303690, 9, -521.397, 539.801, -273.074, 2.77885, 0);
DELETE FROM `creature_formations` WHERE `memberGUID` = 30369;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(30369, 30369, 0, 0, 519, 0, 0);

/*  Leprous Assistant  - GUID 30370  */

UPDATE `creature` SET `position_x` = -519.507, `position_y` = 540.309, `position_z` = -273.074, `orientation` = 5.12912 WHERE `guid` = 30370;

DELETE FROM `creature_formations` WHERE `memberGUID` = 30370;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(30369, 30370, 2.79247, 133.36853188819197, 519, 0, 0);

/*  Leprous Assistant  - GUID 30371  */

UPDATE `creature` SET `position_x` = -522.189, `position_y` = 541.254, `position_z` = -273.074, `orientation` = 5.12912 WHERE `guid` = 30371;

DELETE FROM `creature_formations` WHERE `memberGUID` = 30371;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(30369, 30371, 3.86772, 180.59285927846472, 519, 0, 0);

/*  Leprous Technician  - GUID 30372  */

UPDATE `creature` SET `position_x` = -523.258, `position_y` = 538.648, `position_z` = -273.073, `orientation` = 5.12912 WHERE `guid` = 30372;

DELETE FROM `creature_formations` WHERE `memberGUID` = 30372;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(30369, 30372, 2.82354, 227.224175350777, 519, 0, 0);

/*  Mechano-Flamewalker  - GUID 30385  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30385;
DELETE FROM `creature_addon` WHERE `guid` = 30385;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30385, 303850);

DELETE FROM `waypoint_data` WHERE `id` = 303850;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303850, 1, -872.044, 410.955, -316.445, 0.538671, 0),
(303850, 2, -853.375, 387.797, -316.431, 2.23513, 0),
(303850, 3, -872.014, 410.9, -316.447, 0.615248, 0),
(303850, 4, -819.755, 451.621, -308.104, 3.76861, 0),
(303850, 5, -815.285, 461.006, -308.104, 2.51786, 0),
(303850, 6, -818.2, 475.308, -308.104, 5.33744, 0),
(303850, 7, -815.428, 460.949, -308.104, 2.19586, 0),
(303850, 8, -819.768, 451.879, -308.104, 3.80985, 0);

/*  Mechano-Flamewalker  - GUID 30391  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30391;
DELETE FROM `creature_addon` WHERE `guid` = 30391;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30391, 303910);

DELETE FROM `waypoint_data` WHERE `id` = 303910;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303910, 1, -798.785, 421.068, -272.579, 3.03823, 0),
(303910, 2, -823.488, 424.349, -272.596, 6.15626, 0),
(303910, 3, -846.166, 427.647, -272.596, 3.10304, 0),
(303910, 4, -876.55, 431.668, -272.596, 3.09518, 0),
(303910, 5, -891.0, 423.174, -272.596, 0.411067, 0),
(303910, 6, -897.105, 388.858, -272.596, 4.58939, 0),
(303910, 7, -902.819, 344.025, -272.596, 4.63062, 0),
(303910, 8, -906.653, 310.217, -272.596, 4.67186, 0),
(303910, 9, -895.759, 297.063, -272.596, 1.88172, 0),
(303910, 10, -864.728, 292.979, -272.596, 6.16606, 0),
(303910, 11, -819.5, 286.496, -272.598, 6.04039, 0),
(303910, 12, -790.575, 282.945, -272.598, 0.605424, 0),
(303910, 13, -772.582, 295.306, -272.598, 0.992225, 0),
(303910, 14, -768.344, 323.23, -272.598, 1.43009, 0),
(303910, 15, -761.891, 372.069, -272.578, 1.39083, 0),
(303910, 16, -758.837, 389.615, -272.578, 1.8542, 0),
(303910, 17, -759.38, 400.698, -272.578, 4.76212, 0),
(303910, 18, -770.1, 417.408, -272.578, 2.98122, 0);

/*  Mechano-Flamewalker  - GUID 30392  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 30392;
DELETE FROM `creature_addon` WHERE `guid` = 30392;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (30392, 303920);

DELETE FROM `waypoint_data` WHERE `id` = 303920;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(303920, 1, -773.04, 555.82, -291.117, 0.530528, 0),
(303920, 2, -797.726, 536.739, -295.577, 3.79975, 0),
(303920, 3, -812.325, 525.774, -299.767, 3.79585, 0),
(303920, 4, -822.413, 515.006, -303.61, 3.8587, 0),
(303920, 5, -830.292, 503.28, -303.937, 1.00377, 0),
(303920, 6, -830.192, 490.937, -303.937, 5.09177, 0),
(303920, 7, -830.091, 503.568, -303.937, 4.68141, 0),
(303920, 8, -822.244, 515.104, -303.549, 0.744598, 0),
(303920, 9, -812.084, 525.769, -299.764, 0.640533, 0),
(303920, 10, -797.66, 536.566, -295.578, 0.648386, 0);

/*  Peacekeeper Security Suit  - GUID 32013  */

UPDATE `creature` SET `position_x` = -474.714, `position_y` = 453.097, `position_z` = -230.601, `orientation` = 2.1193 WHERE `guid` = 32013;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 32013;
DELETE FROM `creature_addon` WHERE `guid` = 32013;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (32013, 320130);

DELETE FROM `waypoint_data` WHERE `id` = 320130;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(320130, 1, -465.514, 465.207, -230.601, 3.29151, 0),
(320130, 2, -459.382, 487.04, -230.601, 1.36728, 0),
(320130, 3, -458.485, 528.472, -230.601, 4.93691, 0),
(320130, 4, -474.767, 560.434, -230.601, 1.99168, 0),
(320130, 5, -492.59, 575.839, -230.601, 2.63766, 0),
(320130, 6, -503.872, 584.37, -230.601, 2.64551, 0),
(320130, 7, -530.252, 592.402, -230.601, 3.62333, 0),
(320130, 8, -556.663, 596.785, -230.601, 5.38459, 0),
(320130, 9, -583.461, 591.249, -230.601, 3.42305, 0),
(320130, 10, -619.444, 569.812, -230.601, 4.24968, 0),
(320130, 11, -641.116, 531.299, -230.601, 0.587759, 0),
(320130, 12, -646.919, 495.651, -230.601, 4.55992, 0),
(320130, 13, -632.026, 459.515, -230.601, 5.21179, 0),
(320130, 14, -617.69, 440.007, -230.601, 6.28191, 0),
(320130, 15, -590.993, 420.521, -230.601, 5.58095, 0),
(320130, 16, -567.625, 413.477, -230.601, 6.12483, 0),
(320130, 17, -534.567, 408.885, -230.601, 0.683983, 0),
(320130, 18, -506.797, 422.488, -230.601, 1.14344, 0),
(320130, 19, -486.527, 438.453, -230.601, 1.00403, 0);

/*  Arcane Nullifier X-21  - GUID 33496  */

UPDATE `creature` SET `position_x` = -663.308, `position_y` = 713.787, `position_z` = -327.06, `orientation` = 2.00713 WHERE `guid` = 33496;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 33496;
DELETE FROM `creature_addon` WHERE `guid` = 33496;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (33496, 334960);

DELETE FROM `waypoint_data` WHERE `id` = 334960;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(334960, 1, -663.308, 713.787, -327.06, 100.0, 0),
(334960, 2, -692.062, 721.377, -318.06, 100.0, 0),
(334960, 3, -706.103, 723.074, -318.06, 100.0, 0),
(334960, 4, -720.18, 719.216, -318.06, 100.0, 0),
(334960, 5, -732.442, 712.068, -318.06, 100.0, 0),
(334960, 6, -743.691, 697.216, -318.06, 100.0, 0),
(334960, 7, -749.654, 677.455, -316.903, 100.0, 0),
(334960, 8, -752.935, 662.622, -310.343, 100.0, 0),
(334960, 9, -757.229, 647.8, -307.222, 100.0, 0),
(334960, 10, -759.794, 636.592, -302.256, 100.0, 0),
(334960, 11, -757.229, 647.8, -307.222, 100.0, 0),
(334960, 12, -752.935, 662.622, -310.343, 100.0, 0),
(334960, 13, -749.654, 677.455, -316.903, 100.0, 0),
(334960, 14, -743.691, 697.216, -318.06, 100.0, 0),
(334960, 15, -732.442, 712.068, -318.06, 100.0, 0),
(334960, 16, -720.18, 719.216, -318.06, 100.0, 0),
(334960, 17, -706.103, 723.074, -318.06, 100.0, 0),
(334960, 18, -692.062, 721.377, -318.06, 100.0, 0),
(334960, 19, -663.51, 713.837, -326.974, 100.0, 0),
(334960, 20, -636.836, 706.863, -327.056, 100.0, 0);

