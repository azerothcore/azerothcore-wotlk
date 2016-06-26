
UPDATE creature SET spawntimesecs=86400 WHERE map=349 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=349 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------

-- Spirit of Veng <The Fifth Khan> (12243)
REPLACE INTO creature_addon VALUES (53970, 539700, 0, 0, 0, 0, '');
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=53970;
DELETE FROM waypoint_data WHERE id=539700;
INSERT INTO waypoint_data VALUES (539700, 1, 1054.66, -418.166, -32.1698, 0, 0, 0, 0, 100, 0),(539700, 2, 1052.51, -409.108, -34.1824, 0, 0, 0, 0, 100, 0),(539700, 3, 1051.97, -397.501, -36.3423, 0, 0, 0, 0, 100, 0),(539700, 4, 1046.92, -383.176, -36.2757, 0, 0, 0, 0, 100, 0),(539700, 5, 1033.3, -379.925, -36.4193, 0, 0, 0, 0, 100, 0),(539700, 6, 1020.14, -375.153, -37.6394, 0, 0, 0, 0, 100, 0),(539700, 7, 1013.48, -364.127, -39.7985, 0, 0, 0, 0, 100, 0),(539700, 8, 1006.52, -346.859, -41.2713, 0, 0, 0, 0, 100, 0),(539700, 9, 998.869, -329.805, -44.0742, 0, 0, 0, 0, 100, 0),(539700, 10, 991.13, -311.602, -45.548, 0, 0, 0, 0, 100, 0),(539700, 11, 972.519, -293.894, -45.4281, 0, 0, 0, 0, 100, 0),(539700, 12, 952.024, -274.817, -45.8659, 0, 0, 0, 0, 100, 0),(539700, 13, 930.341, -251.967, -46.4529, 0, 0, 0, 0, 100, 0),(539700, 14, 923.88, -245.265, -46.6301, 0, 0, 0, 0, 100, 0),(539700, 15, 910.845, -252.927, -46.4011, 0, 0, 0, 0, 100, 0),(539700, 16, 896.491, -260.67, -46.0724, 0, 0, 0, 0, 100, 0),(539700, 17, 888.012, -271.811, -45.6818, 0, 0, 0, 0, 100, 0),(539700, 18, 896.073, -291.202, -46.1732, 0, 0, 0, 0, 100, 0),(539700, 19, 896.539, -306.374, -46.1574, 0, 0, 0, 0, 100, 0),(539700, 20, 897.657, -312.075, -47.9966, 0, 0, 0, 0, 100, 0),(539700, 21, 902.17, -321.776, -49.5307, 0, 0, 0, 0, 100, 0),
(539700, 22, 911.333, -336.686, -49.3633, 0, 0, 0, 0, 100, 0),(539700, 23, 938.504, -358.748, -50.4565, 0, 0, 0, 0, 100, 0),(539700, 24, 965.278, -375.298, -49.757, 0, 0, 0, 0, 100, 0),(539700, 25, 979.272, -374.878, -49.8823, 0, 0, 0, 0, 100, 0),(539700, 26, 985.854, -362.529, -50.2742, 0, 0, 0, 0, 100, 0),(539700, 27, 988.171, -346.633, -56.1035, 0, 0, 0, 0, 100, 0),(539700, 28, 992.741, -332.262, -63.3553, 0, 0, 0, 0, 100, 0),(539700, 29, 1004.46, -319.278, -69.922, 0, 0, 0, 0, 100, 0),(539700, 30, 1014, -309.026, -72.0202, 0, 0, 0, 0, 100, 0),(539700, 31, 1024.47, -301.647, -71.894, 0, 0, 0, 0, 100, 0),(539700, 32, 1036.73, -305.123, -72.0122, 0, 0, 0, 0, 100, 0),(539700, 33, 1055.75, -316.543, -72.7976, 0, 0, 0, 0, 100, 0),(539700, 34, 1047.74, -312.678, -72.5623, 0, 0, 0, 0, 100, 0),(539700, 35, 1040.3, -305.262, -72.2632, 0, 0, 0, 0, 100, 0),(539700, 36, 1028.35, -300.651, -71.8715, 0, 0, 0, 0, 100, 0),(539700, 37, 1017, -306.738, -72.0948, 0, 0, 0, 0, 100, 0),(539700, 38, 1001.31, -316.896, -69.6089, 0, 0, 0, 0, 100, 0),(539700, 39, 992.403, -327.695, -64.8258, 0, 0, 0, 0, 100, 0),(539700, 40, 986.104, -344.021, -56.5389, 0, 0, 0, 0, 100, 0),(539700, 41, 985.349, -359.192, -50.6737, 0, 0, 0, 0, 100, 0),(539700, 42, 982.195, -369.208, -50.1736, 0, 0, 0, 0, 100, 0),
(539700, 43, 969.285, -377.212, -49.6666, 0, 0, 0, 0, 100, 0),(539700, 44, 952.917, -371.021, -50.0517, 0, 0, 0, 0, 100, 0),(539700, 45, 940.871, -358.326, -50.3893, 0, 0, 0, 0, 100, 0),(539700, 46, 927.081, -345.711, -50.004, 0, 0, 0, 0, 100, 0),(539700, 47, 914.169, -333.899, -49.2688, 0, 0, 0, 0, 100, 0),(539700, 48, 903.012, -323.694, -49.7491, 0, 0, 0, 0, 100, 0),(539700, 49, 898.941, -314.483, -48.7591, 0, 0, 0, 0, 100, 0),(539700, 50, 895.836, -305.661, -46.1323, 0, 0, 0, 0, 100, 0),(539700, 51, 891.862, -293.483, -46.0323, 0, 0, 0, 0, 100, 0),(539700, 52, 889.456, -272.681, -45.5751, 0, 0, 0, 0, 100, 0),(539700, 53, 893.914, -263.175, -45.729, 0, 0, 0, 0, 100, 0),(539700, 54, 908.039, -255.02, -46.2701, 0, 0, 0, 0, 100, 0),(539700, 55, 925.772, -243.773, -46.5885, 0, 0, 0, 0, 100, 0),(539700, 56, 935.836, -258.173, -46.0265, 0, 0, 0, 0, 100, 0),(539700, 57, 949.541, -274.079, -45.9229, 0, 0, 0, 0, 100, 0),(539700, 58, 966.601, -288.269, -45.4345, 0, 0, 0, 0, 100, 0),(539700, 59, 981.585, -302.982, -45.6738, 0, 0, 0, 0, 100, 0),(539700, 60, 997.762, -319.764, -45.1962, 0, 0, 0, 0, 100, 0),(539700, 61, 999.965, -327.652, -44.2752, 0, 0, 0, 0, 100, 0),(539700, 62, 1002.08, -339.077, -42.0622, 0, 0, 0, 0, 100, 0),(539700, 63, 1003.94, -345.827, -41.3256, 0, 0, 0, 0, 100, 0),
(539700, 64, 1008.49, -359.066, -40.2441, 0, 0, 0, 0, 100, 0),(539700, 65, 1015, -368.778, -38.7655, 0, 0, 0, 0, 100, 0),(539700, 66, 1024.72, -377.123, -37.3859, 0, 0, 0, 0, 100, 0),(539700, 67, 1041.3, -382.705, -36.2797, 0, 0, 0, 0, 100, 0),(539700, 68, 1048.19, -396.087, -36.2717, 0, 0, 0, 0, 100, 0),(539700, 69, 1050.95, -408.596, -34.2235, 0, 0, 0, 0, 100, 0),(539700, 70, 1053.97, -418.652, -32.1341, 0, 0, 0, 0, 100, 0),(539700, 71, 1058.98, -430.442, -32.4236, 0, 0, 0, 0, 100, 0);

-- Celebrian Dryad (11793)
DELETE FROM creature_formations WHERE memberGUID IN(53990, 53991);
INSERT INTO creature_formations VALUES (53990, 53990, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (53990, 53991, 2, 90, 2, 0, 0);
REPLACE INTO creature_addon VALUES (53990, 539900, 0, 0, 0, 0, '');
DELETE FROM creature_addon WHERE guid=53991;
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid=53991;
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=53990;
DELETE FROM waypoint_data WHERE id=539900;
INSERT INTO waypoint_data VALUES (539900, 1, 1044.85, -363.575, -37.161, 0, 0, 0, 0, 100, 0),(539900, 2, 1043.73, -357.874, -37.8807, 0, 0, 0, 0, 100, 0),(539900, 3, 1041.95, -351.103, -38.6527, 0, 0, 0, 0, 100, 0),(539900, 4, 1035.55, -346.005, -38.6154, 0, 0, 0, 0, 100, 0),(539900, 5, 1024.54, -345.55, -41.0799, 0, 0, 0, 0, 100, 0),(539900, 6, 1017.71, -347.059, -41.0136, 0, 0, 0, 0, 100, 0),(539900, 7, 1006.42, -349.831, -41.2061, 0, 0, 0, 0, 100, 0),(539900, 8, 1004.31, -341.917, -41.3627, 0, 0, 0, 0, 100, 0),(539900, 9, 1002.91, -333.92, -42.7118, 0, 0, 0, 0, 100, 0),(539900, 10, 1000.47, -320.062, -44.934, 0, 0, 0, 0, 100, 0),
(539900, 11, 995.747, -311.958, -45.2817, 0, 0, 0, 0, 100, 0),(539900, 12, 986.712, -302.876, -45.8108, 0, 0, 0, 0, 100, 0),(539900, 13, 974.852, -291.679, -45.4682, 0, 0, 0, 0, 100, 0),(539900, 14, 964.972, -283.527, -45.4944, 0, 0, 0, 0, 100, 0),(539900, 15, 949.691, -270.919, -45.9249, 0, 0, 0, 0, 100, 0),(539900, 16, 936.931, -258.873, -45.8982, 0, 0, 0, 0, 100, 0),(539900, 17, 929.939, -244.073, -46.387, 0, 0, 0, 0, 100, 0),(539900, 18, 939.787, -234.122, -46.5583, 0, 0, 0, 0, 100, 0),(539900, 19, 948.361, -226.175, -46.5564, 0, 0, 0, 0, 100, 0),(539900, 20, 956.234, -221.077, -46.5564, 0, 0, 0, 0, 100, 0),(539900, 21, 959.49, -222.361, -46.7408, 0, 0, 0, 0, 100, 0),
(539900, 22, 966.763, -226.127, -49.2207, 0, 0, 0, 0, 100, 0),(539900, 23, 980.701, -238.579, -48.729, 0, 0, 0, 0, 100, 0),(539900, 24, 988.136, -245.994, -46.3349, 0, 0, 0, 0, 100, 0),(539900, 25, 990.799, -253.739, -45.7114, 0, 0, 0, 0, 100, 0),(539900, 26, 984.704, -263.714, -45.7114, 0, 0, 0, 0, 100, 0),(539900, 27, 976.944, -273.994, -45.7114, 0, 0, 0, 0, 100, 0),(539900, 28, 973.632, -288.661, -45.5149, 0, 0, 0, 0, 100, 0),(539900, 29, 981.141, -301.785, -45.6289, 0, 0, 0, 0, 100, 0),(539900, 30, 990.407, -315.292, -45.7076, 0, 0, 0, 0, 100, 0),(539900, 31, 994.074, -322.536, -45.2744, 0, 0, 0, 0, 100, 0),(539900, 32, 997.099, -330.147, -44.2156, 0, 0, 0, 0, 100, 0),
(539900, 33, 1000.97, -343.602, -41.9101, 0, 0, 0, 0, 100, 0),(539900, 34, 1003.68, -352.507, -40.9164, 0, 0, 0, 0, 100, 0),(539900, 35, 1009.27, -364.111, -39.6934, 0, 0, 0, 0, 100, 0),(539900, 36, 1016.19, -374.892, -37.6639, 0, 0, 0, 0, 100, 0),(539900, 37, 1023.69, -378.194, -37.2822, 0, 0, 0, 0, 100, 0),(539900, 38, 1030.79, -382.125, -36.4193, 0, 0, 0, 0, 100, 0),(539900, 39, 1042.42, -383.301, -36.2648, 0, 0, 0, 0, 100, 0),(539900, 40, 1047.33, -375.393, -36.276, 0, 0, 0, 0, 100, 0),(539900, 41, 1048.02, -369.553, -36.276, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(54128, 54129);
INSERT INTO creature_formations VALUES (54128, 54128, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (54128, 54129, 2, 90, 2, 0, 0);
REPLACE INTO creature_addon VALUES (54128, 541280, 0, 0, 0, 0, '');
DELETE FROM creature_addon WHERE guid=54129;
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid=54129;
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=54128;
DELETE FROM waypoint_data WHERE id=541280;
INSERT INTO waypoint_data VALUES (541280, 1, 907.889, -331.422, -49.406, 0, 0, 0, 0, 100, 0),(541280, 2, 913.194, -337.569, -49.3092, 0, 0, 0, 0, 100, 0),(541280, 3, 922.91, -347.648, -50.1039, 0, 0, 0, 0, 100, 0),(541280, 4, 915.967, -341.445, -49.5594, 0, 0, 0, 0, 100, 0),(541280, 5, 908.082, -334.512, -49.4043, 0, 0, 0, 0, 100, 0),(541280, 6, 901.79, -324.66, -49.7161, 0, 0, 0, 0, 100, 0),(541280, 7, 896.662, -314.225, -48.3657, 0, 0, 0, 0, 100, 0),(541280, 8, 895.282, -308.509, -46.3751, 0, 0, 0, 0, 100, 0),(541280, 9, 892.744, -299.552, -46.0708, 0, 0, 0, 0, 100, 0),(541280, 10, 888.296, -283.86, -45.9281, 0, 0, 0, 0, 100, 0),
(541280, 11, 887.583, -273.385, -45.7409, 0, 0, 0, 0, 100, 0),(541280, 12, 890.994, -265.939, -45.487, 0, 0, 0, 0, 100, 0),(541280, 13, 898.291, -258.389, -46.1164, 0, 0, 0, 0, 100, 0),(541280, 14, 907.763, -251.658, -46.3226, 0, 0, 0, 0, 100, 0),(541280, 15, 916.265, -245.617, -46.5235, 0, 0, 0, 0, 100, 0),(541280, 16, 908.59, -250.847, -46.3648, 0, 0, 0, 0, 100, 0),(541280, 17, 897.702, -257.597, -46.1154, 0, 0, 0, 0, 100, 0),(541280, 18, 887.43, -268.684, -45.5779, 0, 0, 0, 0, 100, 0),(541280, 19, 888.555, -279.124, -45.9269, 0, 0, 0, 0, 100, 0),(541280, 20, 892.193, -291.406, -46.0143, 0, 0, 0, 0, 100, 0),
(541280, 21, 894.347, -306.407, -46.0255, 0, 0, 0, 0, 100, 0),(541280, 22, 897.222, -315.336, -48.6672, 0, 0, 0, 0, 100, 0),(541280, 23, 899.367, -321.999, -49.4262, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(54326, 54327);
INSERT INTO creature_formations VALUES (54326, 54326, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (54326, 54327, 2, 90, 2, 0, 0);
REPLACE INTO creature_addon VALUES (54326, 543260, 0, 0, 0, 0, '');
DELETE FROM creature_addon WHERE guid=54327;
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid=54327;
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=54326;
DELETE FROM waypoint_data WHERE id=543260;
INSERT INTO waypoint_data VALUES (543260, 1, 940.641, -157.473, -60.3306, 0, 0, 0, 0, 100, 0),(543260, 2, 937.067, -164.764, -61.5783, 0, 0, 0, 0, 100, 0),(543260, 3, 936.36, -170.531, -62.1773, 0, 0, 0, 0, 100, 0),(543260, 4, 941.631, -178.29, -62.9658, 0, 0, 0, 0, 100, 0),(543260, 5, 950.426, -181.343, -63.7053, 0, 0, 0, 0, 100, 0),(543260, 6, 959.667, -182.476, -64.8912, 0, 0, 0, 0, 100, 0),(543260, 7, 970.089, -183.753, -66.0613, 0, 0, 0, 0, 100, 0),(543260, 8, 977.801, -186.295, -67.7592, 0, 0, 0, 0, 100, 0),(543260, 9, 985.99, -192.754, -67.6933, 0, 0, 0, 0, 100, 0),(543260, 10, 996.425, -203.785, -67.4216, 0, 0, 0, 0, 100, 0),(543260, 11, 1005.34, -206.455, -67.5324, 0, 0, 0, 0, 100, 0),(543260, 12, 1017.63, -210.08, -68.5017, 0, 0, 0, 0, 100, 0),(543260, 13, 1023.57, -213.786, -69.8534, 0, 0, 0, 0, 100, 0),(543260, 14, 1030.07, -222.033, -72.0692, 0, 0, 0, 0, 100, 0),(543260, 15, 1034.15, -229.132, -72.3197, 0, 0, 0, 0, 100, 0),(543260, 16, 1040.87, -238.698, -72.2392, 0, 0, 0, 0, 100, 0),
(543260, 17, 1047.32, -241.429, -72.2392, 0, 0, 0, 0, 100, 0),(543260, 18, 1054.29, -242.008, -72.2392, 0, 0, 0, 0, 100, 0),(543260, 19, 1059.63, -239.723, -72.2392, 0, 0, 0, 0, 100, 0),(543260, 20, 1065.65, -234.165, -72.3736, 0, 0, 0, 0, 100, 0),(543260, 21, 1068.12, -227.618, -72.5878, 0, 0, 0, 0, 100, 0),(543260, 22, 1064.9, -220.088, -72.5862, 0, 0, 0, 0, 100, 0),(543260, 23, 1055.61, -215.208, -72.6286, 0, 0, 0, 0, 100, 0),(543260, 24, 1047.71, -217.398, -72.2335, 0, 0, 0, 0, 100, 0),(543260, 25, 1040.97, -219.27, -72.0943, 0, 0, 0, 0, 100, 0),(543260, 26, 1035.74, -216.579, -71.2911, 0, 0, 0, 0, 100, 0),(543260, 27, 1029.16, -209.994, -69.5422, 0, 0, 0, 0, 100, 0),(543260, 28, 1017.11, -202.864, -67.9095, 0, 0, 0, 0, 100, 0),(543260, 29, 1004.79, -196.213, -67.6477, 0, 0, 0, 0, 100, 0),(543260, 30, 990.304, -184.517, -67.7697, 0, 0, 0, 0, 100, 0),(543260, 31, 973.197, -180.829, -67.2307, 0, 0, 0, 0, 100, 0),(543260, 32, 951.527, -176.158, -63.9659, 0, 0, 0, 0, 100, 0),
(543260, 33, 942.428, -170.917, -62.533, 0, 0, 0, 0, 100, 0),(543260, 34, 939.071, -162.234, -60.9907, 0, 0, 0, 0, 100, 0),(543260, 35, 945.544, -157.216, -60.1057, 0, 0, 0, 0, 100, 0),(543260, 36, 951.348, -156.943, -59.6975, 0, 0, 0, 0, 100, 0),(543260, 37, 957.363, -151.386, -59.4436, 0, 0, 0, 0, 100, 0),(543260, 38, 959.183, -143.4, -60.115, 0, 0, 0, 0, 100, 0),(543260, 39, 955.931, -135.96, -61.4671, 0, 0, 0, 0, 100, 0),(543260, 40, 949.318, -133.665, -61.5488, 0, 0, 0, 0, 100, 0),(543260, 41, 943.334, -137.297, -60.9819, 0, 0, 0, 0, 100, 0),(543260, 42, 938.593, -145.31, -60.5945, 0, 0, 0, 0, 100, 0),(543260, 43, 937.48, -152.15, -60.7596, 0, 0, 0, 0, 100, 0);

-- Corruptor (12217)
DELETE FROM creature_formations WHERE memberGUID IN(55087, 55088, 55091);
INSERT INTO creature_formations VALUES (55087, 55087, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (55087, 55088, 2, 120, 2, 0, 0);
INSERT INTO creature_formations VALUES (55087, 55091, 2, 240, 2, 0, 0);
REPLACE INTO creature_addon VALUES (55087, 550870, 0, 0, 0, 0, '');
DELETE FROM creature_addon WHERE guid=54327;
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(55088, 55091);
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=55087;
DELETE FROM waypoint_data WHERE id=550870;
INSERT INTO waypoint_data VALUES (550870, 1, 755.485, -557.586, -33.0737, 0, 0, 1, 0, 100, 0),(550870, 2, 744.988, -552.44, -32.8322, 0, 0, 1, 0, 100, 0),(550870, 3, 738.514, -541.387, -33.5657, 0, 0, 1, 0, 100, 0),(550870, 4, 742.163, -545.908, -33.1647, 0, 0, 1, 0, 100, 0),(550870, 5, 748.614, -552.621, -32.8559, 0, 0, 1, 0, 100, 0),(550870, 6, 755.519, -556.893, -33.0601, 0, 0, 1, 0, 100, 0),(550870, 7, 765.566, -559.944, -32.811, 0, 0, 1, 0, 100, 0),(550870, 8, 771.041, -543.47, -35.5209, 0, 0, 1, 0, 100, 0),(550870, 9, 770.854, -555.159, -32.9602, 0, 0, 1, 0, 100, 0),(550870, 10, 761.369, -561.517, -32.9577, 0, 0, 1, 0, 100, 0);


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Barbed Lasher (12219)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12219;
DELETE FROM smart_scripts WHERE entryorguid=12219 AND source_type=0;
INSERT INTO smart_scripts VALUES (12219, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 13000, 24000, 11, 21749, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Barbed Lasher - In Combat - Cast Thorn Volley');

-- Celebrian Dryad (11793)
DELETE FROM creature_text WHERE entry=11793;
INSERT INTO creature_text VALUES (11793, 0, 0, 'Nothing must befoul the gardens! You must be destroyed!', 12, 0, 100, 0, 0, 0, 0, 'Celebrian Dryad');
INSERT INTO creature_text VALUES (11793, 0, 1, 'You do not belong in these gardens. Your body shall nourish our lovely creations!', 12, 0, 100, 0, 0, 0, 0, 'Celebrian Dryad');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11793;
DELETE FROM smart_scripts WHERE entryorguid=11793 AND source_type=0;
INSERT INTO smart_scripts VALUES (11793, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Celebrian Dryad - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (11793, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Celebrian Dryad - On Reset - Cast Slowing Poison');

-- Constrictor Vine (12220)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12220;
DELETE FROM smart_scripts WHERE entryorguid=12220 AND source_type=0;
INSERT INTO smart_scripts VALUES (12220, 0, 0, 0, 0, 0, 100, 0, 0, 15000, 13000, 24000, 11, 11922, 32, 1, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 'Constrictor Vine - In Combat - Cast Entangling Roots');

-- Creeping Sludge (12222)
REPLACE INTO creature_template_addon VALUES (12222, 0, 0, 0, 0, 0, '22638');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=12222;
DELETE FROM smart_scripts WHERE entryorguid=12222 AND source_type=0;

-- Spewed Larva (13533)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=13533;
DELETE FROM smart_scripts WHERE entryorguid=13533 AND source_type=0;
INSERT INTO smart_scripts VALUES (13533, 0, 0, 0, 0, 0, 100, 0, 6000, 13000, 20000, 29000, 11, 5413, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spewed Larva - In Combat - Cast Noxious Catalyst');
INSERT INTO smart_scripts VALUES (13533, 0, 1, 2, 54, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 929.95, -353.66, -50.47, 0, 'Spewed Larva - Is Summoned By - Move To Pos');
INSERT INTO smart_scripts VALUES (13533, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spewed Larva - Is Summoned By - Random Move');

-- Vile Larva (12218)
REPLACE INTO creature_template_addon VALUES (12218, 0, 0, 0, 0, 0, '3616');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12218;
DELETE FROM smart_scripts WHERE entryorguid=12218 AND source_type=0;
INSERT INTO smart_scripts VALUES (12218, 0, 0, 0, 0, 0, 100, 0, 4000, 17000, 10000, 29000, 11, 21069, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vile Larva - In Combat - Cast Larva Goo');

-- Corruptor (12217)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12217;
DELETE FROM smart_scripts WHERE entryorguid=12217 AND source_type=0;
INSERT INTO smart_scripts VALUES (12217, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 2500, 3500, 11, 21068, 96, 1, 0, 0, 0, 24, 30, 0, 0, 0, 0, 0, 0, 'Corruptor - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (12217, 0, 1, 0, 0, 0, 100, 0, 4000, 11000, 10000, 29000, 11, 5413, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Corruptor - In Combat - Cast Noxious Catalyst');

-- Poison Sprite (12216)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12216;
DELETE FROM smart_scripts WHERE entryorguid=12216 AND source_type=0;
INSERT INTO smart_scripts VALUES (12216, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 2500, 3000, 11, 21067, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Poison Sprite - In Combat - Cast Poison Bolt');

-- Deeprot Stomper (13141)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=13141;
DELETE FROM smart_scripts WHERE entryorguid=13141 AND source_type=0;
INSERT INTO smart_scripts VALUES (13141, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 5000, 7000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deeprot Stomper - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (13141, 0, 1, 0, 0, 0, 100, 0, 4000, 15000, 22500, 30000, 11, 11876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deeprot Stomper - In Combat - Cast War Stomp');

-- Deeprot Tangler (13142)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=13142;
DELETE FROM smart_scripts WHERE entryorguid=13142 AND source_type=0;
INSERT INTO smart_scripts VALUES (13142, 0, 0, 0, 1, 0, 100, 0, 1000, 5000, 300000, 300000, 11, 21337, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deeprot Tangler - Out of Combat - Cast Thorns');
INSERT INTO smart_scripts VALUES (13142, 0, 1, 0, 0, 0, 100, 0, 4000, 11000, 22500, 30000, 11, 21331, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Deeprot Tangler - In Combat - Cast Entangling Roots');

-- Putridus Satyr (11790)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11790;
DELETE FROM smart_scripts WHERE entryorguid=11790 AND source_type=0;
INSERT INTO smart_scripts VALUES (11790, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 21061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Satyr - On Reset - Cast Putrid Breath');
INSERT INTO smart_scripts VALUES (11790, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 5000, 7000, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridus Satyr - In Combat - Cast Sinister Strike');
INSERT INTO smart_scripts VALUES (11790, 0, 2, 0, 0, 0, 100, 0, 4000, 15000, 22500, 30000, 11, 12540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridus Satyr - In Combat - Cast Gouge');

-- Putridus Shadowstalker (11792)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11792;
DELETE FROM smart_scripts WHERE entryorguid=11792 AND source_type=0;
INSERT INTO smart_scripts VALUES (11792, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 21061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Shadowstalker - On Reset - Cast Putrid Breath');
INSERT INTO smart_scripts VALUES (11792, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Shadowstalker - On Reset - Cast Sneak');
INSERT INTO smart_scripts VALUES (11792, 0, 2, 0, 0, 0, 100, 0, 1000, 5000, 7000, 10000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridus Shadowstalker - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (11792, 0, 3, 0, 0, 0, 100, 0, 4000, 15000, 22500, 30000, 11, 15087, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Shadowstalker - In Combat - Cast Evasion');

-- Putridus Trickster (11791)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11791;
DELETE FROM smart_scripts WHERE entryorguid=11791 AND source_type=0;
INSERT INTO smart_scripts VALUES (11791, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 21061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast Putrid Breath');
INSERT INTO smart_scripts VALUES (11791, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (11791, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 13299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast Poison Proc');
INSERT INTO smart_scripts VALUES (11791, 0, 3, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 11, 15657, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - Behind Target - Cast Backstab');

-- Cavern Shambler (12224)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12224;
DELETE FROM smart_scripts WHERE entryorguid=12224 AND source_type=0;
INSERT INTO smart_scripts VALUES (12224, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 16000, 16000, 11, 7948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cavern Shambler - In Combat - Cast Wild Regeneration');
INSERT INTO smart_scripts VALUES (12224, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 11500, 20000, 11, 16790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cavern Shambler - In Combat - Cast Knockdown');

-- Cavern Lurker (12223)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12223;
DELETE FROM smart_scripts WHERE entryorguid=12223 AND source_type=0;
INSERT INTO smart_scripts VALUES (12223, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 8000, 13000, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cavern Lurker - In Combat - Cast Knockdown');

-- Noxious Slime (12221)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12221;
DELETE FROM smart_scripts WHERE entryorguid=12221 AND source_type=0;
INSERT INTO smart_scripts VALUES (12221, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 10000, 15000, 11, 21070, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxious Slime - In Combat - Cast Noxious Cloud');

-- Sister of Celebras (11794)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11794;
DELETE FROM smart_scripts WHERE entryorguid=11794 AND source_type=0;
INSERT INTO smart_scripts VALUES (11794, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 2000, 2000, 11, 15795, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sister of Celebras - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (11794, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 5000, 8000, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sister of Celebras - In Combat - Cast Strike');

-- Stolid Snapjaw (13599)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=13599;
DELETE FROM smart_scripts WHERE entryorguid=13599 AND source_type=0;
INSERT INTO smart_scripts VALUES (13599, 0, 0, 0, 1, 0, 100, 1, 0, 0, 1000, 1000, 11, 14104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stolid Snapjaw - Out of Combat - Cast Spikes');

-- Deep Borer (11789)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=11789;
DELETE FROM smart_scripts WHERE entryorguid=11789 AND source_type=0;

-- Thessala Hydra (12207)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12207;
DELETE FROM smart_scripts WHERE entryorguid=12207 AND source_type=0;
INSERT INTO smart_scripts VALUES (12207, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 21788, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - On Reset - Cast Deadly Poison');
INSERT INTO smart_scripts VALUES (12207, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (12207, 0, 2, 0, 0, 0, 100, 0, 1000, 9000, 11000, 20000, 11, 21790, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - In Combat - Cast Aqua Jet');

-- Subterranean Diemetradon (13323)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=13323;
DELETE FROM smart_scripts WHERE entryorguid=13323 AND source_type=0;
INSERT INTO smart_scripts VALUES (13323, 0, 0, 0, 0, 0, 100, 0, 1000, 10000, 10000, 20000, 11, 8281, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Subterranean Diemetradon - In Combat - Cast Sonic Burst');

-- Theradrim Guardian (11784)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11784;
DELETE FROM smart_scripts WHERE entryorguid=11784 AND source_type=0;
INSERT INTO smart_scripts VALUES (11784, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 21057, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theradrim Guardian - Out of Combat - Cast Summon Theradrim Shardling');
INSERT INTO smart_scripts VALUES (11784, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 8000, 14000, 11, 16790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Theradrim Guardian - In Combat - Cast Knockdown');

-- Theradrim Guardian (11783)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=11783);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11783);
DELETE FROM creature WHERE id=11783;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11783;
DELETE FROM smart_scripts WHERE entryorguid=11783 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(11783*100+0, 11783*100+1, 11783*100+2, 11783*100+3, 11783*100+4, 11783*100+5, 11783*100+6) AND source_type=9;
INSERT INTO smart_scripts VALUES (11783, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 5000, 11000, 11, 13584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Theradrim Guardian - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (11783, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 88, 11783*100+0, 11783*100+6, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theradrim Shardling - Out of Combat - Start Script');
INSERT INTO smart_scripts VALUES (11783, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Theradrim Guardian - Is Summoned By - Attack Start');
INSERT INTO smart_scripts VALUES (11783*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 90, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');
INSERT INTO smart_scripts VALUES (11783*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 120, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');
INSERT INTO smart_scripts VALUES (11783*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 150, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');
INSERT INTO smart_scripts VALUES (11783*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 180, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');
INSERT INTO smart_scripts VALUES (11783*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 210, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');
INSERT INTO smart_scripts VALUES (11783*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 240, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');
INSERT INTO smart_scripts VALUES (11783*100+6, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 2, 270, 0, 0, 0, 0, 19, 11784, 10, 0, 0, 0, 0, 0, 'Theradrim Shardling - Script9 - Start Follow Closest Creature Theradrim Guardian');

-- Primordial Behemoth (12206)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12206;
DELETE FROM smart_scripts WHERE entryorguid=12206 AND source_type=0;
INSERT INTO smart_scripts VALUES (12206, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 8000, 14000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Primordial Behemoth - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (12206, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 11000, 16000, 11, 21071, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Primordial Behemoth - In Combat - Cast Boulder');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Noxxion (13282)
UPDATE creature_template SET mechanic_immune_mask=10258, dmgschool=3, AIName='SmartAI', ScriptName='' WHERE entry=13282;
DELETE FROM smart_scripts WHERE entryorguid=13282 AND source_type=0;
INSERT INTO smart_scripts VALUES (13282, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 13000, 13000, 11, 21687, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - In Combat - Cast Toxic Volley');
INSERT INTO smart_scripts VALUES (13282, 0, 1, 0, 0, 0, 100, 0, 9000, 14000, 13000, 13000, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES (13282, 0, 2, 3, 2, 0, 100, 1, 0, 50, 0, 0, 11, 21707, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - Health Between 0-50% - Cast Summon Noxxion''s Spawns');
INSERT INTO smart_scripts VALUES (13282, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 21708, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - Health Between 0-50% - Cast Summon Noxxion''s Spawns');
INSERT INTO smart_scripts VALUES (13282, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - Health Between 0-50% - Reset Counter');
INSERT INTO smart_scripts VALUES (13282, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - Health Between 0-50% - Set Unit Flag');
INSERT INTO smart_scripts VALUES (13282, 0, 6, 0, 35, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - Summoned Creature Despawn - Set Counter');
INSERT INTO smart_scripts VALUES (13282, 0, 7, 11, 77, 0, 100, 0, 1, 5, 0, 0, 28, 21708, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - On Counter Set - Remove Aura');
INSERT INTO smart_scripts VALUES (13282, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 32906, 178570, 0, 0, 0, 0, 0, 'Noxxion - On Just Died - Set GO State');
INSERT INTO smart_scripts VALUES (13282, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - On Just Died - Set Instance Data 0 to 3');
INSERT INTO smart_scripts VALUES (13282, 0, 10, 11, 25, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 11, 13456, 100, 0, 0, 0, 0, 0, 'Noxxion - On Reset - Despawn Minions');
INSERT INTO smart_scripts VALUES (13282, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Noxxion - On Reset - Remove Unit Flag');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=13282;
INSERT INTO conditions VALUES(22, 7, 13282, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Run action if invoker is alive');
DELETE FROM spell_script_names WHERE spell_id IN(21708);
INSERT INTO spell_script_names VALUES(21708, 'spell_gen_visual_dummy_stun');

-- Noxxion's Spawn (13456)
DELETE FROM creature_loot_template WHERE entry=13456;
UPDATE creature_template SET dmgschool=3, lootid=0, AIName='SmartAI', ScriptName='' WHERE entry=13456;
DELETE FROM smart_scripts WHERE entryorguid=13456 AND source_type=0;
INSERT INTO smart_scripts VALUES (13456, 0, 0, 0, 6, 0, 100, 257, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Noxxion''s Spawn - On Death - Set Counter');

-- Razorlash (12258)
REPLACE INTO creature_template_addon VALUES (12258, 0, 0, 0, 4097, 0, '21911');
UPDATE creature_template SET mechanic_immune_mask=10258, AIName='SmartAI', ScriptName='' WHERE entry=12258;
DELETE FROM smart_scripts WHERE entryorguid=12258 AND source_type=0;
INSERT INTO smart_scripts VALUES (12258, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorlash - In Combat - Cast Cleave');

-- Lord Vyletongue (12236)
UPDATE creature_template SET mechanic_immune_mask=10258, AIName='SmartAI', ScriptName='' WHERE entry=12236;
DELETE FROM smart_scripts WHERE entryorguid=12236 AND source_type=0;
INSERT INTO smart_scripts VALUES (12236, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Vyletongue - On Reset - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (12236, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Vyletongue - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (12236, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 21390, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Vyletongue - In Combat - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES (12236, 0, 3, 0, 0, 0, 100, 0, 15000, 15000, 15000, 15000, 11, 21655, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Vyletongue - In Combat - Cast Blink');
INSERT INTO smart_scripts VALUES (12236, 0, 4, 0, 0, 0, 100, 0, 13000, 13000, 15000, 15000, 11, 7964, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Vyletongue - In Combat - Cast Smoke Bomb');

-- Celebras the Cursed (12225)
UPDATE creature_template SET mechanic_immune_mask=10258, AIName='SmartAI', ScriptName='' WHERE entry=12225;
DELETE FROM smart_scripts WHERE entryorguid=12225 AND source_type=0;
INSERT INTO smart_scripts VALUES (12225, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 3500, 11, 21807, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Celebras the Cursed - In Combat - Cast Wrath');
INSERT INTO smart_scripts VALUES (12225, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 27000, 41000, 11, 21793, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Celebras the Cursed - In Combat - Cast Twisted Tranquility');
INSERT INTO smart_scripts VALUES (12225, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 25000, 45000, 11, 21968, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Celebras the Cursed - In Combat - Cast Corrupt Forces of Nature');
INSERT INTO smart_scripts VALUES (12225, 0, 3, 0, 0, 0, 100, 0, 4000, 14000, 15000, 15000, 11, 12747, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Celebras the Cursed - In Combat - Cast Entangling Roots');
INSERT INTO smart_scripts VALUES (12225, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 12, 13716, 8, 0, 0, 0, 0, 8, 0, 0, 0, 726.10, 77.976, -86.59, 6.00, 'Celebras the Cursed - On Death - Summon Creature');

-- Corrupt Force of Nature (13743)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=13743;
DELETE FROM smart_scripts WHERE entryorguid=13743 AND source_type=0;

-- Landslide (12203)
UPDATE creature_template SET mechanic_immune_mask=8210, AIName='SmartAI', ScriptName='' WHERE entry=12203;
DELETE FROM smart_scripts WHERE entryorguid=12203 AND source_type=0;
INSERT INTO smart_scripts VALUES (12203, 0, 0, 0, 0, 0, 100, 0, 12000, 17000, 25000, 35000, 11, 21808, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Landslide - In Combat - Cast Landslide');
INSERT INTO smart_scripts VALUES (12203, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 12000, 15000, 11, 18670, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Landslide - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (12203, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 8000, 15000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Landslide - In Combat - Cast Trample');
DELETE FROM spell_script_names WHERE spell_id IN(21809);
INSERT INTO spell_script_names VALUES(21809, 'spell_gen_random_target32');

-- Tinkerer Gizlock (13601)
DELETE FROM creature_text WHERE entry=13601;
INSERT INTO creature_text VALUES (13601, 0, 0, 'Mine! Mine! Mine! Gizlock is the ruler of this domain! You shall never reveal my presence!', 12, 0, 100, 0, 0, 0, 0, 'Tinkerer Gizlock');
UPDATE creature_template SET mechanic_immune_mask=10258, AIName='SmartAI', ScriptName='' WHERE entry=13601;
DELETE FROM smart_scripts WHERE entryorguid=13601 AND source_type=0;
INSERT INTO smart_scripts VALUES (13601, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tinkerer Gizlock - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (13601, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tinkerer Gizlock - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (13601, 0, 2, 0, 0, 0, 100, 0, 6000, 9000, 12000, 15000, 11, 9143, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Tinkerer Gizlock - In Combat - Cast Bomb');
INSERT INTO smart_scripts VALUES (13601, 0, 3, 0, 0, 0, 100, 0, 10000, 13000, 15000, 20000, 11, 29419, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Tinkerer Gizlock - In Combat - Cast Flash Bomb');
INSERT INTO smart_scripts VALUES (13601, 0, 4, 0, 0, 0, 100, 0, 14000, 20000, 25000, 32000, 11, 21833, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tinkerer Gizlock - In Combat - Cast Goblin Dragon Gun');

-- Rotgrip (13596)
UPDATE creature_template SET mechanic_immune_mask=10258, AIName='SmartAI', ScriptName='' WHERE entry=13596;
DELETE FROM smart_scripts WHERE entryorguid=13596 AND source_type=0;
INSERT INTO smart_scripts VALUES (13596, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 21911, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotgrip - On Reset - Cast Puncture');
INSERT INTO smart_scripts VALUES (13596, 0, 1, 0, 12, 0, 100, 0, 0, 20, 9000, 14000, 11, 16495, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rotgrip - Target Between 0-20% Health - Cast Fatal Bite');

-- Princess Theradras (12201)
UPDATE creature_template SET mechanic_immune_mask=10258, AIName='SmartAI', ScriptName='' WHERE entry=12201;
DELETE FROM smart_scripts WHERE entryorguid=12201 AND source_type=0;
INSERT INTO smart_scripts VALUES (12201, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (12201, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 16000, 19000, 11, 21832, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast Boulder');
INSERT INTO smart_scripts VALUES (12201, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 21909, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast Dust Field');
INSERT INTO smart_scripts VALUES (12201, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 21869, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast Repulsive Gaze');
INSERT INTO smart_scripts VALUES (12201, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 12, 12238, 8, 0, 0, 0, 0, 8, 0, 0, 0, 28.067, 61.875, -123.405, 4.67, 'Princess Theradras - On Death - Summon Creature');

-- Zaetar's Spirit (12238)
DELETE FROM creature_text WHERE entry=12238;
INSERT INTO creature_text VALUES (12238, 0, 0, 'Free! Free from my bonds at last!', 14, 0, 100, 0, 0, 0, 0, 'Zaetar''s Spirit');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12238;
DELETE FROM smart_scripts WHERE entryorguid=12238 AND source_type=0;
INSERT INTO smart_scripts VALUES (12238, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zaetar''s Spirit - On AI Init - Say Line 0');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Spirit of Veng (12243)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12243;
DELETE FROM smart_scripts WHERE entryorguid=12243 AND source_type=0;
INSERT INTO smart_scripts VALUES (12243, 0, 0, 0, 8, 0, 100, 0, 21960, 0, 0, 0, 36, 13738, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Veng - On Spellhit Manifest Spirit - Update Template To Veng');
INSERT INTO smart_scripts VALUES (12243, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 15547, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Veng - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (12243, 0, 2, 0, 0, 0, 100, 0, 4000, 9000, 10000, 17000, 11, 14443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Veng - In Combat - Cast Multi-Shot');

-- Spirit of Maraudos (12242)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12242;
DELETE FROM smart_scripts WHERE entryorguid=12242 AND source_type=0;
INSERT INTO smart_scripts VALUES (12242, 0, 0, 0, 8, 0, 100, 0, 21960, 0, 0, 0, 36, 13739, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Maraudos - On Spellhit Manifest Spirit - Update Template To Maraudos');
INSERT INTO smart_scripts VALUES (12242, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 15795, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Maraudos - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (12242, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Maraudos - In Combat - Cast Sinister Strike');

-- GO Larva Spewer (178559)
UPDATE gameobject_template SET type=10, faction=35, data3=8000, data5=1, data6=0, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=178559;
DELETE FROM smart_scripts WHERE entryorguid=178559 AND source_type=1;
INSERT INTO smart_scripts VALUES (178559, 1, 0, 0, 8, 0, 100, 0, 8386, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Larva Spewer - Spell Hit - Set Event Phase');
INSERT INTO smart_scripts VALUES (178559, 1, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Larva Spewer - On Spawn - Set Event Phase');
INSERT INTO smart_scripts VALUES (178559, 1, 2, 0, 60, 1, 100, 0, 3000, 3000, 40000, 40000, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Larva Spewer - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178559, 1, 3, 0, 60, 1, 100, 0, 6400, 6400, 40000, 40000, 12, 13533, 4, 90000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Larva Spewer - On Update - Summon Creature Spewed Larva');

-- GO Spore Tree (178561, 178562, 178563, 178564, 178565, 178566, 178567, 178568, 178569)
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry IN(178561, 178562, 178563, 178564, 178565, 178566, 178567, 178568, 178569);
DELETE FROM smart_scripts WHERE entryorguid IN(178561, 178562, 178563, 178564, 178565, 178566, 178567, 178568, 178569) AND source_type=1;
INSERT INTO smart_scripts VALUES (178561, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178561, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178561, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178562, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178562, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178562, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178563, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178563, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178563, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178564, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178564, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178564, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178565, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178565, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178565, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178566, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178566, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178566, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178567, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178567, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178567, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178568, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178568, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178568, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (178569, 1, 0, 1, 60, 0, 100, 0, 0, 30000, 30000, 30000, 93, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Send Custom Anim');
INSERT INTO smart_scripts VALUES (178569, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Update - Create Timed Event');
INSERT INTO smart_scripts VALUES (178569, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 21547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Tree - On Timed Event - Cast Spore Cloud');

-- Quest The Scepter of Celebras (7046)
DELETE FROM creature_text WHERE entry=13716;
INSERT INTO creature_text VALUES (13716, 0, 0, "You wish to learn of the stone? Follow me.", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
INSERT INTO creature_text VALUES (13716, 1, 0, "For so long I have drifted in my cursed form. You have freed me... Your hard work shall be repaid.", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
INSERT INTO creature_text VALUES (13716, 2, 0, "Please do as I instruct you, $N", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
INSERT INTO creature_text VALUES (13716, 3, 0, "Read this tome I have placed before you, and speak the words aloud.", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
INSERT INTO creature_text VALUES (13716, 4, 0, "Together, the two parts shall become one, once again.", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
INSERT INTO creature_text VALUES (13716, 5, 0, "Shal myrinan ishnu daldorah...", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
INSERT INTO creature_text VALUES (13716, 6, 0, "My scepter will once again become whole!", 12, 0, 100, 0, 0, 0, 0, "Celebras the Redeemed");
UPDATE creature_template SET speed_walk=1.2, AIName='SmartAI' WHERE entry=13716;
DELETE FROM smart_scripts WHERE entryorguid=13716 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(13716*100, 13716*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (13716, 0, 0, 0, 19, 0, 100, 0, 7046, 0, 0, 0, 80, 13716*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Script9');
INSERT INTO smart_scripts VALUES (13716, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 13716*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Script9');
INSERT INTO smart_scripts VALUES (13716*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flags');
INSERT INTO smart_scripts VALUES (13716*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (13716*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 712.26, 81.83, -87.9, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 655.65, 84.7, -86.84, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100, 9, 5, 0, 0, 0, 100, 0, 11500, 11500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 4.35, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (13716*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Walk');
INSERT INTO smart_scripts VALUES (13716*100, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 657.72, 73.414, -86.8, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 3.0, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (13716*100, 9, 11, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 21916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (13716*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100, 9, 13, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 178965, 240, 0, 0, 0, 0, 8, 0, 0, 0, 653.45, 73.9, -85.86, 3.0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 0, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Auras');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 178964, 20, 0, 0, 0, 0, 8, 0, 0, 0, 653.45, 73.9, -85.86, 3.0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 653.45, 73.9, -85.86, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 4, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 657.72, 73.414, -86.8, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 655.65, 84.7, -86.84, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 26, 7046, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (13716*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=21950;
INSERT INTO conditions VALUES (13, 1, 21950, 0, 0, 31, 0, 5, 178560, 0, 0, 0, 0, '', 'Target StaffCreator');
UPDATE gameobject_template SET data2=240000 WHERE entry=178560;
UPDATE gameobject_template SET flags=0, data2=240000, AIName='SmartGameObjectAI' WHERE entry=178965;
DELETE FROM smart_scripts WHERE entryorguid=178965 AND source_type=1;
INSERT INTO smart_scripts VALUES (178965, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 85, 21950, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Invoker Cast');
INSERT INTO smart_scripts VALUES (178965, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 13716, 30, 0, 0, 0, 0, 0, 'On Go State - Set Data');

-- Meshlok the Harvester (12237)
DELETE FROM pool_template WHERE entry=202481;
DELETE FROM pool_creature WHERE pool_entry=202481;
DELETE FROM creature WHERE map=349 AND id=12999;
DELETE FROM creature WHERE guid=160506 AND id=12237;
UPDATE pool_creature SET guid=203506 WHERE guid=160506 AND pool_entry=1211;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12237;
DELETE FROM smart_scripts WHERE entryorguid=12237 AND source_type=0;
INSERT INTO smart_scripts VALUES (12237, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 5000, 7000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Meshlok the Harvester - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (12237, 0, 1, 0, 0, 0, 100, 0, 4000, 15000, 18500, 24000, 11, 15593, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Meshlok the Harvester - In Combat - Cast War Stomp');
