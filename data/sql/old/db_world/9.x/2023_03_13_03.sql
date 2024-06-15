-- DB update 2023_03_13_02 -> 2023_03_13_03
-- DELETE all old stuff
DELETE FROM `creature` WHERE `map`=554 AND `id1` IN (19166,19167,19168,19218,19219,19220,19221,19231,19510,19710,19712,19713,19716,19735,20059,20988,20990) AND `guid` IN (67872,75951,83160,83161,83162,83163,83164,83165,83166,83167,83168,83169,83170,83171,83172,83173,83174,83175,83176,83177,83178,83179,83180,83182,83183,83185,83186,83187,83188,83189,83190,83191,83192,83193,83194,83195,83196,83197,83198,83199,83200,83201,83202,83203,83204,83205,83207,83208,83209,83210,83211,83212,83213,83214,83215,83216,83217,83218,83219,83220,83221,83222,83223,83224,83225,83226,83227,83228,83229,83230,83231,83232,83233,83234,83235,83236,83239,83240,83241,83245,87087,88276);
DELETE FROM `creature_addon` WHERE `guid` IN (83160,83162,83163,83166,83167,83168,83170,83171,83173,83177,83180,83182,83183,83189,83195,83197,83200,83201,83202,83203,83208,83210,83211,83212,83213,83219,83220,83221,83222,83223,83224,83229,83233,83234,83239,83240);
DELETE FROM `waypoint_data` WHERE `id` IN (831600,831680,831730,831770,831800,831890,831950,831970,832080,832130,832210,832240,832290,832330,832340,832390,832400);
DELETE FROM `linked_respawn` WHERE `linkedGuid` IN (83160, 83230, 83241) AND `guid` IN (67872,75951,83160,83161,83162,83163,83164,83165,83166,83167,83168,83169,83170,83171,83172,83173,83174,83175,83176,83177,83178,83179,83180,83182,83183,83185,83186,83187,83188,83189,83190,83191,83192,83193,83194,83195,83196,83197,83198,83199,83200,83201,83202,83203,83204,83205,83207,83208,83209,83210,83211,83212,83213,83214,83215,83216,83217,83218,83219,83220,83221,83222,83223,83224,83225,83226,83227,83228,83229,83230,83231,83232,83233,83234,83235,83236,83239,83240,83241,83245,87087,88276);
DELETE FROM `waypoint_scripts` WHERE `id` IN (8319501, 8319502, 8319701, 8319702) AND `guid` IN (817, 818, 819, 820);

DELETE FROM `gameobject` WHERE `map`=554 AND `id` IN (185015,185018,184449,184632,184322,184465) AND `guid` IN (6032,6033,6034,20463,20464,20467,20473,44743);

-- INSERTS
SET @CGUID := 138800;
SET @OGUID := 9879;

DELETE FROM `creature` WHERE `map`=554 AND `id1` IN (19166,19167,19168,19218,19219,19220,19221,19231,19510,19710,19712,19713,19716,19735,20059,20988,20990) AND `guid` BETWEEN @CGUID AND @CGUID+93;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID+0 , 19166, 0, 0, 554, 3849, 3849, 3, 1, 0, 39.9918, 28.693, 0.0795518, 3.41476, 86400, 5, 1, 46924),
(@CGUID+1 , 19166, 0, 0, 554, 3849, 3849, 3, 1, 0, 86.0605, 59.588, 14.9247, 3.13951, 86400, 5, 1, 46924),
(@CGUID+2 , 19166, 0, 0, 554, 3849, 3849, 3, 1, 0, 43.5209, -25.3947, 0.0803467, 2.93692, 86400, 5, 1, 46924),
(@CGUID+3 , 19166, 0, 0, 554, 3849, 3849, 3, 1, 0, 82.6466, -56.3472, 14.9439, 3.1402, 86400, 5, 1, 46924),
(@CGUID+4 , 19166, 0, 0, 554, 3849, 3849, 3, 1, 0, 30.2197, 2.91536, 0.0823943, 3.29867, 86400, 0, 0, 46924),
(@CGUID+5 , 19166, 0, 0, 554, 3849, 3849, 3, 1, 0, 123.694, 77.4065, 14.2275, 0.146938, 86400, 0, 0, 46924),
(@CGUID+6 , 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 77.9033, -51.9803, 15.008, 3.31613, 86400, 0, 0, 46924),
(@CGUID+7 , 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 37.398, 64.646, 0.246395, 4.13643, 86400, 0, 0, 46924),
(@CGUID+8 , 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 37.175, -51.869, 0.246396, 4.11898, 86400, 0, 0, 46924),
(@CGUID+9 , 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 30.7244, -48.3542, 0.24584, 2.20191, 86400, 0, 0, 46924),
(@CGUID+10, 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 77.8174, 64.1236, 15.008, 3.26377, 86400, 0, 0, 46924),
(@CGUID+11, 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 119.345, 85.9118, 15.0163, 3.45575, 86400, 0, 0, 46924),
(@CGUID+12, 19167, 0, 0, 554, 3849, 3849, 3, 1, 1, 120.598, -65.5737, 15.008, 3.24631, 86400, 0, 0, 46924),
(@CGUID+13, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 226.571, 60.2797, 0.0791843, 3.08923, 86400, 0, 0, 46924),
(@CGUID+14, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 226.595, 45.0895, 0.0768293, 3.1765, 86400, 0, 0, 46924),
(@CGUID+15, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 309.388, 5.29271, 25.5154, 3.29867, 86400, 0, 0, 46924),
(@CGUID+16, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 309.331, 15.1339, 25.4695, 3.07178, 86400, 0, 0, 46924),
(@CGUID+17, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 240.799, -25.2161, 26.4117, 0.244346, 86400, 0, 0, 46924),
(@CGUID+18, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 237.38, -21.1149, 26.4117, 0, 86400, 0, 0, 46924),
(@CGUID+19, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 137.99, 37.2705, 24.9578, 5.53269, 86400, 0, 0, 46924),
(@CGUID+20, 19168, 0, 0, 554, 3849, 3849, 3, 1, 0, 135.331, 99.9644, 26.4566, 4.78385, 86400, 0, 0, 46924),
(@CGUID+21, 19218, 0, 0, 554, 3849, 3849, 3, 1, 0, 85.5276, 20.2005, 15.0044, 0.663225, 86400, 0, 0, 46924),
(@CGUID+22, 19219, 0, 0, 554, 3849, 3849, 3, 1, 0, 208.226, -13.0494, -2.11654, 3.36498, 86400, 0, 0, 46924),
(@CGUID+23, 19220, 0, 0, 554, 3849, 3849, 3, 1, 1, 139.542, 149.319, 25.659, 4.59022, 86400, 0, 0, 46924),
(@CGUID+24, 19221, 0, 0, 554, 3849, 3849, 3, 1, 1, 326.517, 13.1959, 27.9199, 3.22886, 86400, 0, 0, 46924),
(@CGUID+25, 19231, 0, 0, 554, 3849, 3849, 3, 1, 0, 107.9, -80.6756, 15.0131, 2.02913, 86400, 0, 0, 46924),
(@CGUID+26, 19510, 0, 0, 554, 3849, 3849, 3, 1, 1, 165.844, -73.6567, 1.72647, 3.24631, 86400, 0, 0, 46924),
(@CGUID+27, 19510, 0, 0, 554, 3849, 3849, 3, 1, 1, 30.6969, 49.5821, 0.244368, 3.7001, 86400, 0, 0, 46924),
(@CGUID+28, 19510, 0, 0, 554, 3849, 3849, 3, 1, 1, 165.7, 85.5581, 1.76883, 3.21141, 86400, 0, 0, 46924),
(@CGUID+29, 19510, 0, 0, 554, 3849, 3849, 3, 1, 1, 309.243, 10.2549, 25.4695, 3.1765, 86400, 0, 0, 46924),
(@CGUID+30, 19510, 0, 0, 554, 3849, 3849, 3, 1, 1, 309.518, 20.2797, 25.4735, 2.70526, 86400, 0, 0, 46924),
(@CGUID+31, 19510, 0, 0, 554, 3849, 3849, 3, 1, 0, 233.939, -18.6746, 26.4117, 5.96903, 86400, 0, 0, 46924),
(@CGUID+32, 19710, 0, 0, 554, 3849, 3849, 3, 1, 0, 198.356, -67.8971, 0.0848416, 3.48411, 86400, 0, 0, 46924),
(@CGUID+33, 19712, 0, 0, 554, 3849, 3849, 3, 1, 0, 223.733, -62.9849, 0.0856803, 5.044, 86400, 0, 0, 46924),
(@CGUID+34, 19712, 0, 0, 554, 3849, 3849, 3, 1, 0, 214.792, -83.1537, 0.0890533, 5.51524, 86400, 0, 0, 46924),
(@CGUID+35, 19712, 0, 0, 554, 3849, 3849, 3, 1, 0, 109.621, -55.2714, 15.0071, 0.680678, 86400, 0, 0, 46924),
(@CGUID+36, 19712, 0, 0, 554, 3849, 3849, 3, 1, 0, 108.424, -42.7796, 15.008, 5.16617, 86400, 0, 0, 46924),
(@CGUID+37, 19712, 0, 0, 554, 3849, 3849, 3, 1, 0, 144.53, 44.9373, 0.0829073, 4.79966, 86400, 0, 0, 46924),
(@CGUID+38, 19712, 0, 0, 554, 3849, 3849, 3, 1, 0, 216.179, -95.2042, 0.0891693, 0.20944, 86400, 0, 0, 46924),
(@CGUID+39, 19713, 0, 0, 554, 3849, 3849, 3, 1, 0, 165.639, -19.8589, 0.0833333, 5.88176, 86400, 0, 0, 46924),
(@CGUID+40, 19713, 0, 0, 554, 3849, 3849, 3, 1, 0, 109.46, 58.5753, 15.008, 5.28835, 86400, 0, 0, 46924),
(@CGUID+41, 19713, 0, 0, 554, 3849, 3849, 3, 1, 0, 174.125, -17.4886, 0.0833343, 3.9619, 86400, 0, 0, 46924),
(@CGUID+42, 19713, 0, 0, 554, 3849, 3849, 3, 1, 0, 227.934, -52.085, 0.0838403, 0.0523599, 86400, 0, 0, 46924),
(@CGUID+43, 19713, 0, 0, 554, 3849, 3849, 3, 1, 0, 112.692, 45.9758, 15.008, 1.01229, 86400, 0, 0, 46924),
(@CGUID+44, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 192.838, 35.695, 0.0776353, 4.85202, 86400, 0, 0, 46924),
(@CGUID+45, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 92.3548, -79.2986, 15.008, 5.18363, 86400, 0, 0, 46924),
(@CGUID+46, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 185.819, 35.824, 0.0775393, 4.76475, 86400, 0, 0, 46924),
(@CGUID+47, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 152.633, 53.3561, 0.0794043, 2.68781, 86400, 0, 0, 46924),
(@CGUID+48, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 160.69, -16.6626, 0.0833323, 2.0944, 86400, 5, 1, 46924),
(@CGUID+49, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 139.926, -38.9455, 0.0833333, 0.401426, 86400, 5, 1, 46924),
(@CGUID+50, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 140.177, 50.3653, 0.0811923, 0.907571, 86400, 0, 0, 46924),
(@CGUID+51, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 207.592, -91.1401, 0.0897743, 1.25222, 86400, 5, 1, 46924),
(@CGUID+52, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 180.165, 34.5334, 0.0769383, 4.45059, 86400, 0, 0, 46924),
(@CGUID+53, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 99.9308, -77.9516, 15.0108, 3.92699, 86400, 0, 0, 46924),
(@CGUID+54, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 168.528, -11.8862, 0.0833323, 0.488692, 86400, 5, 1, 46924),
(@CGUID+55, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 210.235, -85.4583, 0.066388, 4.78067, 86400, 0, 0, 46924),
(@CGUID+56, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 134.556, 45.1142, 0.0833333, 1.32645, 86400, 0, 0, 46924),
(@CGUID+57, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 133.419, -40.7442, 0.0833333, 5.67232, 86400, 5, 1, 46924),
(@CGUID+58, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 194.141, 40.2341, 0.0177968, 2.08684, 86400, 0, 0, 46924),
(@CGUID+59, 19716, 0, 0, 554, 3849, 3849, 3, 1, 0, 106.416, 51.6837, 14.938, 2.98083, 86400, 4, 1, 46924),
(@CGUID+60, 19735, 0, 0, 554, 3849, 3849, 3, 1, 0, 230.693, 52.4542, 0.0696908, 3.11984, 86400, 0, 0, 46924),
(@CGUID+61, 19735, 0, 0, 554, 3849, 3849, 3, 1, 0, 290.619, 29.1206, 25.4695, 1.69297, 86400, 0, 0, 46924),
(@CGUID+62, 19735, 0, 0, 554, 3849, 3849, 3, 1, 0, 293.918, -14.8507, 25.3827, 5.15386, 86400, 6, 1, 46924),
(@CGUID+63, 19735, 0, 0, 554, 3849, 3849, 3, 1, 0, 199.945, -22.8589, 24.9578, 0.122173, 86400, 0, 0, 46924),
(@CGUID+64, 19735, 0, 0, 554, 3849, 3849, 3, 1, 0, 137.827, 53.1813, 24.9578, 4.76475, 86400, 0, 0, 46924),
(@CGUID+65, 20059, 0, 0, 554, 3849, 3849, 3, 1, 1, 169.258, -68.094, 0.665288, 3.26377, 86400, 0, 0, 46924),
(@CGUID+66, 20059, 0, 0, 554, 3849, 3849, 3, 1, 1, 31.8311, 47.3686, 0.17648, 4.48464, 86400, 0, 2, 46924),
(@CGUID+67, 20059, 0, 0, 554, 3849, 3849, 3, 1, 1, 31.6824, -47.6501, 0.226791, 1.71503, 86400, 0, 2, 46924),
(@CGUID+68, 20059, 0, 0, 554, 3849, 3849, 3, 1, 1, 169.373, 92.1162, 0.659512, 3.35103, 86400, 0, 0, 46924),
(@CGUID+69, 20059, 0, 0, 554, 3849, 3849, 3, 1, 1, 141.398, 102.786, 26.4566, 4.69415, 86400, 0, 0, 46924),
(@CGUID+70, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 219.266, -55.7564, 0.0853493, 0.112572, 86400, 0, 0, 46924),
(@CGUID+71, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 131.681, 40.4787, 0.0833343, 1.95375, 86400, 6, 1, 46924),
(@CGUID+72, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 138.933, -32.3032, 0.0833333, 4.71239, 86400, 5, 1, 46924),
(@CGUID+73, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 101.908, -49.5597, 14.9791, 1.46291, 86400, 0, 0, 46924),
(@CGUID+74, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 131.22, -37.1084, 0.0833343, 3.9968, 86400, 6, 1, 46924),
(@CGUID+75, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 101.384, 48.1969, 14.9245, 1.4887, 86400, 0, 0, 46924),
(@CGUID+76, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 178.821, -17.3697, 24.9578, 6.18119, 86400, 0, 0, 46924),
(@CGUID+77, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 176.685, -26.0102, 24.9578, 0.0526762, 86400, 0, 0, 46924),
(@CGUID+78, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 142.533, 40.6933, 24.9578, 5.23599, 86400, 0, 0, 46924),
(@CGUID+79, 20988, 0, 0, 554, 3849, 3849, 3, 1, 0, 140.828, 112.036, 26.4566, 4.70349, 86400, 0, 0, 46924),
(@CGUID+80, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 77.5823, 55.4032, 15.008, 3.19395, 86400, 0, 0, 46924),
(@CGUID+81, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 77.945, -60.8388, 15.008, 3.47321, 86400, 0, 0, 46924),
(@CGUID+82, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 168.96, -87.2767, 0.789825, 3.19395, 86400, 0, 0, 46924),
(@CGUID+83, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 37.4107, 54.8215, 0.246395, 2.3911, 86400, 0, 0, 46924),
(@CGUID+84, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 37.4608, -60.7909, 0.246396, 2.6529, 86400, 0, 0, 46924),
(@CGUID+85, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 30.8606, -46.8067, 0.236338, 0.676204, 86400, 0, 0, 46924),
(@CGUID+86, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 33.7581, 49.8961, 0.242408, 5.72468, 86400, 0, 0, 46924),
(@CGUID+87, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 120.378, -82.3034, 15.0098, 3.21141, 86400, 0, 0, 46924),
(@CGUID+88, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 165.423, 77.9691, 1.84254, 3.29867, 86400, 0, 0, 46924),
(@CGUID+89, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 119.44, 69.174, 15.008, 3.29867, 86400, 0, 0, 46924),
(@CGUID+90, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 235.291, -26.6432, 26.4117, 0, 86400, 0, 0, 46924),
(@CGUID+91, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 180.225, -22.4886, 24.9578, 6.27367, 86400, 0, 0, 46924),
(@CGUID+92, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 134.706, 41.1687, 24.9578, 5.58505, 86400, 0, 0, 46924),
(@CGUID+93, 20990, 0, 0, 554, 3849, 3849, 3, 1, 1, 134.306, 109.151, 26.4566, 4.78864, 86400, 0, 0, 46924);

DELETE FROM `gameobject` WHERE `map`=554 AND `id` IN (185015, 185018, 184632, 184322, 184449, 184465) AND `guid` BETWEEN @OGUID+0 AND @OGUID+11;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+0 , 185015, 554, 3849, 3849, 3, 1, 145.197906494140625, -44.5185165405273437, 1.009188055992126464, 2.740161895751953125, 0, 0, 0.979924201965332031, 0.199370384216308593, 7200, 255, 1, 46924),
(@OGUID+1 , 185015, 554, 3849, 3849, 3, 1, 148.266387939453125, -35.2500495910644531, 1.009233951568603515, 2.478367090225219726, 0, 0, 0.94551849365234375, 0.325568377971649169, 7200, 255, 1, 46924),
(@OGUID+2 , 185015, 554, 3849, 3849, 3, 1, 163.6997833251953125, -27.3792018890380859, 1.00893402099609375, 4.729844093322753906, 0, 0, -0.70090866088867187, 0.713251054286956787, 7200, 255, 1, 46924),
(@OGUID+3 , 185015, 554, 3849, 3849, 3, 1, 155.4228057861328125, -29.7321643829345703, 1.008820056915283203, 2.007128477096557617, 0, 0, 0.84339141845703125, 0.537299633026123046, 7200, 255, 1, 46924),
(@OGUID+4 , 185018, 554, 3849, 3849, 3, 1, 148.266387939453125, -35.2500495910644531, 1.009233951568603515, 2.478367090225219726, 0, 0, 0.94551849365234375, 0.325568377971649169, 7200, 255, 1, 46924),
(@OGUID+5 , 185018, 554, 3849, 3849, 3, 1, 145.197906494140625, -44.5185165405273437, 1.009188055992126464, 2.740161895751953125, 0, 0, 0.979924201965332031, 0.199370384216308593, 7200, 255, 1, 46924),
(@OGUID+6 , 185018, 554, 3849, 3849, 3, 1, 163.6997833251953125, -27.3792018890380859, 1.00893402099609375, 4.729844093322753906, 0, 0, -0.70090866088867187, 0.713251054286956787, 7200, 255, 1, 46924),
(@OGUID+7 , 185018, 554, 3849, 3849, 3, 1, 155.4228057861328125, -29.7321643829345703, 1.008820056915283203, 2.007128477096557617, 0, 0, 0.84339141845703125, 0.537299633026123046, 7200, 255, 1, 46924),
(@OGUID+8 , 184632, 554, 3849, 3849, 3, 1, 236.459716796875, 52.363555908203125, 1.653543949127197265, 3.141592741012573242, 0, 0, -1, 0, 7200, 255, 0, 46924),
(@OGUID+9 , 184322, 554, 3849, 3849, 3, 1, 242.873992919921875, 52.31481170654296875, 1.596333980560302734, 3.141592741012573242, 0, 0, -1, 0, 7200, 255, 0, 46924),
(@OGUID+10, 184449, 554, 3849, 3849, 3, 1, 267.928070068359375, 52.31480789184570312, 27.04253578186035156, 3.141592741012573242, 0, 0, -1, 0, 7200, 255, 0, 46924),
(@OGUID+11, 184465, 554, 3849, 3849, 3, 1, 222.5428009033203125, 70.61063385009765625, -0.00479338550940155, 4.677483558654785156, 0, 0, -0.71933937072753906, 0.694658815860748291, 7200, 255, 1, 46924);

SET @NPC := @CGUID+0;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=41.327057,`position_y`=29.448656,`position_z`=0.0061041107, `orientation`=3.263765573501586914 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,32.220608,26.515696,0.0071369237,NULL,0,0,0,100,0),
(@PATH,2,27.243652,18.831352,-0.0004997472,NULL,0,0,0,100,0),
(@PATH,3,24.297773,7.9234123,-0.00028621498,2.967059612274169921,9000,0,0,100,0),
(@PATH,4,28.086344,21.93921,-0.00050851365,NULL,0,0,0,100,0),
(@PATH,5,41.327057,29.448656,0.0061041107,3.263765573501586914,9000,0,0,100,0);

SET @NPC := @CGUID+2;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=43.611073,`position_y`=-26.751925,`position_z`=0.006033899, `orientation`=3.03687286376953125 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,35.5806,-23.746408,-0.0007913007,NULL,0,0,0,100,0),
(@PATH,2,28.923302,-18.143108,-0.0005735572,NULL,0,0,0,100,0),
(@PATH,3,26.356697,-5.9867935,-0.000380761,3.333578824996948242,9000,0,0,100,0),
(@PATH,4,29.69342,-15.448353,-0.00058285974,NULL,0,0,0,100,0),
(@PATH,5,35.844803,-23.9074,-0.0004889075,NULL,0,0,0,100,0),
(@PATH,6,43.611073,-26.751925,0.006033899,3.03687286376953125,9000,0,0,100,0);

SET @NPC := @CGUID+5;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=117.62223,`position_y`=78.36094,`position_z`=14.92448 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,117.62223,78.36094,14.92448,NULL,0,0,0,100,0),
(@PATH,2,149.63039,81.24523,6.4690247,NULL,0,0,0,100,0),
(@PATH,3,169.93733,81.2677,0.36944586,NULL,0,0,0,100,0),
(@PATH,4,188.18597,64.12248,-0.005838667,NULL,0,0,0,100,0),
(@PATH,5,186.61266,47.3467,-0.006220245,NULL,0,0,0,100,0),
(@PATH,6,164.64165,49.954487,-0.001837478,NULL,0,0,0,100,0),
(@PATH,7,186.61266,47.3467,-0.006220245,NULL,0,0,0,100,0),
(@PATH,8,188.18597,64.12248,-0.005838667,NULL,0,0,0,100,0),
(@PATH,9,169.93733,81.2677,0.36944586,NULL,0,0,0,100,0),
(@PATH,10,149.63039,81.24523,6.4690247,NULL,0,0,0,100,0);

-- Pathing for Mechanar Crusher Entry: 19231
SET @NPC := @CGUID+25;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=107.66785,`position_y`=-81.308876,`position_z`=14.931074 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,107.66785,-81.308876,14.931074,NULL,0,0,0,100,0),
(@PATH,2,105.08907,-74.979095,14.9298115,NULL,0,0,0,100,0),
(@PATH,3,96.893936,-71.07658,14.92652,NULL,0,0,0,100,0),
(@PATH,4,90.85117,-74.31637,14.926526,NULL,0,0,0,100,0),
(@PATH,5,96.893936,-71.07658,14.92652,NULL,0,0,0,100,0),
(@PATH,6,105.08907,-74.979095,14.9298115,NULL,0,0,0,100,0);

-- Pathing for Gatewatcher Iron-Hand Entry: 19710
SET @NPC := @CGUID+32;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=181.85164,`position_y`=-77.11685,`position_z`=0.0077276435 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,181.85164,-77.11685,0.0077276435,NULL,0,0,0,100,0),
(@PATH,2,167.87256,-78.7667,1.007633,NULL,0,0,0,100,0),
(@PATH,3,120.14774,-74.052536,14.927823,NULL,0,0,0,100,0),
(@PATH,4,167.87256,-78.7667,1.007633,NULL,0,0,0,100,0);

-- Pathing for Mechanar Driller Entry: 19712
SET @NPC := @CGUID+37;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=132.1031,`position_y`=37.008965,`position_z`=0.003121846 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,132.1031,37.008965,0.003121846,NULL,0,0,0,100,0),
(@PATH,2,142.23601,40.296707,0.005726555,NULL,0,0,0,100,0),
(@PATH,3,144.87463,45.93079,0.008017367,NULL,0,0,0,100,0),
(@PATH,4,158.54794,47.99082,0.0038790724,NULL,0,0,0,100,0),
(@PATH,5,161.00502,53.83562,0.003132181,NULL,0,0,0,100,0),
(@PATH,6,158.54794,47.99082,0.0038790724,NULL,0,0,0,100,0),
(@PATH,7,144.87463,45.93079,0.008017367,NULL,0,0,0,100,0),
(@PATH,8,142.23601,40.296707,0.005726555,NULL,0,0,0,100,0);

-- Pathing for Mechanar Tinkerer Entry: 19716
SET @NPC := @CGUID+58;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=197.70654,`position_y`=37.415173,`position_z`=-0.005917786 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,197.70654,37.415173,-0.005917786,NULL,0,0,0,100,0),
(@PATH,2,193.55858,41.26056,-0.0060337405,NULL,0,0,0,100,0),
(@PATH,3,185.691,41.82604,-0.006107603,NULL,0,0,0,100,0),
(@PATH,4,179.0216,40.52939,-0.006131659,NULL,0,0,0,100,0),
(@PATH,5,174.11919,37.801308,1.010456,NULL,0,0,0,100,0),
(@PATH,6,179.0216,40.52939,-0.006131659,NULL,0,0,0,100,0),
(@PATH,7,185.691,41.82604,-0.006107603,NULL,0,0,0,100,0),
(@PATH,8,193.55858,41.26056,-0.0060337405,NULL,0,0,0,100,0);

-- Pathing for Mechanar Tinkerer Entry: 19716
SET @NPC := @CGUID+55;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=213.2274,`position_y`=-75.13932,`position_z`=0.004827803 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,213.2274,-75.13932,0.004827803,NULL,0,1,0,100,0),
(@PATH,2,200.5827,-87.171326,0.005753752,NULL,0,1,0,100,0),
(@PATH,3,201.05713,-94.47349,0.0055515133,NULL,0,1,0,100,0),
(@PATH,4,211.34688,-101.7175,9.806146E-05,NULL,0,1,0,100,0),
(@PATH,5,221.76944,-105.02244,0.0001423994,NULL,0,1,0,100,0),
(@PATH,6,201.05713,-94.47349,0.0055515133,NULL,0,1,0,100,0),
(@PATH,7,200.5827,-87.171326,0.005753752,NULL,0,1,0,100,0),
(@PATH,8,208.24849,-83.39652,0.0051163677,NULL,0,1,0,100,0);

-- Pathing for Tempest-Forge Destroyer Entry: 19735
SET @NPC := @CGUID+60;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=233.31285,`position_y`=52.318443,`position_z`=0.021424541 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,233.31285,52.318443,0.021424541,NULL,0,0,0,100,0),
(@PATH,2,203.69647,53.04169,-0.004259702,NULL,0,0,0,100,0);

-- Pathing for Sunseeker Engineer Entry: 20988
SET @NPC := @CGUID+75;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=112.06979,`position_y`=40.35622,`position_z`=14.924257 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,112.06979,40.35622,14.924257,NULL,0,0,0,100,0),
(@PATH,2,101.23074,46.33547,14.9244,NULL,0,0,0,100,0),
(@PATH,3,102.23087,58.490253,14.934289,NULL,0,0,0,100,0),
(@PATH,4,110.57969,69.03175,14.918284,NULL,0,0,0,100,0),
(@PATH,5,102.23087,58.490253,14.934289,NULL,0,0,0,100,0),
(@PATH,6,101.23074,46.33547,14.9244,NULL,0,0,0,100,0);

-- Pathing for Sunseeker Engineer Entry: 20988
SET @NPC := @CGUID+73;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=101.51141,`position_y`=-74.898766,`position_z`=14.93021 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,101.51141,-74.898766,14.93021,NULL,0,0,0,100,0),
(@PATH,2,104.0157,-60.55514,14.924665,NULL,0,0,0,100,0),
(@PATH,3,100.0206,-48.74694,14.92466,NULL,0,0,0,100,0),
(@PATH,4,103.1169,-38.395683,14.924649,NULL,0,0,0,100,0),
(@PATH,5,115.30892,-32.14138,14.919365,NULL,0,0,0,100,0),
(@PATH,6,103.1169,-38.395683,14.924649,NULL,0,0,0,100,0),
(@PATH,7,100.0206,-48.74694,14.92466,NULL,0,0,0,100,0),
(@PATH,8,104.0157,-60.55514,14.924665,NULL,0,0,0,100,0);

-- Pathing for Sunseeker Engineer Entry: 20988
SET @NPC := @CGUID+70;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=229.27179,`position_y`=-57.646294,`position_z`=0.009516931 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,229.27179,-57.646294,0.009516931,NULL,0,0,0,100,0),
(@PATH,2,221.93794,-55.454258,0.008690897,NULL,0,0,0,100,0),
(@PATH,3,215.63664,-57.850872,0.0075872466,NULL,0,0,0,100,0),
(@PATH,4,212.29579,-63.3326,0.0074739046,NULL,0,0,0,100,0),
(@PATH,5,215.63664,-57.850872,0.0075872466,NULL,0,0,0,100,0),
(@PATH,6,221.93794,-55.454258,0.008690897,NULL,0,0,0,100,0);

-- Work EmoteState (173)
DELETE FROM `creature_addon` WHERE `emote`=173 AND `guid` IN (@CGUID+33,@CGUID+34,@CGUID+35,@CGUID+36,@CGUID+38,@CGUID+39,@CGUID+40,@CGUID+41,@CGUID+42,@CGUID+43,@CGUID+44,@CGUID+45,@CGUID+46,@CGUID+47,@CGUID+50,@CGUID+52,@CGUID+53);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@CGUID+33,0,0,0,1,173,0,''),
(@CGUID+34,0,0,0,1,173,0,''),
(@CGUID+35,0,0,0,1,173,0,''),
(@CGUID+36,0,0,0,1,173,0,''),
(@CGUID+38,0,0,0,1,173,0,''),
(@CGUID+39,0,0,0,1,173,0,''),
(@CGUID+40,0,0,0,1,173,0,''),
(@CGUID+41,0,0,0,1,173,0,''),
(@CGUID+42,0,0,0,1,173,0,''),
(@CGUID+43,0,0,0,1,173,0,''),
(@CGUID+44,0,0,0,1,173,0,''),
(@CGUID+45,0,0,0,1,173,0,''),
(@CGUID+46,0,0,0,1,173,0,''),
(@CGUID+47,0,0,0,1,173,0,''),
(@CGUID+50,0,0,0,1,173,0,''),
(@CGUID+52,0,0,0,1,173,0,''),
(@CGUID+53,0,0,0,1,173,0,'');

-- Pathaleon EmoteState
UPDATE `creature_template_addon` SET `bytes2` = 1, `emote` = 333 WHERE (`entry` = 19220);

-- Correct Auras
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '35191' WHERE (`entry` = 19167);
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '35188' WHERE (`entry` = 19510);

-- Static groups
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@CGUID+06,@CGUID+07,@CGUID+08,@CGUID+10,@CGUID+11,@CGUID+12,@CGUID+13,@CGUID+15,@CGUID+17,@CGUID+19,@CGUID+20,@CGUID+25,@CGUID+26,@CGUID+28,@CGUID+33,@CGUID+34,@CGUID+35,@CGUID+37,@CGUID+39,@CGUID+40,@CGUID+44,@CGUID+49,@CGUID+91) AND `memberGUID` IN (@CGUID+06,@CGUID+07,@CGUID+08,@CGUID+10,@CGUID+11,@CGUID+12,@CGUID+13,@CGUID+14,@CGUID+15,@CGUID+16,@CGUID+17,@CGUID+18,@CGUID+19,@CGUID+20,@CGUID+25,@CGUID+26,@CGUID+28,@CGUID+29,@CGUID+30,@CGUID+31,@CGUID+33,@CGUID+34,@CGUID+35,@CGUID+36,@CGUID+37,@CGUID+38,@CGUID+39,@CGUID+40,@CGUID+41,@CGUID+42,@CGUID+43,@CGUID+44,@CGUID+45,@CGUID+46,@CGUID+47,@CGUID+48,@CGUID+49,@CGUID+50,@CGUID+51,@CGUID+52,@CGUID+53,@CGUID+54,@CGUID+55,@CGUID+56,@CGUID+57,@CGUID+58,@CGUID+59,@CGUID+65,@CGUID+68,@CGUID+69,@CGUID+70,@CGUID+71,@CGUID+72,@CGUID+73,@CGUID+74,@CGUID+75,@CGUID+76,@CGUID+77,@CGUID+78,@CGUID+79,@CGUID+80,@CGUID+81,@CGUID+82,@CGUID+83,@CGUID+84,@CGUID+87,@CGUID+88,@CGUID+89,@CGUID+90,@CGUID+91,@CGUID+92,@CGUID+93);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+08, @CGUID+08, 0, 0, 3),
(@CGUID+08, @CGUID+84, 0, 0, 3),
(@CGUID+06, @CGUID+06, 0, 0, 3),
(@CGUID+06, @CGUID+81, 0, 0, 3),
(@CGUID+35, @CGUID+35, 0, 0, 3),
(@CGUID+35, @CGUID+36, 0, 0, 3),
(@CGUID+35, @CGUID+73, 0, 0, 3),
(@CGUID+25, @CGUID+25, 0, 0, 3),
(@CGUID+25, @CGUID+53, 0, 0, 3),
(@CGUID+25, @CGUID+45, 0, 0, 3),
(@CGUID+12, @CGUID+12, 0, 0, 3),
(@CGUID+12, @CGUID+87, 0, 0, 3),
(@CGUID+26, @CGUID+26, 0, 0, 3),
(@CGUID+26, @CGUID+65, 0, 0, 3),
(@CGUID+26, @CGUID+82, 0, 0, 3),
(@CGUID+34, @CGUID+34, 0, 0, 3),
(@CGUID+34, @CGUID+51, 0, 0, 3),
(@CGUID+34, @CGUID+38, 0, 0, 3),
(@CGUID+34, @CGUID+55, 0, 0, 3),
(@CGUID+33, @CGUID+33, 0, 0, 3),
(@CGUID+33, @CGUID+70, 0, 0, 3),
(@CGUID+33, @CGUID+42, 0, 0, 3),
(@CGUID+39, @CGUID+39, 0, 0, 3),
(@CGUID+39, @CGUID+41, 0, 0, 3),
(@CGUID+39, @CGUID+54, 0, 0, 3),
(@CGUID+39, @CGUID+48, 0, 0, 3),
(@CGUID+49, @CGUID+49, 0, 0, 3),
(@CGUID+49, @CGUID+72, 0, 0, 3),
(@CGUID+49, @CGUID+57, 0, 0, 3),
(@CGUID+49, @CGUID+74, 0, 0, 3),
(@CGUID+37, @CGUID+37, 0, 0, 3),
(@CGUID+37, @CGUID+71, 0, 0, 3),
(@CGUID+37, @CGUID+56, 0, 0, 3),
(@CGUID+37, @CGUID+50, 0, 0, 3),
(@CGUID+37, @CGUID+47, 0, 0, 3),
(@CGUID+44, @CGUID+44, 0, 0, 3),
(@CGUID+44, @CGUID+46, 0, 0, 3),
(@CGUID+44, @CGUID+52, 0, 0, 3),
(@CGUID+44, @CGUID+58, 0, 0, 3),
(@CGUID+13, @CGUID+13, 0, 0, 3),
(@CGUID+13, @CGUID+14, 0, 0, 3),
(@CGUID+28, @CGUID+28, 0, 0, 3),
(@CGUID+28, @CGUID+88, 0, 0, 3),
(@CGUID+28, @CGUID+68, 0, 0, 3),
(@CGUID+11, @CGUID+11, 0, 0, 3),
(@CGUID+11, @CGUID+89, 0, 0, 3),
(@CGUID+40, @CGUID+40, 0, 0, 3),
(@CGUID+40, @CGUID+43, 0, 0, 3),
(@CGUID+40, @CGUID+59, 0, 0, 3),
(@CGUID+40, @CGUID+75, 0, 0, 3),
(@CGUID+10, @CGUID+10, 0, 0, 3),
(@CGUID+10, @CGUID+80, 0, 0, 3),
(@CGUID+07, @CGUID+07, 0, 0, 3),
(@CGUID+07, @CGUID+83, 0, 0, 3),
(@CGUID+15, @CGUID+15, 0, 0, 3),
(@CGUID+15, @CGUID+30, 0, 0, 3),
(@CGUID+15, @CGUID+16, 0, 0, 3),
(@CGUID+15, @CGUID+29, 0, 0, 3),
(@CGUID+17, @CGUID+17, 0, 0, 3),
(@CGUID+17, @CGUID+90, 0, 0, 3),
(@CGUID+17, @CGUID+18, 0, 0, 3),
(@CGUID+17, @CGUID+31, 0, 0, 3),
(@CGUID+91, @CGUID+91, 0, 0, 3),
(@CGUID+91, @CGUID+77, 0, 0, 3),
(@CGUID+91, @CGUID+76, 0, 0, 3),
(@CGUID+19, @CGUID+19, 0, 0, 3),
(@CGUID+19, @CGUID+92, 0, 0, 3),
(@CGUID+19, @CGUID+78, 0, 0, 3),
(@CGUID+20, @CGUID+20, 0, 0, 3),
(@CGUID+20, @CGUID+93, 0, 0, 3),
(@CGUID+20, @CGUID+69, 0, 0, 3),
(@CGUID+20, @CGUID+79, 0, 0, 3);

/*
	These 2 Tempest-Forge Patrollers stop patrol and emote Emote ID: 3 (OneShotWave)
	Pauses for 6000ms
	Repeats around 30-60s
	Can pause between points
*/
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=76.8514,`position_y`=59.621902,`position_z`=14.924665 WHERE `guid`=@CGUID+1;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=73.91813,`position_y`=-56.71242,`position_z`=14.924665 WHERE `guid`=@CGUID+3;

DELETE FROM `waypoints` WHERE `point_comment`='Tempest-Forge Patroller' AND `entry` BETWEEN 1916600 AND 1916601;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
-- @CGUID+1
(1916600,1,76.8514,59.621902,14.924665,NULL,'Tempest-Forge Patroller'),
(1916600,2,38.19203,59.687855,0.1630622,NULL,'Tempest-Forge Patroller'),
(1916600,3,30.011766,55.230145,0.1630622,NULL,'Tempest-Forge Patroller'),
(1916600,4,32.04149,39.386734,0.014305516,NULL,'Tempest-Forge Patroller'),
(1916600,5,30.011766,55.230145,0.1630622,NULL,'Tempest-Forge Patroller'),
(1916600,6,38.19203,59.687855,0.1630622,NULL,'Tempest-Forge Patroller'),
-- @CGUID+3
(1916601,1,73.91813,-56.71242,14.924665,NULL,'Tempest-Forge Patroller'),
(1916601,2,38.843502,-56.28604,0.22432718,NULL,'Tempest-Forge Patroller'),
(1916601,3,30.624844,-54.907387,0.26585943,NULL,'Tempest-Forge Patroller'),
(1916601,4,31.930918,-34.87634,0.010954779,NULL,'Tempest-Forge Patroller'),
(1916601,5,30.624844,-54.907387,0.26585943,NULL,'Tempest-Forge Patroller'),
(1916601,6,38.843502,-56.28604,0.22432718,NULL,'Tempest-Forge Patroller');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+1), -(@CGUID+3)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+1), 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - On Aggro - Say Line 0'),
(-(@CGUID+1), 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 7000, 9000, 0, 11, 35012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\' (Normal Dungeon)'),
(-(@CGUID+1), 0, 2, 0, 0, 0, 100, 4, 2000, 2000, 7000, 9000, 0, 11, 38941, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\' (Heroic Dungeon)'),
(-(@CGUID+1), 0, 3, 0, 0, 0, 100, 4, 6000, 6000, 14000, 16000, 0, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Knockdown\' (Heroic Dungeon)'),
(-(@CGUID+1), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1916600, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - On Respawn - Start Waypoint'),
(-(@CGUID+1), 0, 1002, 1003, 1, 0, 100, 0, 30000, 60000, 30000, 60000, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Pause Waypoint'),
(-(@CGUID+1), 0, 1003, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Play Emote 3'),
(-(@CGUID+3), 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - On Aggro - Say Line 0'),
(-(@CGUID+3), 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 7000, 9000, 0, 11, 35012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\' (Normal Dungeon)'),
(-(@CGUID+3), 0, 2, 0, 0, 0, 100, 4, 2000, 2000, 7000, 9000, 0, 11, 38941, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\' (Heroic Dungeon)'),
(-(@CGUID+3), 0, 3, 0, 0, 0, 100, 4, 6000, 6000, 14000, 16000, 0, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Knockdown\' (Heroic Dungeon)'),
(-(@CGUID+3), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1916601, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - On Respawn - Start Waypoint'),
(-(@CGUID+3), 0, 1002, 1003, 1, 0, 100, 0, 30000, 60000, 30000, 60000, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Pause Waypoint'),
(-(@CGUID+3), 0, 1003, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Play Emote 3');

/*
	These 2 groups move together at the entrance and stop, not moving anymore
	This is a hack as waypoint_data does not allow for this behaviour, and it's over-scripted in SAI as waypoints does not work with formations
*/
SET @NPC := @CGUID+66;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,28.006437,30.866398,0.0030425692,NULL,0,0,0,100,0), -- Point
(@PATH,2,22.140232,20.44575,-0.00017946598,NULL,0,0,0,100,0),
(@PATH,3,22.140232,20.44575,-0.00017946598,3.176499128341674804,2147483647,0,0,100,0); -- Point

SET @NPC := @CGUID+67;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,29.015987,-29.292263,0.0004399572,NULL,0,0,0,100,0), -- Point
(@PATH,2,23.20878,-18.283445,-0.00011080259,NULL,0,0,0,100,0),
(@PATH,3,23.20878,-18.283445,-0.00011080259,3.089232683181762695,2147483647,0,0,100,0); -- Point

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@CGUID+66, @CGUID+67) AND `memberGUID` IN (@CGUID+66, @CGUID+67, @CGUID+27, @CGUID+86, @CGUID+9, @CGUID+85);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+66, @CGUID+66, 0, 0, 3),
(@CGUID+66, @CGUID+27, 3, 90, 515),
(@CGUID+66, @CGUID+86, 3, 270, 515),
(@CGUID+67, @CGUID+67, 0, 0, 3),
(@CGUID+67, @CGUID+9, 3, 90, 515),
(@CGUID+67, @CGUID+85, 3, 270, 515);
