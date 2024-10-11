-- DB update 2024_03_18_03 -> 2024_03_19_00
--
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 534 AND `summonerType` = 2;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(534, 2, 0, 17895 , 4925.643, -1528.42, 1327.342, 4.127055, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4921.256, -1522.268, 1328.227, 4.26371, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4929.174, -1523.59, 1326.968, 4.103232, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4924.306, -1518.115, 1327.88, 4.266161, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4935.302, -1520.679, 1326.767, 4.032117, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4929.829, -1517.265, 1327.309, 4.168236, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4937.893, -1515.675, 1326.887, 4.077524, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4931.888, -1511.627, 1327.553, 4.19019, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4925.925, -1511.79, 1328.051, 4.410969, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 0, 17895 , 4920.874, -1515.936, 1328.602, 4.318599, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 1, 17895 , 4916.404, -1520.643, 1329.461, 4.363451, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4919.443, -1524.3, 1328.708, 4.2793, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4923.728, -1528.388, 1327.614, 4.311669, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4927.414, -1532.622, 1327.135, 4.043822, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4920.349, -1516.241, 1328.749, 4.324855, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4924.708, -1519.513, 1327.774, 4.380139, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4928.422, -1523.765, 1327.044, 4.240041, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4932.152, -1529.665, 1326.947, 4.007116, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4916.519, -1528.107, 1329.58, 4.352018, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17895 , 4920.124, -1532.635, 1328.399, 4.381913, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17897 , 4926.602, -1514.812, 1327.568, 4.374004, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 1, 17897 , 4933.663, -1522.479, 1326.8, 4.066925, 7, 0, 'Wave 2: 10 Ghouls and 2 Crypt Fiends'),
(534, 2, 2, 17895 , 4927.044, -1537.156, 1327.366, 3.983671, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17895 , 4923.918, -1532.033, 1327.583, 4.248679, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17895 , 4917.58, -1529.782, 1329.129, 4.512907, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17895 , 4914.535, -1525.046, 1330.081, 4.644515, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17895 , 4907.775, -1523.272, 1332.014, 4.520949, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17895 , 4904.907, -1516.222, 1332.705, 4.907058, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17897 , 4931.415, -1533.642, 1327.038, 3.88825, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17897 , 4926.614, -1528.546, 1327.198, 4.107586, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17897 , 4921.408, -1522.906, 1328.219, 4.281098, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17897 , 4913.245, -1520.054, 1330.439, 4.426145, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17897 , 4934.147, -1524.828, 1326.84, 4.034865, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 2, 17897 , 4927.279, -1517.326, 1327.657, 4.207614, 7, 0, 'Wave 3: 6 Ghouls and 6 Crypt Fiends'),
(534, 2, 3, 17895 , 4911.118, -1523.113, 1331.097, 4.451728, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17895 , 4908.977, -1517.954, 1331.429, 4.808149, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17895 , 4914.319, -1527.248, 1330.165, 4.426172, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17895 , 4917.809, -1531.797, 1329.036, 4.265389, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17895 , 4921.933, -1535.177, 1327.973, 4.07961, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17895 , 4926.549, -1538.521, 1327.489, 3.969737, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17897 , 4916.115, -1516.368, 1329.683, 4.457922, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17897 , 4926.343, -1516.999, 1327.856, 4.22424, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17897 , 4930.89, -1522.958, 1326.893, 4.079469, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17897 , 4931.164, -1532.178, 1326.95, 3.921505, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17899 , 4919.989, -1521.773, 1328.61, 4.489554, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 3, 17899 , 4923.608, -1526.632, 1327.75, 4.337822, 7, 0, 'Wave 4: 6 Ghouls, 4 Crypt Fiends and 2 Necromancers'),
(534, 2, 4, 17895 , 4918.185, -1527.17, 1329.019, 4.315125, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17895 , 4922.89, -1529.576, 1327.829, 4.322945, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17897 , 4916.001, -1517.164, 1329.591, 4.620493, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17897 , 4920.521, -1519.719, 1328.516, 4.33359, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17897 , 4925.456, -1524.336, 1327.433, 4.172694, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17897 , 4931.456, -1528.238, 1326.907, 4.034986, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17897 , 4924.255, -1513.54, 1328.496, 4.435135, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17897 , 4931.574, -1518.703, 1327.023, 4.120836, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17899 , 4915.204, -1524.542, 1329.935, 4.359166, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17899 , 4912.781, -1522.514, 1330.384, 4.703914, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17899 , 4925.974, -1531.158, 1327.249, 4.053604, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 4, 17899 , 4930.198, -1534.038, 1327.047, 4.007935, 7, 0, 'Wave 5: 2 Ghouls, 6 Crypt Fiends and 4 Necromancers'),
(534, 2, 5, 17895 , 4931.506, -1535.571, 1327.243, 3.844688, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17895 , 4928.218, -1534.305, 1327.114, 4.060686, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17895 , 4922.387, -1531.344, 1327.953, 4.150617, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17895 , 4918.271, -1528.786, 1328.984, 4.293182, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17895 , 4915.333, -1526.436, 1329.728, 4.613498, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17895 , 4911.082, -1522.356, 1331.09, 4.456543, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17898 , 4934.243, -1529.936, 1327.063, 3.907663, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17898 , 4928.805, -1528.162, 1326.991, 4.164741, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17898 , 4921.543, -1524.08, 1328.201, 4.243358, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17898 , 4915.95, -1520.491, 1329.678, 4.372918, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17898 , 4933.451, -1522.371, 1326.794, 4.04113, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 5, 17898 , 4922.121, -1517.213, 1328.356, 4.288848, 7, 0, 'Wave 6: 6 Ghouls and 6 Abominations'),
(534, 2, 6, 17895 , 4926.464, -1534.441, 1327.286, 3.976079, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17895 , 4922.677, -1530.785, 1327.851, 4.142037, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17895 , 4919.348, -1526.814, 1328.665, 4.473605, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17895 , 4915.953, -1522.815, 1329.489, 4.605725, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17899 , 4927.556, -1531.928, 1327.122, 4.001671, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17899 , 4925.604, -1529.334, 1327.388, 4.093475, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17899 , 4919.795, -1523.094, 1328.692, 4.317783, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17899 , 4918.63, -1521.644, 1328.854, 4.530917, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17898 , 4931.853, -1531.563, 1326.989, 3.921482, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17898 , 4927.954, -1526.69, 1327.047, 4.106788, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17898 , 4923.524, -1522.353, 1327.761, 4.385348, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 6, 17898 , 4918.477, -1516.516, 1329.144, 4.403982, 7, 0, 'Wave 7: 4 Ghouls, 4 Abominations and 4 Necromancers'),
(534, 2, 7, 17895 , 4932.013, -1531.015, 1326.96, 3.99057, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17895 , 4928.318, -1528.833, 1327.05, 4.041089, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17895 , 4923.604, -1527.729, 1327.728, 4.165579, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17895 , 4920.151, -1527.905, 1328.456, 4.43657, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17895 , 4914.406, -1527.226, 1330.206, 4.355446, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17895 , 4909.197, -1525.781, 1331.64, 4.478852, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17897 , 4932.52, -1524.659, 1326.851, 4.025184, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17897 , 4925.131, -1521.898, 1327.548, 4.20156, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17897 , 4917.794, -1521.453, 1329.094, 4.332634, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17897 , 4911.284, -1520.284, 1330.72, 4.747531, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17898 , 4929.808, -1515.532, 1327.685, 4.187524, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17898 , 4921.793, -1513.606, 1328.815, 4.356327, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17899 , 4936.591, -1518.104, 1326.803, 4.044622, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 7, 17899 , 4915.962, -1510.813, 1329.748, 4.515066, 7, 0, 'Wave 8: 6 Ghouls, 4 Crypt Fiends, 2 Abominations and 2 Necromancers'),
(534, 2, 8, 17767 , 4936.221, -1513.435, 1327.188, 4.104067, 7, 0, 'Rage Winterchill'),
(534, 2, 9, 17895 , 4932.953, -1529.599, 1326.7, 3.937371, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4929.082, -1526.454, 1326.852, 4.18398, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4924.633, -1523.052, 1327.445, 4.347703, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4920.136, -1519.804, 1328.422, 4.497755, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4916.486, -1516.639, 1329.328, 4.447559, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4938.097, -1525.316, 1326.922, 3.921502, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4934.7, -1520.92, 1326.68, 4.134113, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4930.074, -1517.03, 1327.01, 4.167439, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4924.334, -1513.492, 1328.07, 4.281028, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 9, 17895 , 4920.155, -1509.878, 1329.028, 4.366851, 7, 0, 'Wave 1: 10 Ghouls'),
(534, 2, 10, 17895 , 4928.501, -1534.467, 1327.107, 4.047384, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4924.636, -1530.77, 1327.51, 4.116479, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4922.069, -1528.371, 1328.02, 4.365864, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4918.227, -1525.646, 1328.961, 4.330956, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4915.26, -1522.313, 1329.863, 4.439423, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4911.429, -1518.958, 1330.918, 4.55756, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4919.851, -1532.629, 1328.433, 4.18836, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17895 , 4914.406, -1526.891, 1330.03, 4.644628, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17898 , 4933.69, -1529.706, 1326.988, 4.013412, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17898 , 4929.332, -1525.465, 1326.957, 4.192708, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17898 , 4922.8, -1520.3, 1328.015, 4.276646, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 10, 17898 , 4917.733, -1516.502, 1329.268, 4.577129, 7, 0, 'Wave 2: 8 Ghouls and 4 Abominations'),
(534, 2, 11, 17895 , 4926.166, -1533.865, 1327.382, 4.047344, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17895 , 4922.134, -1530.295, 1327.968, 4.163887, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17895 , 4917.754, -1526.04, 1329.193, 4.296716, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17895 , 4913.225, -1521.825, 1330.442, 4.41712, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17897 , 4931.624, -1530.073, 1326.916, 3.952546, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17897 , 4927.168, -1526.048, 1327.128, 4.241773, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17897 , 4921.812, -1521.547, 1328.144, 4.285402, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17897 , 4916.725, -1516.875, 1329.484, 4.441412, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17899 , 4937.741, -1523.788, 1326.978, 3.99891, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17899 , 4933.576, -1519.664, 1326.835, 4.073932, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17899 , 4927.942, -1514.643, 1327.973, 4.229518, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 11, 17899 , 4922.644, -1509.858, 1329.055, 4.32917, 7, 0, 'Wave 3: 4 Ghouls, 4 Crypt Fiends and 4 Necromancers'),
(534, 2, 12, 17897 , 4939.017, -1523.412, 1326.9, 3.937352, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17897 , 4933.433, -1518.303, 1326.739, 4.111102, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17897 , 4927.944, -1514.354, 1327.556, 4.347644, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17897 , 4921.462, -1510.275, 1328.794, 4.385396, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17897 , 4940.061, -1513.149, 1326.812, 4.128702, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17897 , 4933.439, -1507.623, 1327.997, 4.198108, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17899 , 4932.806, -1527.553, 1326.7, 4.022399, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17899 , 4927.911, -1522.446, 1326.982, 4.268787, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17899 , 4922.838, -1518.548, 1327.799, 4.435117, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17899 , 4918.32, -1515.146, 1328.966, 4.567501, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17905 , 4923.421, -1526.854, 1327.707, 4.182356, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 12, 17905 , 4918.667, -1522.755, 1328.861, 4.306505, 7, 0, 'Wave 4: 6 Crypt Fiends, 4 Necromancers and 2 Banshees'),
(534, 2, 13, 17895 , 4933.623, -1530.23, 1326.732, 3.913238, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17895 , 4930.487, -1526.874, 1326.768, 4.142032, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17895 , 4926.575, -1522.183, 1327.146, 4.174441, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17895 , 4922.776, -1518.178, 1327.836, 4.297525, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17895 , 4919.374, -1514.975, 1328.728, 4.541776, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17895 , 4915.127, -1510.888, 1329.914, 4.652884, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17905 , 4935.26, -1522.895, 1326.708, 4.003616, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17905 , 4931.459, -1517.77, 1326.869, 4.239964, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17905 , 4927.077, -1514.236, 1327.657, 4.235619, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17905 , 4923.01, -1509.547, 1328.694, 4.484927, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17899 , 4938.147, -1516.22, 1326.668, 4.06968, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 13, 17899 , 4929.385, -1507.941, 1328.319, 4.366895, 7, 0, 'Wave 5: 6 Ghouls, 4 Banshees and 2 Necromancers'),
(534, 2, 14, 17895 , 4935.932, -1528.83, 1326.905, 3.980172, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17895 , 4932.223, -1525.755, 1326.723, 4.117352, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17895 , 4928.167, -1523.22, 1326.946, 4.253203, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17895 , 4924.045, -1520.065, 1327.56, 4.392459, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17895 , 4919.923, -1517.707, 1328.485, 4.321369, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17895 , 4915.889, -1515.049, 1329.545, 4.627302, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17898 , 4933.285, -1518.861, 1326.729, 4.107613, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17898 , 4926.564, -1513.743, 1327.779, 4.246144, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17899 , 4937.41, -1523.689, 1326.784, 3.957389, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17899 , 4935.644, -1512.89, 1327.037, 4.208555, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17899 , 4931.938, -1509.754, 1327.863, 4.20155, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 14, 17899 , 4921.09, -1511.109, 1328.757, 4.518619, 7, 0, 'Wave 6: 6 Ghouls, 2 Abominations and 4 Necromancers'),
(534, 2, 15, 17895 , 4924.866, -1525.098, 1327.391, 4.175267, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17895 , 4921.645, -1521.122, 1328.076, 4.447429, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17897 , 4929.167, -1529.471, 1326.892, 4.012544, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17897 , 4917.498, -1517.405, 1329.074, 4.365274, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17897 , 4934.654, -1526.132, 1326.76, 4.013417, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17897 , 4930.837, -1520.827, 1326.786, 4.219054, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17898 , 4926.241, -1517.236, 1327.395, 4.362504, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17898 , 4921.272, -1511.85, 1328.661, 4.511899, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17898 , 4940.836, -1520.848, 1326.926, 3.946306, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17898 , 4936.27, -1516.31, 1326.689, 4.092718, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17905 , 4932.069, -1510.972, 1327.676, 4.191054, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 15, 17905 , 4926.97, -1506.623, 1328.652, 4.312508, 7, 0, 'Wave 7: 2 Ghouls, 4 Crypt Fiends, 4 Abominations and 2 Banshees'),
(534, 2, 16, 17895 , 4927.992, -1530.346, 1327.017, 4.149098, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17895 , 4922.845, -1525.778, 1327.841, 4.203334, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17895 , 4917.346, -1520.755, 1329.185, 4.398687, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17895 , 4911.636, -1516.439, 1330.68, 4.561438, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17898 , 4932.755, -1526.406, 1326.707, 4.094298, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17898 , 4926.729, -1521.291, 1327.152, 4.182318, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17898 , 4921.313, -1517.25, 1328.153, 4.302872, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17898 , 4914.79, -1512.803, 1329.918, 4.505786, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17897 , 4932.799, -1517.233, 1326.804, 4.218163, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17897 , 4927.063, -1511.41, 1328.058, 4.27498, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17905 , 4942.199, -1517.49, 1326.844, 4.009918, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17905 , 4927.272, -1502.729, 1329.026, 4.333464, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17899 , 4938.311, -1510.945, 1327.078, 4.180502, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 16, 17899 , 4933.119, -1506.645, 1328.139, 4.214725, 7, 0, 'Wave 8: 4 Ghouls, 2 Crypt Fiends, 4 Abominations, 2 Banshees and 2 Necromancers'),
(534, 2, 17, 17808 , 4938.755, -1510.624, 1327.083, 4.176985, 7, 0, 'Anetheron'),
(534, 2, 18, 17895 , 5471.863, -2392.172, 1460.32, 6.104537, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17895 , 5475.722, -2388.922, 1460.821, 5.319835, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17895 , 5479.377, -2386.201, 1461.3, 5.927942, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17895 , 5482.705, -2382.528, 1461.503, 4.954062, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17895 , 5487.009, -2379.895, 1461.587, 4.782725, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17895 , 5489.937, -2376.359, 1461.892, 5.575186, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17898 , 5466.463, -2387.134, 1462.138, 5.697435, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17898 , 5473.117, -2381.076, 1461.292, 5.245095, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17898 , 5480.076, -2375.681, 1461.285, 4.981046, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17898 , 5486.467, -2370.369, 1461.592, 5.523299, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17905 , 5466.94, -2377.265, 1463.017, 5.533129, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17905 , 5470.159, -2374.818, 1461.555, 5.228471, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17899 , 5473.245, -2371.979, 1460.878, 5.124473, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 18, 17899 , 5476.542, -2368.595, 1460.913, 5.286283, 7, 0, 'Wave 1: 6 Ghoul, 4 Abomination, 2 Banshee, 2 Necromancer'),
(534, 2, 19, 17895 , 5473.612, -2393.847, 1460.427, 5.538561, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17895 , 5481.65, -2387.077, 1461.446, 5.930215, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17895 , 5484.973, -2383.493, 1461.744, 5.808589, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17895 , 5491.622, -2377.881, 1462.246, 5.57801, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5823.992, -2908.259, 1564.566, 2.640309, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5802.556, -2886.877, 1551.054, 2.849298, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5776.23, -2872.468, 1612.081, 4.955018, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5770.719, -2834.339, 1598.396, 4.912748, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5780.823, -2822.528, 1576.543, 2.910838, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5786.263, -2859.778, 1576.375, 2.063877, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5804.678, -2901.291, 1587.472, 4.21586, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5823.609, -2938.187, 1617.297, 2.037145, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5796.999, -2912.517, 1627.133, 1.912279, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 19, 17906 , 5789.98, -2838.952, 1548.416, 4.71027, 7, 0, 'Wave 2: 4 Ghoul, 10 Gargoyle'),
(534, 2, 20, 17895 , 5473.296, -2393.048, 1460.443, 5.727721, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17895 , 5477.202, -2389.97, 1460.973, 5.598216, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17895 , 5480.104, -2388.15, 1461.365, 5.133206, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17895 , 5484.459, -2383.279, 1461.681, 5.810743, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17895 , 5487.065, -2381.763, 1461.635, 4.785645, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17895 , 5489.606, -2377.921, 1461.894, 4.692288, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17897 , 5466.04, -2379.193, 1463.627, 5.572718, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17897 , 5479.046, -2368.428, 1461.076, 5.24419, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17897 , 5467.451, -2387.625, 1461.341, 5.693457, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17897 , 5474.267, -2382.166, 1461.342, 5.501296, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17897 , 5480.889, -2377.129, 1461.338, 5.308205, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17897 , 5486.477, -2371.984, 1461.615, 4.782275, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17899 , 5471.71, -2375.949, 1461.215, 5.449273, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 20, 17899 , 5474.819, -2372.617, 1460.952, 5.71139, 7, 0, 'Wave 3: 6 Ghoul, 6 Crypt Fiends, 2 Necromancer'),
(534, 2, 21, 17897 , 5465.716, -2379.399, 1463.71, 5.395523, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17897 , 5478.875, -2368.178, 1461.07, 5.244267, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17897 , 5467.596, -2387.193, 1461.501, 6.024768, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17897 , 5473.881, -2382.322, 1461.298, 5.24427, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17897 , 5481.042, -2376.943, 1461.347, 5.303872, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17897 , 5487.553, -2371.259, 1461.737, 5.521908, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17906 , 5793.838, -2876.247, 1563.766, 4.629621, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17906 , 5816.996, -2909.161, 1582.068, 2.111933, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17906 , 5777.432, -2899.413, 1604.322, 1.758108, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17906 , 5770.996, -2828.342, 1594.328, 2.268224, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17906 , 5781.946, -2864.139, 1593.854, 4.82583, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17906 , 5784.716, -2807.962, 1567.109, 4.379971, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17899 , 5471.47, -2375.933, 1461.281, 5.452258, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 21, 17899 , 5474.262, -2373.027, 1460.936, 5.371886, 7, 0, 'Wave 4: 6 Crypt Fiends, 2 Necromancer, 6 Gargoyles'),
(534, 2, 22, 17895 , 5479.022, -2389.681, 1461.178, 6.012395, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17895 , 5482.383, -2387.293, 1461.526, 5.92795, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17895 , 5484.698, -2385.112, 1461.664, 5.348127, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17895 , 5488.692, -2382.81, 1462.057, 5.213516, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17898 , 5466.756, -2380.586, 1462.959, 5.39338, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17898 , 5479.783, -2369.696, 1461.108, 5.244311, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17898 , 5468.887, -2388.767, 1460.945, 5.697079, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17898 , 5475.438, -2383.356, 1461.37, 5.501222, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17898 , 5481.994, -2378.48, 1461.411, 5.304682, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17898 , 5486.682, -2373.582, 1461.661, 4.779593, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17899 , 5472.101, -2396.112, 1460.305, 6.18545, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17899 , 5475.1, -2392.839, 1460.541, 6.10441, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17899 , 5491.19, -2379.425, 1462.319, 5.106939, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 22, 17899 , 5493.767, -2376.383, 1462.851, 5.014709, 7, 0, 'Wave 5: 4 Ghoul, 6 Abomination, 4 Necromancer'),
(534, 2, 23, 17906 , 5387.046, -2536.589, 1561.265, 6.042778, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5384.106, -2507.996, 1532.068, 5.923682, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5434.01, -2518.206, 1504.208, 5.396564, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5477.957, -2523.492, 1531.497, 4.311117, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5425.072, -2539.16, 1527.672, 5.892184, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5454.331, -2537.709, 1518.542, 5.234161, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5403.739, -2551.102, 1545.229, 6.21172, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17906 , 5453.157, -2549.673, 1545.859, 0.1446965, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 23, 17907 , 5448.235, -2475.62, 1468.523, 4.756875, 7, 0, 'Wave 6: 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 24, 17895 , 5477.121, -2390.861, 1460.973, 5.318035, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17895 , 5480.119, -2388.215, 1461.374, 5.134054, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17895 , 5483.122, -2384.594, 1461.55, 4.957835, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17895 , 5488.021, -2381.721, 1461.909, 5.215247, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17895 , 5489.653, -2378.407, 1461.911, 4.690397, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17895 , 5494.47, -2374.726, 1463.068, 5.456352, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17898 , 5468.423, -2387.873, 1461.128, 6.032522, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17898 , 5474.42, -2382.597, 1461.382, 5.506153, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17898 , 5480.611, -2377.919, 1461.34, 4.984337, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17898 , 5488.219, -2371.795, 1461.817, 5.519931, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 24, 17907 , 5753.523, -2701.919, 1586.142, 3.26914, 7, 0, 'Wave 7: 6 Ghoul, 4 Abomination, 1 Frost Wyrm'),
(534, 2, 25, 17895 , 5477.641, -2389.262, 1461.029, 6.010409, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17895 , 5480.969, -2386.87, 1461.401, 5.930136, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17895 , 5483.921, -2384.053, 1461.594, 5.348127, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17895 , 5486.846, -2381.426, 1461.63, 4.79358, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17897 , 5464.27, -2379.535, 1464.909, 5.600142, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17897 , 5469.777, -2376.149, 1461.464, 5.479149, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17897 , 5476.496, -2370.759, 1460.936, 5.663713, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17897 , 5481.59, -2366.031, 1461.301, 5.178696, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17898 , 5467.852, -2387.439, 1461.377, 6.028671, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17898 , 5474.733, -2381.472, 1461.333, 5.869359, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17898 , 5481.558, -2376.589, 1461.381, 5.704444, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17898 , 5486.307, -2372.02, 1461.601, 4.787056, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17899 , 5470.347, -2396.384, 1460.145, 5.841413, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17899 , 5492.644, -2375.068, 1462.704, 4.602814, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17905 , 5473.68, -2392.463, 1460.439, 6.102266, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 25, 17905 , 5489.835, -2377.806, 1461.933, 4.684792, 7, 0, 'Wave 8: 4 Ghoul, 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer'),
(534, 2, 26, 17888 , 5526.32, -2449.313, 1468.57, 5.386355, 7, 0, 'Kaz\'rogal'),
(534, 2, 27, 17898 , 5466.154, -2379.352, 1463.502, 5.385604, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17898 , 5478.628, -2368.868, 1461.073, 4.971114, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17898 , 5467.629, -2388.19, 1461.427, 5.534935, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17898 , 5473.93, -2382.598, 1461.338, 5.246795, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17898 , 5480.403, -2377.566, 1461.326, 4.987185, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17898 , 5487.087, -2372.053, 1461.726, 5.128849, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17899 , 5473.371, -2393.286, 1460.439, 5.732042, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17899 , 5477.703, -2389.388, 1461.044, 6.014513, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17899 , 5479.994, -2387.888, 1461.363, 5.133204, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17899 , 5484.615, -2383.193, 1461.696, 5.806313, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17899 , 5488.518, -2380.592, 1462.005, 5.692625, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 27, 17899 , 5491.366, -2377.594, 1462.175, 5.57586, 7, 0, 'Wave 1: 6 Abomination, 6 Necromancer'),
(534, 2, 28, 17895 , 5475.592, -2388.769, 1460.793, 5.320674, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17895 , 5478.963, -2385.899, 1461.267, 5.925934, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17895 , 5482.61, -2382.277, 1461.496, 4.955923, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17895 , 5486.747, -2379.534, 1461.571, 5.217056, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17895 , 5489.814, -2375.995, 1461.873, 5.570403, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17907 , 5423.374, -2540.911, 1531.116, 5.633668, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5407.959, -2504.334, 1492.227, 5.539972, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5436.766, -2518.686, 1505.259, 4.820778, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5393.467, -2506.886, 1519.251, 5.674838, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5433.89, -2540.067, 1530.021, 6.16795, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5419.362, -2545.74, 1539.552, 6.049433, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5449.623, -2546.096, 1536.206, 4.406961, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5389.705, -2538.281, 1551.524, 5.749064, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 28, 17906 , 5435.055, -2556.646, 1556.268, 0.003030294, 7, 0, 'Wave 2: 5 Ghoul, 8 Gargoyle, 1 Frost Wyrm'),
(534, 2, 29, 17895 , 5472.351, -2392.977, 1460.335, 5.548223, 7, 0, 'Wave 3: 6 Ghoul, 8 Infernal'),
(534, 2, 29, 17895 , 5476.307, -2389.896, 1460.866, 5.323418, 7, 0, 'Wave 3: 6 Ghoul, 8 Infernal'),
(534, 2, 29, 17895 , 5479.439, -2387.299, 1461.308, 5.14465, 7, 0, 'Wave 3: 6 Ghoul, 8 Infernal'),
(534, 2, 29, 17895 , 5483.249, -2383.182, 1461.55, 5.348069, 7, 0, 'Wave 3: 6 Ghoul, 8 Infernal'),
(534, 2, 29, 17895 , 5486.856, -2380.695, 1461.606, 4.79068, 7, 0, 'Wave 3: 6 Ghoul, 8 Infernal'),
(534, 2, 29, 17895 , 5490.057, -2377.032, 1461.997, 5.110533, 7, 0, 'Wave 3: 6 Ghoul, 8 Infernal'),
(534, 2, 30, 17916 , 5473.774, -2394.408, 1460.415, 5.552334, 7, 0, 'Wave 4: 6 Fel Stalker, 8 Infernal'),
(534, 2, 30, 17916 , 5478.53, -2389.692, 1461.149, 6.016419, 7, 0, 'Wave 4: 6 Fel Stalker, 8 Infernal'),
(534, 2, 30, 17916 , 5482.058, -2387.323, 1461.471, 5.932327, 7, 0, 'Wave 4: 6 Fel Stalker, 8 Infernal'),
(534, 2, 30, 17916 , 5483.522, -2385.227, 1461.57, 4.947872, 7, 0, 'Wave 4: 6 Fel Stalker, 8 Infernal'),
(534, 2, 30, 17916 , 5488.204, -2382.279, 1461.992, 5.21784, 7, 0, 'Wave 4: 6 Fel Stalker, 8 Infernal'),
(534, 2, 30, 17916 , 5492.172, -2378.038, 1462.324, 5.570403, 7, 0, 'Wave 4: 6 Fel Stalker, 8 Infernal'),
(534, 2, 31, 17898 , 5467.105, -2387.462, 1461.696, 5.695487, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17898 , 5473.926, -2381.282, 1461.319, 5.873254, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17898 , 5480.058, -2376.604, 1461.299, 4.989628, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17898 , 5487.268, -2370.727, 1461.689, 5.517107, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17916 , 5472.752, -2392.399, 1460.368, 6.104362, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17916 , 5476.255, -2389.728, 1460.871, 5.320654, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17916 , 5479.854, -2386.684, 1461.329, 5.481168, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17916 , 5483.469, -2383.013, 1461.553, 5.341039, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17916 , 5486.982, -2380.809, 1461.608, 4.786619, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17916 , 5490.145, -2377.011, 1462.003, 5.108684, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17899 , 5463.578, -2379.832, 1465.341, 5.44682, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17899 , 5469.558, -2375.892, 1461.789, 5.478561, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17899 , 5475.502, -2370.343, 1460.9, 5.321494, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 31, 17899 , 5480.951, -2365.24, 1461.213, 4.898064, 7, 0, 'Wave 5: 4 Abomination, 6 Fel Stalker, 4 Necromancer'),
(534, 2, 32, 17899 , 5476.288, -2389.152, 1460.853, 6.016577, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17899 , 5479.657, -2386.318, 1461.322, 5.93025, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17899 , 5483.331, -2383.055, 1461.535, 5.344517, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17899 , 5486.864, -2380.052, 1461.589, 4.788543, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17899 , 5490.023, -2376.415, 1461.943, 5.105319, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17899 , 5492.843, -2373.418, 1462.74, 5.014687, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17905 , 5470.768, -2381.377, 1461.585, 5.311578, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17905 , 5474.223, -2378.596, 1461.076, 5.176897, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17905 , 5477.382, -2375.48, 1461.14, 5.055127, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17905 , 5480.378, -2372.383, 1461.161, 5.261695, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17905 , 5483.126, -2369.863, 1461.287, 4.865324, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 32, 17905 , 5486.186, -2366.258, 1461.716, 5.463794, 7, 0, 'Wave 6: 6 Necromancer, 6 Banshee'),
(534, 2, 33, 17895 , 5483.201, -2383.262, 1461.534, 4.941727, 7, 0, 'Wave 7: 2 Ghoul, 2 Crypt Fiends, 2 Fel Stalker, 8 Infernal'),
(534, 2, 33, 17895 , 5487.841, -2380.242, 1461.783, 5.694742, 7, 0, 'Wave 7: 2 Ghoul, 2 Crypt Fiends, 2 Fel Stalker, 8 Infernal'),
(534, 2, 33, 17897 , 5473.733, -2381.661, 1461.289, 5.501221, 7, 0, 'Wave 7: 2 Ghoul, 2 Crypt Fiends, 2 Fel Stalker, 8 Infernal'),
(534, 2, 33, 17897 , 5480.044, -2376.513, 1461.297, 4.989067, 7, 0, 'Wave 7: 2 Ghoul, 2 Crypt Fiends, 2 Fel Stalker, 8 Infernal'),
(534, 2, 33, 17916 , 5467.372, -2387.183, 1461.729, 6.026359, 7, 0, 'Wave 7: 2 Ghoul, 2 Crypt Fiends, 2 Fel Stalker, 8 Infernal'),
(534, 2, 33, 17916 , 5486.382, -2370.961, 1461.59, 4.782901, 7, 0, 'Wave 7: 2 Ghoul, 2 Crypt Fiends, 2 Fel Stalker, 8 Infernal'),
(534, 2, 34, 17898 , 5464.765, -2379.698, 1464.398, 5.911384, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17898 , 5470.104, -2376.372, 1461.377, 5.478453, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17898 , 5476.636, -2370.652, 1460.942, 5.659968, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17898 , 5481.879, -2366.252, 1461.323, 5.175017, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17897 , 5468.371, -2387.287, 1461.241, 6.022331, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17897 , 5480.369, -2377.551, 1461.323, 4.98816, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17897 , 5487.712, -2371.494, 1461.771, 5.522707, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17897 , 5474.863, -2381.631, 1461.36, 5.871073, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17905 , 5479.14, -2401.899, 1460.762, 5.727021, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17905 , 5496.938, -2382.928, 1462.721, 5.592558, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17899 , 5470.226, -2397.017, 1460.11, 5.752703, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17899 , 5494.31, -2374.414, 1463.051, 5.454998, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17916 , 5481.617, -2386.691, 1461.459, 5.92197, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17916 , 5484.139, -2383.701, 1461.605, 5.337486, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17916 , 5487.897, -2381.313, 1461.88, 5.212841, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 34, 17916 , 5489.723, -2378.428, 1461.897, 4.688016, 7, 0, 'Wave 8: 4 Abomination, 4 Crypt Fiends, 2 Banshee, 2 Necromancer, 4 Fel Stalker'),
(534, 2, 35, 17842 , 5526.623, -2449.26, 1468.583, 5.360693, 7, 0, 'Azgalor'),
(534, 2, 36, 18304 , 4998.445, -1774.231, 1329.802, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5073.363, -1723.617, 1327.12, 3.329434, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5094.47, -1770.405, 1323.583, 2.300560, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5093.89, -1800.052, 1323.097, 3.578211, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 4998.343, -1757.482, 1331.24, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5115.442, -1767.191, 1331.234, 1.638259, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5069.346, -1819.29, 1328.154, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 4942.818, -1887.266, 1326.585, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 4997.396, -1767.484, 1329.677, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5111.535, -1850.402, 1333.595, 1.273658, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 4947.428, -1893.398, 1326.585, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5119.775, -1741.85, 1334.72, 4.146245, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5099.896, -1804.113, 1322.151, 3.903546, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5100.597, -1853.859, 1331.938, 2.396782, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5092.283, -1777.014, 1322.115, 2.037452, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5194.689, -1775.331, 1342.855, 3.223399, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5072.396, -1839.01, 1328.062, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5190.926, -1759.95, 1342.667, 3.553266, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5020.804, -1843.785, 1322.097, 1.179404, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5130.223, -1800.01, 1333.659, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 4990.336, -1783.502, 1329.761, 5.228124, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 4998.324, -1779.318, 1330.369, 0, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5188.17, -2116.62, 1292.18, 0.639109, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5199.75, -2131.45, 1283.92, 0.116808, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5183.09, -2146.65, 1294.17, 4.625, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5318.61, -2195.55, 1278.08, 2.33164, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5342.73, -2186.79, 1278.72, 1.73473, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5339.59, -2106.24, 1299.42, 1.3813, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 18304 , 5286.01, -2042.93, 1301.67, 5.59103, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5337.28, -2162.094, 1291.234, 4.607669, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5342.963, -2090.72, 1313.236, 2.164208, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5305.663, -2182.542, 1288.539, 4.782202, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5216.649, -2138.837, 1308.115, 1.850049, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5214.606, -2097.323, 1305.896, 4.712389, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5179.757, -2159.528, 1305.688, 6.021386, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 36, 17906 , 5287.034, -2051.174, 1324.37, 5.846853, 7, 0, 'Alliance Base Overrun Wave 1: Gargoyles and Building Triggers'),
(534, 2, 37, 17895 , 4970.843, -1490.6227, 1331.1044, 3.38510, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4932.6465, -1513.4004, 1327.1511, 4.1604, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4953.0337, -1511.5671, 1327.9634, 3.8337, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4937.6562, -1523.0747, 1326.9093, 3.9628, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4922.0747, -1510.7783, 1328.5364, 4.4987, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4981.2427, -1495.834, 1329.6047, 3.14159, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4927.056, -1505.5154, 1328.645, 4.318649, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4932.151, -1529.0271, 1326.822, 4.063360, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4925.08, -1519.6694, 1327.5283, 4.222558, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4995.994, -1477.6404, 1333.0983, 3.01941, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4918.5664, -1523.387, 1328.8735, 4.34584, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4942.855, -1506.6544, 1327.1387, 4.09632, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4948.5454, -1513.4711, 1327.1642, 3.9961, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4952.3755, -1497.8765, 1329.0007, 4.0474, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 37, 17895 , 4959.3354, -1504.1974, 1328.4275, 3.9663, 7, 0, 'Alliance Base Overrun Wave 2: Ghouls'),
(534, 2, 38, 17895 , 4951.403, -1502.6791, 1328.0724, 4.01615, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4948.6826, -1506.4768, 1327.4067, 4.0704, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4936.4204, -1515.5422, 1326.6766, 4.1655, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4981.944, -1494.0347, 1330.209, 3.394478, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4986.9497, -1483.4932, 1332.5863, 3.0381, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4995.9116, -1491.933, 1329.9983, 0.03490, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4994.5415, -1483.7516, 1331.9319, 2.9967, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5004.8574, -1469.2498, 1333.7131, 1.2566, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5008.95, -1479.7734, 1331.2477, 4.468042, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5008.2188, -1488.4362, 1329.1898, 2.9146, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17897 , 5036.2437, -1490.518, 1333.1152, 3.29867, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17897 , 5033.196, -1465.4146, 1333.7095, 3.97935, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17897 , 4956.776, -1498.8228, 1329.0803, 4.04389, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17898 , 5013.546, -1491.9376, 1328.6943, 1.34390, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17898 , 5009.1587, -1472.7086, 1332.7423, 0.2792, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17898 , 4925.8716, -1511.6364, 1328.0076, 4.2941, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5021.0195, -1493.1372, 1329.5668, 2.7925, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5017.789, -1482.2653, 1330.5186, 3.403392, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5018.1655, -1471.7969, 1332.5211, 2.0943, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 5000.1147, -1477.6276, 1332.5763, 1.7788, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4999.8115, -1486.4004, 1330.5977, 1.6580, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4972.1035, -1500.5131, 1329.4673, 4.0323, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4962.981, -1494.8036, 1330.4316, 1.93731, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4979.8657, -1489.6074, 1331.2712, 5.7246, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4988.24, -1492.4637, 1330.586, 2.3188281, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17895 , 4934.046, -1520.4958, 1326.6613, 4.08217, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17897 , 4966.7993, -1504.6022, 1329.2168, 4.4961, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 38, 17898 , 4936.2837, -1522.2614, 1326.7169, 4.0829, 7, 0, 'Alliance Base Overrun Wave 3: 20 Ghouls, 3 Crypt Fiends, 4 Abominations'),
(534, 2, 39, 18304 , 5542.932, -2687.652, 1481.41, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5395.824, -2869.261, 1512.461, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5533.478, -2650.392, 1480.618, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5200.144, -3029.1, 1569.392, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5438.519, -2687.934, 1486.425, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5396.678, -2875.943, 1512.498, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5416.667, -2750.126, 1486.455, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5361.832, -2975.182, 1538.945, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5446.119, -2704.476, 1486.576, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5343.821, -2962.491, 1537.45, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5567.274, -2768.432, 1496.219, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5443.451, -2698.953, 1486.15, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5514.919, -2805.777, 1499.485, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5515.058, -2621.353, 1484.587, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5580.915, -2624.289, 1488.575, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5379.497, -2833.334, 1513.131, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5537.551, -2807.92, 1498.782, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5388.882, -2845.648, 1513.24, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5504.345, -2960.508, 1538.28, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5532.271, -2677.553, 1479.757, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5589.136, -2739.074, 1494.211, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5497.021, -2987.404, 1539.611, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5397.396, -2864.063, 1512.373, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5426.563, -3003.045, 1550.946, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5600.729, -2694.189, 1494.466, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5336.38, -3107.861, 1582.641, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5427.288, -2732.209, 1485.95, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5402.469, -3007.309, 1549.578, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5398.504, -2882.074, 1513.832, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5361.865, -2833.854, 1511.894, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5394.144, -2847.396, 1512.373, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5319.413, -2969.343, 1537.38, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 39, 18304 , 5191.284, -3018.443, 1569.959, 0, 7, 0, 'Horde Base Overrun Wave 1: Building Triggers'),
(534, 2, 40, 17895 , 5500.83, -2394.47, 1464.087, 5.946418, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5492.911, -2402.083, 1462.72, 4.131364, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5485.671, -2409.407, 1461.317, 0.2625881, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5477.696, -2408.627, 1459.908, 0.1944438, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5485.719, -2398.325, 1461.7, 6.212689, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5501.271, -2382.852, 1463.596, 5.477748, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5492.362, -2389.236, 1462.159, 4.535504, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5472.314, -2399.513, 1459.85, 5.898592, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5466.671, -2390.855, 1461.081, 6.096422, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5477.055, -2385.983, 1461.062, 5.942765, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5487.516, -2380.031, 1461.589, 5.205697, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5495.065, -2375.436, 1462.816, 5.458581, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5490.469, -2366.381, 1462.752, 5.018064, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5480.812, -2372.667, 1461.195, 5.642497, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5468.748, -2381.24, 1462.375, 5.911043, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17895 , 5481.208, -2392.753, 1461.25, 5.585051, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 21075 , 5507.595, -2388.241, 1465.027, 5.986479, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17897 , 5489.01, -2372.279, 1461.898, 5.090302, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17897 , 5474.394, -2377.111, 1461.038, 5.792884, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17897 , 5483.502, -2354.254, 1461.632, 5.0666, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17897 , 5467.474, -2360.167, 1460.624, 5.334022, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 40, 17898 , 5509.863, -2400.571, 1465.539, 4.343841, 7, 0, 'Horde Base Overrun Wave 2: 16 Ghouls, 4 Crypt Fiends, 1 Abominations, 1 Infernal Target'),
(534, 2, 41, 17898 , 5492.67, -2419.203, 1462.786, 0.4728702, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17898 , 5496.631, -2385.819, 1462.68, 5.017105, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17898 , 5476.778, -2395.596, 1460.487, 5.489543, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5504.538, -2402.227, 1464.943, 4.768365, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5486.165, -2402.342, 1461.789, 0.0547436, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5492.584, -2360.202, 1466.426, 5.279465, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5474.823, -2368.184, 1460.863, 5.05423, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5460.088, -2378.418, 1469.516, 5.630795, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5463.875, -2402.761, 1459.793, 6.04456, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5487.01, -2394.076, 1461.719, 5.481238, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5507.824, -2379.372, 1466.459, 4.632452, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5510.295, -2393.919, 1465.538, 5.587405, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5469.084, -2370.722, 1461.52, 5.736789, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5483.893, -2342.307, 1462.35, 4.789686, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5469.628, -2350.953, 1460.199, 5.039412, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5457.844, -2364.158, 1473.461, 5.330197, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5464.175, -2383.035, 1464.405, 5.969, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 41, 17895 , 5506.33, -2393.534, 1464.782, 5.750375, 7, 0, 'Horde Base Overrun Wave 2: 3 Abominations, 15 Ghouls'),
(534, 2, 42, 17895 , 5382.503, -3283.57, 1623.326, 2.740167, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17895 , 5371.666, -3289.222, 1624.289, 4.990488, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17895 , 5372.948, -3280.649, 1622.653, 5.130647, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17897 , 5371.828, -3261.135, 1617.893, 5.014826, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17895 , 5365.365, -3284.092, 1622.767, 5.217218, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17895 , 5373.57, -3272.718, 1620.646, 4.991662, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17895 , 5365.245, -3274.99, 1620.959, 5.226511, 7, 0, 'Night Elf Wave'),
(534, 2, 42, 17898 , 5361.223, -3266.657, 1619.216, 5.216855, 7, 0, 'Night Elf Wave');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 17852 AND `summonerType` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(17852, 0, 0, 17920, 5489.70947265625, -2781.63037109375, 1497.728271484375, 1.326450228691101074, 3, 21000, 'Horde Retreat'),
(17852, 0, 0, 17920, 5480.392578125, -2778.908447265625, 1497.069091796875, 1.047197580337524414, 3, 21000, 'Horde Retreat'),
(17852, 0, 0, 17772, 5486.3046875, -2777.719970703125, 1496.6873779296875, 1.082104086875915527, 3, 21000, 'Horde Retreat');

UPDATE `creature_template` SET `ScriptName` = 'npc_hyjal_jaina' WHERE (`entry` = 17772);
UPDATE `creature_template` SET `ScriptName` = 'npc_hyjal_thrall' WHERE (`entry` = 17852);
UPDATE `creature_template` SET `ScriptName` = 'npc_hyjal_tyrande' WHERE (`entry` = 17948);

UPDATE `creature_template` SET `ScriptName` = 'npc_hyjal_ground_trash' WHERE (`entry` IN (17895, 17897, 17898, 17899, 17905, 17916));
UPDATE `creature_template` SET `ScriptName` = 'npc_hyjal_gargoyle' WHERE (`entry` = 17906);
UPDATE `creature_template` SET `ScriptName` = 'npc_hyjal_frost_wyrm' WHERE (`entry` = 17907);

UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '31317' WHERE (`entry` = 17808);
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '8278' WHERE (`entry` IN (17895, 17906));
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '31260 31745' WHERE (`entry` = 17772);
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '31745' WHERE (`entry` = 17852);
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '31607' WHERE (`entry` = 17898);
UPDATE `creature_template_addon` SET `auras` = '31304' WHERE (`entry` = 17818);
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 17818);

UPDATE `creature_template` SET `detection_range` = 50 WHERE (`entry` IN (17906, 17907));

DELETE FROM `creature_template_addon` WHERE (`entry` = 17902);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17902, 0, 0, 0, 1, 0, 0, '19818');
DELETE FROM `creature_template_addon` WHERE (`entry` = 17933);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17933, 0, 0, 0, 1, 0, 3, '31757');
DELETE FROM `creature_template_addon` WHERE (`entry` = 18036);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18036, 0, 0, 0, 0, 0, 0, '31761');
DELETE FROM `creature_template_addon` WHERE (`entry` = 17854);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17854, 0, 0, 0, 1, 0, 3, '31332');

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 18304);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(18304, 0, 0, 1, 1, 0, 0, 0);

DELETE FROM `npc_text` WHERE `ID` IN (9224, 9409, 9415, 9169, 9228, 9381, 9397, 10675);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`) VALUES
(9224, 'Stranger, make haste and contact Lady Jaina Proudmoore. Her small Alliance force is bravely attempting to blunt the Burning Legion\'s initial assault and delay the approach of Archimonde.', NULL, 14867),
(9409, NULL, 'Your continued help against the Burning Legion would still be appreciated. Thrall could use your assistance in his encampment to the west of here.', 15498),
(9415, NULL, 'Congratulations! A great victory has been won today.', 15512),
(9169, '', 'Thank you, $R. Now prepare yourselves. Archimonde is on the march, and we must hold off the inevitable for as long as we can.', 14699),
(9228, 'Then let the Legion do their worst!', NULL, 14877),
(9381, NULL, 'Then let Archimonde do his worst.', 15394),
(9397, 'May the spirits be with you.', NULL, 15446),
(10675, '', 'These Tears of the Goddess have been blessed by Elune, and their power will help you combat Archimonde\'s vile magics. Use their power well.', 20243);

DELETE FROM `gossip_menu` WHERE (`MenuID` IN (7556, 7584, 7689, 7701, 8533));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7556, 9169),
(7584, 9228),
(7689, 9381),
(7701, 9397),
(8533, 10675);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7552);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7552, 32918, 0, 'My companions and I are with you, Lady Proudmoore.', 14698, 1, 1, 7556, 0, 0, 0, '', 0, 0), -- 14699
(7552, 32919, 0, 'We are ready for whatever Archimonde might send our way, Lady Proudmoore.', 15393, 1, 1, 7689, 0, 0, 0, '', 0, 0), -- 15394
(7552, 32920, 0, 'Until we meet again, Lady Proudmoore.', 15416, 1, 1, 0, 0, 0, 0, '', 0, 0);
DELETE FROM `gossip_menu` WHERE (`MenuID` = 7552);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7552, 9168),
(7552, 9387),
(7552, 9380);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7581);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7581, 35377, 0, 'We have nothing to fear.', 15445, 1, 1, 7701, 0, 0, 0, '', 0, 0), -- 15446
(7581, 35378, 0, 'I am with you, Thrall.', 14875, 1, 1, 7584, 0, 0, 0, '', 0, 0), -- 14877
(7581, 35379, 0, 'Until we meet again, Thrall.', 15449, 1, 1, 0, 0, 0, 0, '', 0, 0);
DELETE FROM `gossip_menu` WHERE (`MenuID` = 7581);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7581, 9224),
(7581, 9225),
(7581, 9396),
(7581, 9398);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7706);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7706, 34158, 0, 'I would be grateful for any aid you can provide, Priestess.', 20242, 1, 1, 8533, 0, 0, 0, '', 0, 0); -- 20243
DELETE FROM `gossip_menu` WHERE (`MenuID` = 7706);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7706, 9415),
(7706, 9410),
(7706, 9408),
(7706, 9409);

DELETE FROM `creature_text` WHERE `CreatureID` = 17772 AND `GroupID` = 7;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `Text`, `Type`, `Probability`, `BroadcastTextId`, `comment`) VALUES (17772, 7, '%s begins channelling a massive teleport spell. ', 16, 100, 15310, 'jaina hyjal SPELL');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` IN (7552, 7581, 7706));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Jaina Text
(14, 7552, 9168, 0, 0, 13, 0, 1, 3, 2, 1, 0, 0, '', 'Show gossip text if Rage Winterchill is not defeated'),

(14, 7552, 9380, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip text if Rage Winterchill is defeated'),
(14, 7552, 9380, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip text if Anetheron is not defeated'),

(14, 7552, 9387, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip text if Rage Winterchill is defeated'),
(14, 7552, 9387, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip text if Anetheron is defeated'),

-- Thrall Text
(14, 7581, 9224, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip text if Anetheron is not defeated'),

(14, 7581, 9225, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip text if Anetheron is defeated'),
(14, 7581, 9225, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip text if Kaz\'rogal is not defeated'),

(14, 7581, 9396, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip text if Kaz\'rogal is defeated'),
(14, 7581, 9396, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip text if Azgalor is not defeated'),

(14, 7581, 9398, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip text if Kaz\'rogal is defeated'),
(14, 7581, 9398, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip text if Azgalor is defeated'),

-- Tyrande Text
(14, 7706, 9408, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip text if Anetheron is not defeated'),
(14, 7706, 9408, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip text if Azgalor is not defeated'),

(14, 7706, 9409, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip text if Anetheron is defeated'),
(14, 7706, 9409, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip text if Azgalor is not defeated'),

(14, 7706, 9410, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip text if Azgalor is defeated'),

(14, 7706, 9415, 0, 0, 13, 0, 5, 3, 2, 0, 0, 0, '', 'Show gossip text if Archimonde is defeated');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` IN (7552, 7581, 7706));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Jaina Options
(15, 7552, 32918, 0, 0, 13, 0, 1, 3, 2, 1, 0, 0, '', 'Show gossip option if Rage Winterchill is not defeated'),

(15, 7552, 32919, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip option if Rage Winterchill is defeated'),
(15, 7552, 32919, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip option if Anetheron is not defeated'),

(15, 7552, 32920, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip option if Rage Winterchill is defeated'),
(15, 7552, 32920, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip option if Anetheron is defeated'),

-- Thrall Options
(15, 7581, 35378, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip option if Anetheron is defeated'),
(15, 7581, 35378, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip option if Kaz\'rogal is not defeated'),

(15, 7581, 35377, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip option if Kaz\'rogal is defeated'),
(15, 7581, 35377, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip option if Azgalor is not defeated'),

(15, 7581, 35379, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip option if Kaz\'rogal is defeated'),
(15, 7581, 35379, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip option if Azgalor is defeated'),

-- Tyrande Options
(15, 7706, 34158, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip option if Azgalor is defeated'),
(15, 7706, 34158, 0, 0, 13, 0, 5, 3, 2, 1, 0, 0, '', 'Show gossip option if Archimonde is not defeated');

DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (17906, 17907));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(17906, 1, 0, 1, 0, 0, 0, 0),
(17907, 1, 0, 1, 0, 0, 0, 0);

UPDATE `creature_text` SET `Emote` = 396 WHERE  `CreatureID` = 17772 AND `GroupID` = 5 AND `ID` = 0;

SET @OGUID := 139500;
DELETE FROM `gameobject` WHERE `map` = 534;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+0  , 182061, 534, 3606, 3606, 1, 1, 4204.478515625, -4112.27734375, 877.912841796875, 4.985381603240966796, 0, 0, -0.60431194305419921, 0.796747803688049316, 604800, 255, 1, 53162), -- 182061 (Area: 3606 - Difficulty: 0) CreateObject1
(@OGUID+1  , 182060, 534, 3606, 3606, 1, 1, 4270.9638671875, -4143.02685546875, 870.72320556640625, 6.020715236663818359, -0.01575565338134765, -0.00750446319580078, -0.13097667694091796, 0.991231858730316162, 604800, 255, 1, 53162), -- 182060 (Area: 3606 - Difficulty: 0) CreateObject1
(@OGUID+2  , 184287, 534, 3606, 3707, 1, 1, 5013.5263671875, -1838.722412109375, 1321.9661865234375, 0.816388189792633056, 0.013092994689941406, 0.024672508239746093, 0.396448135375976562, 0.917632102966308593, 604800, 255, 1, 53162), -- 184287 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+3  , 123244, 534, 3606, 3707, 1, 1, 4978.14453125, -1764.708740234375, 1331.2066650390625, 5.419246673583984375, 0, 0, -0.41866016387939453, 0.90814298391342163, 604800, 255, 1, 53162), -- 123244 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+4  , 4087, 534, 3606, 3707, 1, 1, 4988.1376953125, -1763.5850830078125, 1331.2066650390625, 3.935721635818481445, 0, 0, -0.92220020294189453, 0.386712819337844848, 604800, 255, 1, 53162), -- 4087 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+5  , 4089, 534, 3606, 3707, 1, 1, 4983.97216796875, -1776.3953857421875, 1331.2066650390625, 2.495818138122558593, 0, 0, 0.948323249816894531, 0.317305892705917358, 604800, 255, 1, 53162), -- 4089 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+6  , 4088, 534, 3606, 3707, 1, 1, 4979.12451171875, -1773.0966796875, 1331.2066650390625, 0.462512165307998657, 0, 0, 0.229200363159179687, 0.973379254341125488, 604800, 255, 1, 53162), -- 4088 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+7  , 4090, 534, 3606, 3707, 1, 1, 4983.685546875, -1768.298828125, 1329.398681640625, 1.701695561408996582, 0, 0, 0.751839637756347656, 0.659345984458923339, 604800, 255, 1, 53162), -- 4090 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+8  , 185557, 534, 3606, 3707, 1, 1, 5215.14794921875, -1953.326416015625, 1372.6842041015625, 4.555310726165771484, 0, 0, -0.76040554046630859, 0.649448513984680175, 604800, 255, 1, 53162), -- 185557 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+9  , 185557, 534, 3606, 3707, 1, 1, 5278.08056640625, -1903.9742431640625, 1359.6258544921875, 4.084071159362792968, 0, 0, -0.8910064697265625, 0.453990638256072998, 604800, 255, 1, 53162), -- 185557 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+10 , 182260, 534, 3606, 3707, 1, 1, 5187.81591796875, -2122.810302734375, 1287.503662109375, 4.310965538024902343, 0, 0, -0.83388519287109375, 0.55193793773651123, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+11 , 182260, 534, 3606, 3707, 1, 1, 5188.443359375, -2139.917236328125, 1293.0350341796875, 1.762782454490661621, 0, 0, 0.771624565124511718, 0.636078238487243652, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+12 , 182260, 534, 3606, 3707, 1, 1, 5283.517578125, -2041.5885009765625, 1300.8538818359375, 3.769911527633666992, 0, 0, -0.95105648040771484, 0.309017121791839599, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+13 , 182260, 534, 3606, 3707, 1, 1, 5199.578125, -2130.48388671875, 1274.146484375, 4.939284324645996093, 0, 0, -0.6225137710571289, 0.78260880708694458, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+14 , 182260, 534, 3606, 3707, 1, 1, 5283.10986328125, -2040.181884765625, 1288.326171875, 2.757613182067871093, 0, 0, 0.981626510620117187, 0.190812408924102783, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+15 , 182260, 534, 3606, 3707, 1, 1, 5273.40185546875, -2049.47216796875, 1295.739013671875, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+16 , 182260, 534, 3606, 3707, 1, 1, 5332.52197265625, -2115.94970703125, 1297.610107421875, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+17 , 182260, 534, 3606, 3707, 1, 1, 5330.31005859375, -2183.4599609375, 1313.720947265625, 2.897245407104492187, 0, 0, 0.99254608154296875, 0.121869951486587524, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+18 , 182260, 534, 3606, 3707, 1, 1, 5330.1005859375, -2106.81689453125, 1280.8927001953125, 5.70722818374633789, 0, 0, -0.28401470184326171, 0.958819925785064697, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+19 , 182260, 534, 3606, 3707, 1, 1, 5340.5927734375, -2105.55859375, 1299.049560546875, 1.884953022003173828, 0, 0, 0.809016227722167968, 0.587786316871643066, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+20 , 182260, 534, 3606, 3707, 1, 1, 5316.76513671875, -2179.8095703125, 1263.9647216796875, 3.211419343948364257, 0, 0, -0.9993906021118164, 0.034906134009361267, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+21 , 182260, 534, 3606, 3707, 1, 1, 5315.17578125, -2197.548095703125, 1278.5108642578125, 0.139624491333961486, 0, 0, 0.06975555419921875, 0.997564136981964111, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+22 , 182260, 534, 3606, 3707, 1, 1, 5344.984375, -2184.541748046875, 1277.7115478515625, 4.520402908325195312, 0, 0, -0.77162456512451171, 0.636078238487243652, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+23 , 182260, 534, 3606, 3707, 1, 1, 5328.7001953125, -2203.264892578125, 1263.962890625, 3.961898565292358398, 0, 0, -0.91705989837646484, 0.398749500513076782, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+24 , 182260, 534, 3606, 3707, 1, 1, 4938.51025390625, -1897.7965087890625, 1350.161376953125, 4.660029888153076171, 0, 0, -0.72537422180175781, 0.688354730606079101, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+25 , 182260, 534, 3606, 3707, 1, 1, 4928.3427734375, -1881.8953857421875, 1352.351318359375, 3.385940074920654296, 0, 0, -0.99254608154296875, 0.121869951486587524, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+26 , 182260, 534, 3606, 3707, 1, 1, 4941.337890625, -1889.82421875, 1326.584228515625, 0.453785061836242675, 0, 0, 0.224950790405273437, 0.974370121955871582, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+27 , 182260, 534, 3606, 3707, 1, 1, 4928.025390625, -1893.2095947265625, 1358.5079345703125, 5.201082706451416015, 0, 0, -0.51503753662109375, 0.857167601585388183, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+28 , 182260, 534, 3606, 3707, 1, 1, 4943.23974609375, -1899.404052734375, 1326.584228515625, 2.827429771423339843, 0, 0, 0.987688064575195312, 0.156436234712600708, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+29 , 182260, 534, 3606, 3707, 1, 1, 4925.28369140625, -1913.775634765625, 1326.584228515625, 3.141592741012573242, 0, 0, -1, 0, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+30 , 182260, 534, 3606, 3707, 1, 1, 4920.0556640625, -1897.635009765625, 1361.6788330078125, 4.520402908325195312, 0, 0, -0.77162456512451171, 0.636078238487243652, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+31 , 182260, 534, 3606, 3707, 1, 1, 4932.705078125, -1886.1610107421875, 1361.70166015625, 3.43830275535583496, 0, 0, -0.98901557922363281, 0.147811368107795715, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+32 , 182260, 534, 3606, 3707, 1, 1, 4930.05810546875, -1875.3624267578125, 1326.5714111328125, 4.066620349884033203, 0, 0, -0.89493370056152343, 0.44619917869567871, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+33 , 185557, 534, 3606, 3707, 1, 1, 5076.06884765625, -2087.197998046875, 1374.9371337890625, 4.9218292236328125, 0, 0, -0.62932014465332031, 0.77714616060256958, 604800, 255, 1, 53162), -- 185557 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+34 , 182260, 534, 3606, 3707, 1, 1, 4978.92626953125, -1777.5262451171875, 1339.6845703125, 3.490667104721069335, 0, 0, -0.98480701446533203, 0.173652306199073791, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+35 , 182260, 534, 3606, 3707, 1, 1, 4989.34228515625, -1777.646240234375, 1331.1583251953125, 4.520402908325195312, 0, 0, -0.77162456512451171, 0.636078238487243652, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+36 , 182260, 534, 3606, 3707, 1, 1, 4982.21630859375, -1757.9678955078125, 1331.1566162109375, 0.942476630210876464, 0, 0, 0.453989982604980468, 0.891006767749786376, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+37 , 182260, 534, 3606, 3707, 1, 1, 4990.36669921875, -1760.357177734375, 1337.9302978515625, 4.136432647705078125, 0, 0, -0.87881660461425781, 0.477159708738327026, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+38 , 182260, 534, 3606, 3707, 1, 1, 5094.56396484375, -1785.1951904296875, 1358.8878173828125, 3.822272777557373046, 0, 0, -0.94264125823974609, 0.333807557821273803, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+39 , 182260, 534, 3606, 3707, 1, 1, 5106.8076171875, -1792.005859375, 1380.7410888671875, 5.131268978118896484, 0, 0, -0.54463863372802734, 0.838670849800109863, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+40 , 182260, 534, 3606, 3707, 1, 1, 5116.3740234375, -1783.4005126953125, 1322.6373291015625, 2.897245407104492187, 0, 0, 0.99254608154296875, 0.121869951486587524, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+41 , 182260, 534, 3606, 3707, 1, 1, 5126.8193359375, -1801.204345703125, 1373.644775390625, 4.712389945983886718, 0, 0, -0.70710659027099609, 0.707106947898864746, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+42 , 182260, 534, 3606, 3707, 1, 1, 5114.1005859375, -1785.2816162109375, 1333.1578369140625, 4.817109584808349609, 0, 0, -0.66913032531738281, 0.74314504861831665, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+43 , 182260, 534, 3606, 3707, 1, 1, 5115.263671875, -1778.404541015625, 1357.0107421875, 0.593410074710845947, 0, 0, 0.292370796203613281, 0.95630502700805664, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+44 , 182260, 534, 3606, 3707, 1, 1, 5086.306640625, -1788.9495849609375, 1322.6217041015625, 4.276057243347167968, 0, 0, -0.84339141845703125, 0.537299633026123046, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+45 , 182260, 534, 3606, 3707, 1, 1, 5118.95263671875, -1797.6324462890625, 1357.0426025390625, 1.256635904312133789, 0, 0, 0.587784767150878906, 0.809017360210418701, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+46 , 182260, 534, 3606, 3707, 1, 1, 5082.1767578125, -1724.0963134765625, 1328.7391357421875, 0, 0, 0, 0, 1, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+47 , 182260, 534, 3606, 3707, 1, 1, 5017.2255859375, -1845.88330078125, 1326.8458251953125, 3.351046562194824218, 0, 0, -0.99452114105224609, 0.104535527527332305, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+48 , 182260, 534, 3606, 3707, 1, 1, 5062.7353515625, -1831.2174072265625, 1327.9251708984375, 2.775068521499633789, 0, 0, 0.983254432678222656, 0.182238012552261352, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+49 , 182260, 534, 3606, 3707, 1, 1, 5070.4931640625, -1823.5521240234375, 1339.2427978515625, 2.844882726669311523, 0, 0, 0.989015579223632812, 0.147811368107795715, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+50 , 182260, 534, 3606, 3707, 1, 1, 5067.134765625, -1836.27783203125, 1339.152099609375, 5.340708732604980468, 0, 0, -0.45398998260498046, 0.891006767749786376, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+51 , 182260, 534, 3606, 3707, 1, 1, 5121.8310546875, -1737.0841064453125, 1335.408447265625, 2.495818138122558593, 0, 0, 0.948323249816894531, 0.317305892705917358, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+52 , 182260, 534, 3606, 3707, 1, 1, 5213.44482421875, -1753.2252197265625, 1354.6724853515625, 2.111847877502441406, 0, 0, 0.870355606079101562, 0.492423713207244873, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+53 , 182260, 534, 3606, 3707, 1, 1, 5199.486328125, -1764.7958984375, 1343.185546875, 3.420850038528442382, 0, 0, -0.99026775360107421, 0.139175355434417724, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+54 , 182260, 534, 3606, 3707, 1, 1, 5218.9130859375, -1762.0517578125, 1343.3033447265625, 4.939284324645996093, 0, 0, -0.6225137710571289, 0.78260880708694458, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+55 , 182260, 534, 3606, 3707, 1, 1, 5206.42724609375, -1771.3101806640625, 1359.993408203125, 3.403396368026733398, 0, 0, -0.99144458770751953, 0.130528271198272705, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+56 , 182260, 534, 3606, 3707, 1, 1, 5102.9873046875, -1855.8121337890625, 1332.6861572265625, 5.89921426773071289, 0, 0, -0.19080829620361328, 0.981627285480499267, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+57 , 182260, 534, 3606, 3707, 1, 1, 5101.32275390625, -1860.2847900390625, 1339.4578857421875, 2.984498262405395507, 0, 0, 0.996916770935058593, 0.078466430306434631, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject2
(@OGUID+58 , 182260, 534, 3606, 3707, 1, 1, 5108.23095703125, -2431.15625, 1428.3387451171875, 2.321286916732788085, 0, 0, 0.917059898376464843, 0.398749500513076782, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+59 , 182260, 534, 3606, 3707, 1, 1, 5104.326171875, -2450.204833984375, 1446.2335205078125, 3.368495941162109375, 0, 0, -0.99357128143310546, 0.113208353519439697, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+60 , 182260, 534, 3606, 3707, 1, 1, 5090.99951171875, -2451.986572265625, 1435.15576171875, 5.323255538940429687, 0, 0, -0.46174812316894531, 0.887011110782623291, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+61 , 182260, 534, 3606, 3707, 1, 1, 5088.3134765625, -2452.7421875, 1446.21826171875, 3.839725255966186523, 0, 0, -0.93969249725341796, 0.34202045202255249, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+62 , 182260, 534, 3606, 3707, 1, 1, 5095.5830078125, -2472.818603515625, 1435.15576171875, 6.09120035171508789, 0, 0, -0.09584522247314453, 0.995396256446838378, 604800, 255, 1, 53162), -- 182260 (Area: 3707 - Difficulty: 4) CreateObject1
(@OGUID+63 , 185557, 534, 3606, 0, 1, 1, 5049.34814453125, -2275.472900390625, 1402.9879150390625, 4.572763919830322265, 0, 0, -0.75470924377441406, 0.656059443950653076, 604800, 255, 1, 53162), -- 185557 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+64 , 185557, 534, 3606, 0, 1, 1, 5164.81494140625, -2454.755126953125, 1437.5751953125, 0.785396754741668701, 0, 0, 0.38268280029296875, 0.923879802227020263, 604800, 255, 1, 53162), -- 185557 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+65 , 3864, 534, 3606, 0, 1, 1, 5379.05078125, -2661.9599609375, 1494.13037109375, 1.605701684951782226, 0, 0, 0.719339370727539062, 0.694658815860748291, 604800, 255, 1, 53162), -- 3864 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+66 , 3882, 534, 3606, 0, 1, 1, 5373.4453125, -2665.101318359375, 1494.13037109375, 4.057891845703125, 0, 0, -0.89687252044677734, 0.442289173603057861, 604800, 255, 1, 53162), -- 3882 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+67 , 3963, 534, 3606, 0, 1, 1, 5559.12451171875, -2663.4501953125, 1482.6217041015625, 0.401424884796142578, 0, 0, 0.199367523193359375, 0.979924798011779785, 604800, 255, 1, 53162), -- 3963 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+68 , 3964, 534, 3606, 0, 1, 1, 5544.18603515625, -2669.791259765625, 1482.6217041015625, 2.74888467788696289, 0, 0, 0.980784416198730468, 0.195094630122184753, 604800, 255, 1, 53162), -- 3964 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+69 , 3872, 534, 3606, 0, 1, 1, 5423.33056640625, -2680.66796875, 1494.13037109375, 2.199114561080932617, 0, 0, 0.8910064697265625, 0.453990638256072998, 604800, 255, 1, 53162), -- 3872 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+70 , 3876, 534, 3606, 0, 1, 1, 5409.93798828125, -2675.78076171875, 1494.1307373046875, 2.44346022605895996, 0, 0, 0.939692497253417968, 0.34202045202255249, 604800, 255, 1, 53162), -- 3876 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+71 , 3885, 534, 3606, 0, 1, 1, 5391.73681640625, -2668.054931640625, 1494.139404296875, 3.394674062728881835, 0, 0, -0.99200439453125, 0.126203224062919616, 604800, 255, 1, 53162), -- 3885 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+72 , 188214, 534, 3606, 0, 1, 1, 5467.0791015625, -2657.21875, 1482.157958984375, 3.647741317749023437, -0.01360893249511718, 0.017047882080078125, -0.96796131134033203, 0.250150144100189208, 604800, 255, 1, 53162), -- 188214 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+73 , 3871, 534, 3606, 0, 1, 1, 5424.75048828125, -2686.935302734375, 1494.13037109375, 6.03011322021484375, 0, 0, -0.12619876861572265, 0.992004990577697753, 604800, 255, 1, 53162), -- 3871 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+74 , 3877, 534, 3606, 0, 1, 1, 5416.8271484375, -2698.23193359375, 1494.139404296875, 1.736601948738098144, 0, 0, 0.763232231140136718, 0.646124243736267089, 604800, 255, 1, 53162), -- 3877 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+75 , 3881, 534, 3606, 0, 1, 1, 5373.2080078125, -2676.96484375, 1494.139404296875, 3.953172922134399414, 0, 0, -0.91879081726074218, 0.394744753837585449, 604800, 255, 1, 53162), -- 3881 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+76 , 3886, 534, 3606, 0, 1, 1, 5405.45654296875, -2694.798583984375, 1494.26416015625, 0.776669740676879882, 0, 0, 0.378647804260253906, 0.925540864467620849, 604800, 255, 1, 53162), -- 3886 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+77 , 174861, 534, 3606, 0, 1, 1, 5380.89794921875, -2684.800537109375, 1494.26416015625, 0.776669740676879882, 0, 0, 0.378647804260253906, 0.925540864467620849, 604800, 255, 1, 53162), -- 174861 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+78 , 3865, 534, 3606, 0, 1, 1, 5382.48291015625, -2694.75341796875, 1494.311767578125, 1.169370889663696289, 0, 0, 0.551937103271484375, 0.833885729312896728, 604800, 255, 1, 53162), -- 3865 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+79 , 3866, 534, 3606, 0, 1, 1, 5374.2880859375, -2701.050537109375, 1494.26416015625, 1.919861555099487304, 0, 0, 0.819151878356933593, 0.573576688766479492, 604800, 255, 1, 53162), -- 3866 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+80 , 3875, 534, 3606, 0, 1, 1, 5414.3994140625, -2708.332763671875, 1494.139404296875, 1.326450586318969726, 0, 0, 0.61566162109375, 0.788010656833648681, 604800, 255, 1, 53162), -- 3875 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+81 , 3874, 534, 3606, 0, 1, 1, 5398.80517578125, -2711.22607421875, 1494.26416015625, 1.754055619239807128, 0, 0, 0.768841743469238281, 0.639439105987548828, 604800, 255, 1, 53162), -- 3874 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+82 , 3878, 534, 3606, 0, 1, 1, 5408.40380859375, -2717.159423828125, 1494.139404296875, 0.933750271797180175, 0, 0, 0.450098037719726562, 0.892979145050048828, 604800, 255, 1, 53162), -- 3878 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+83 , 3880, 534, 3606, 0, 1, 1, 5365.412109375, -2687.127197265625, 1494.139404296875, 4.424411773681640625, 0, 0, -0.80125331878662109, 0.598325252532958984, 604800, 255, 1, 53162), -- 3880 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+84 , 174860, 534, 3606, 0, 1, 1, 5397.0439453125, -2700.93408203125, 1494.311767578125, 1.169370889663696289, 0, 0, 0.551937103271484375, 0.833885729312896728, 604800, 255, 1, 53162), -- 174860 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+85 , 3879, 534, 3606, 0, 1, 1, 5363.07080078125, -2697.57470703125, 1494.139404296875, 4.808383941650390625, 0, 0, -0.67236614227294921, 0.740218758583068847, 604800, 255, 1, 53162), -- 3879 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+86 , 3870, 534, 3606, 0, 1, 1, 5400.64013671875, -2734.027587890625, 1494.13037109375, 4.747295856475830078, 0, 0, -0.69465827941894531, 0.719339847564697265, 604800, 255, 1, 53162), -- 3870 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+87 , 3873, 534, 3606, 0, 1, 1, 5406.125, -2730.839599609375, 1494.13037109375, 0.916295051574707031, 0, 0, 0.442287445068359375, 0.896873354911804199, 604800, 255, 1, 53162), -- 3873 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+88 , 3867, 534, 3606, 0, 1, 1, 5354.8544921875, -2708.796142578125, 1494.13037109375, 3.176533222198486328, 0, 0, -0.999847412109375, 0.017469281330704689, 604800, 255, 1, 53162), -- 3867 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+89 , 3869, 534, 3606, 0, 1, 1, 5356.30029296875, -2714.799072265625, 1494.13037109375, 5.628688335418701171, 0, 0, -0.32143878936767578, 0.946930348873138427, 604800, 255, 1, 53162), -- 3869 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+90 , 3883, 534, 3606, 0, 1, 1, 5387.69140625, -2727.599365234375, 1494.139404296875, 0.165804952383041381, 0, 0, 0.082807540893554687, 0.996565580368041992, 604800, 255, 1, 53162), -- 3883 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+91 , 3884, 534, 3606, 0, 1, 1, 5369.78955078125, -2720.187255859375, 1494.139404296875, 5.532694816589355468, 0, 0, -0.3665008544921875, 0.93041771650314331, 604800, 255, 1, 53162), -- 3884 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+92 , 3936, 534, 3606, 0, 1, 1, 5536.89599609375, -2814.41015625, 1500.098876953125, 3.935721635818481445, 0, 0, -0.92220020294189453, 0.386712819337844848, 604800, 255, 1, 53162), -- 3936 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+93 , 3941, 534, 3606, 0, 1, 1, 5525.88916015625, -2813.77197265625, 1513.5479736328125, 4.956734657287597656, 0, 0, -0.61566162109375, 0.788010656833648681, 604800, 255, 1, 53162), -- 3941 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+94 , 3939, 534, 3606, 0, 1, 1, 5523.18115234375, -2824.68017578125, 1500.098876953125, 3.935721635818481445, 0, 0, -0.92220020294189453, 0.386712819337844848, 604800, 255, 1, 53162), -- 3939 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+95 , 3943, 534, 3606, 0, 1, 1, 5525.6845703125, -2818.4501953125, 1548.40283203125, 4.598942279815673828, 0, 0, -0.74605751037597656, 0.665881514549255371, 604800, 255, 1, 53162), -- 3943 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+96 , 3942, 534, 3606, 0, 1, 1, 5544.47216796875, -2821.354736328125, 1513.5479736328125, 5.044002056121826171, 0, 0, -0.58070278167724609, 0.814115643501281738, 604800, 255, 1, 53162), -- 3942 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+97 , 3937, 534, 3606, 0, 1, 1, 5535.37841796875, -2831.083251953125, 1548.40283203125, 3.796092510223388671, 0, 0, -0.946929931640625, 0.321440041065216064, 604800, 255, 1, 53162), -- 3937 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+98 , 3938, 534, 3606, 0, 1, 1, 5538.732421875, -2830.908935546875, 1500.098876953125, 3.935721635818481445, 0, 0, -0.92220020294189453, 0.386712819337844848, 604800, 255, 1, 53162), -- 3938 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+99 , 3940, 534, 3606, 0, 1, 1, 5528.0654296875, -2833.802734375, 1513.5479736328125, 4.886923789978027343, 0, 0, -0.64278697967529296, 0.766044974327087402, 604800, 255, 1, 53162), -- 3940 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+100, 50548, 534, 3606, 3708, 1, 1, 5374.189453125, -2848.66943359375, 1512.9012451171875, 2.234017848968505859, 0, 0, 0.898793220520019531, 0.438372820615768432, 604800, 255, 1, 53162), -- 50548 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+101, 50549, 534, 3606, 3708, 1, 1, 5376.28515625, -2872.8447265625, 1512.9012451171875, 2.932138919830322265, 0, 0, 0.994521141052246093, 0.104535527527332305, 604800, 255, 1, 53162), -- 50549 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+102, 50547, 534, 3606, 3708, 1, 1, 5353.5244140625, -2865.03564453125, 1512.9012451171875, 2.757613182067871093, 0, 0, 0.981626510620117187, 0.190812408924102783, 604800, 255, 1, 53162), -- 50547 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+103, 3847, 534, 3606, 3708, 1, 1, 5561.392578125, -2979.39892578125, 1538.21435546875, 4.2335052490234375, -0.00284957885742187, 0.00330352783203125, -0.85462474822998046, 0.519227802753448486, 604800, 255, 1, 53162), -- 3847 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+104, 3849, 534, 3606, 3708, 1, 1, 5554.4931640625, -3001.116455078125, 1538.2132568359375, 1.859830856323242187, 0.004130840301513671, 0.00140380859375, 0.80156707763671875, 0.597888946533203125, 604800, 255, 1, 53162), -- 3849 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+105, 3848, 534, 3606, 3708, 1, 1, 5562.9384765625, -2996.892822265625, 1538.1544189453125, 2.667057752609252929, 0.004350662231445312, -0.00032997131347656, 0.971975326538085937, 0.235042378306388854, 604800, 255, 1, 53162), -- 3848 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+106, 3851, 534, 3606, 3708, 1, 1, 5543.36669921875, -2980.912109375, 1538.33203125, 4.626189708709716796, -0.00215053558349609, 0.003795623779296875, -0.73690700531005859, 0.675980091094970703, 604800, 255, 1, 53162), -- 3851 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+107, 3850, 534, 3606, 3708, 1, 1, 5540.91943359375, -2991.173583984375, 1538.3248291015625, 0.079625084996223449, 0.001507759094238281, 0.004094123840332031, 0.039794921875, 0.999198377132415771, 604800, 255, 1, 53162), -- 3850 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+108, 174859, 534, 3606, 3708, 1, 1, 5565.7578125, -2987.655029296875, 1538.1558837890625, 4.399306297302246093, -0.00256633758544921, 0.003528594970703125, -0.80869293212890625, 0.588214874267578125, 604800, 255, 1, 53162), -- 174859 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+109, 106325, 534, 3606, 3708, 1, 1, 5353.798828125, -2993.3759765625, 1538.8648681640625, 4.773476600646972656, 0, 0, -0.68518257141113281, 0.728371381759643554, 604800, 255, 1, 53162), -- 106325 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+110, 149038, 534, 3606, 3708, 1, 1, 5341.82373046875, -2993.12255859375, 1538.72705078125, 1.867502212524414062, 0, 0, 0.803856849670410156, 0.594822824001312255, 604800, 255, 1, 53162), -- 149038 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+111, 106327, 534, 3606, 3708, 1, 1, 5351.93994140625, -3004.6728515625, 1538.8648681640625, 4.773476600646972656, 0, 0, -0.68518257141113281, 0.728371381759643554, 604800, 255, 1, 53162), -- 106327 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+112, 106335, 534, 3606, 3708, 1, 1, 5328.55712890625, -2986.125732421875, 1538.8648681640625, 3.988081216812133789, 0, 0, -0.91176128387451171, 0.410720497369766235, 604800, 255, 1, 53162), -- 106335 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+113, 106326, 534, 3606, 3708, 1, 1, 5330.09716796875, -3001.154052734375, 1538.8648681640625, 3.988081216812133789, 0, 0, -0.91176128387451171, 0.410720497369766235, 604800, 255, 1, 53162), -- 106326 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+114, 106336, 534, 3606, 3708, 1, 1, 5341.97412109375, -3007.722412109375, 1538.8648681640625, 5.105089664459228515, 0, 0, -0.55556964874267578, 0.831470012664794921, 604800, 255, 1, 53162), -- 106336 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+115, 182260, 534, 3606, 3708, 1, 1, 5508.66845703125, -2619.673583984375, 1512.0902099609375, 2.303830623626708984, 0, 0, 0.913544654846191406, 0.406738430261611938, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+116, 182260, 534, 3606, 3708, 1, 1, 5517.22314453125, -2605.16845703125, 1505.749755859375, 5.427974700927734375, 0, 0, -0.41469287872314453, 0.909961462020874023, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+117, 182260, 534, 3606, 3708, 1, 1, 5548.234375, -2667.694580078125, 1488.437744140625, 4.48549652099609375, 0, 0, -0.7826080322265625, 0.622514784336090087, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+118, 182260, 534, 3606, 3708, 1, 1, 5562.8974609375, -2658.546875, 1485.9754638671875, 2.897245407104492187, 0, 0, 0.99254608154296875, 0.121869951486587524, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+119, 182260, 534, 3606, 3708, 1, 1, 5600.775390625, -2695.671875, 1496.8739013671875, 3.577930212020874023, 0, 0, -0.97629547119140625, 0.216442063450813293, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+120, 182260, 534, 3606, 3708, 1, 1, 5600.45751953125, -2695.50341796875, 1517.120849609375, 5.462882041931152343, 0, 0, -0.39874839782714843, 0.917060375213623046, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+121, 182260, 534, 3606, 3708, 1, 1, 5516.10791015625, -2832.9609375, 1522.7593994140625, 4.869470596313476562, 0, 0, -0.64944744110107421, 0.760406434535980224, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+122, 182260, 534, 3606, 3708, 1, 1, 5522.52587890625, -2808.819091796875, 1499.97412109375, 4.502951622009277343, 0, 0, -0.7771453857421875, 0.629321098327636718, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+123, 182260, 534, 3606, 3708, 1, 1, 5540.10546875, -2808.272705078125, 1524.369384765625, 2.321286916732788085, 0, 0, 0.917059898376464843, 0.398749500513076782, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+124, 182260, 534, 3606, 3708, 1, 1, 5526.0703125, -2823.3212890625, 1548.36669921875, 1.867502212524414062, 0, 0, 0.803856849670410156, 0.594822824001312255, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+125, 182260, 534, 3606, 3708, 1, 1, 5536.74462890625, -2816.225830078125, 1561.3233642578125, 4.817109584808349609, 0, 0, -0.66913032531738281, 0.74314504861831665, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+126, 182260, 534, 3606, 3708, 1, 1, 5376.74853515625, -2727.007080078125, 1494.0244140625, 5.044002056121826171, 0, 0, -0.58070278167724609, 0.814115643501281738, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+127, 182260, 534, 3606, 3708, 1, 1, 5401.17724609375, -2668.272705078125, 1494.02490234375, 0.226892471313476562, 0, 0, 0.113203048706054687, 0.993571877479553222, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+128, 182260, 534, 3606, 3708, 1, 1, 5365.26904296875, -2700.97216796875, 1514.8056640625, 3.735006093978881835, 0, 0, -0.95630455017089843, 0.292372345924377441, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+129, 182260, 534, 3606, 3708, 1, 1, 5414.09375, -2739.225830078125, 1523.8563232421875, 3.141592741012573242, 0, 0, -1, 0, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+130, 182260, 534, 3606, 3708, 1, 1, 5434.236328125, -2676.279541015625, 1527.8502197265625, 2.094393253326416015, 0, 0, 0.866024971008300781, 0.50000077486038208, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+131, 182260, 534, 3606, 3708, 1, 1, 5344.68603515625, -2735.420166015625, 1531.549560546875, 4.59021615982055664, 0, 0, -0.74895572662353515, 0.662620067596435546, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+132, 182260, 534, 3606, 3708, 1, 1, 5389.7275390625, -2697.491455078125, 1493.0650634765625, 3.961898565292358398, 0, 0, -0.91705989837646484, 0.398749500513076782, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+133, 182260, 534, 3606, 3708, 1, 1, 5402.796875, -2707.010498046875, 1536.3311767578125, 2.286378860473632812, 0, 0, 0.909960746765136718, 0.414694398641586303, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+134, 182260, 534, 3606, 3708, 1, 1, 5378.009765625, -2646.5712890625, 1537.5450439453125, 1.256635904312133789, 0, 0, 0.587784767150878906, 0.809017360210418701, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+135, 182260, 534, 3606, 3708, 1, 1, 5429.19189453125, -2714.864501953125, 1493.7403564453125, 2.146752834320068359, 0, 0, 0.878816604614257812, 0.477159708738327026, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+136, 182260, 534, 3606, 3708, 1, 1, 5576.3662109375, -2630.864501953125, 1519.0894775390625, 5.183629035949707031, 0, 0, -0.52249813079833984, 0.852640450000762939, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+137, 182260, 534, 3606, 3708, 1, 1, 5583.15966796875, -2631.350830078125, 1502.1832275390625, 3.996806621551513671, 0, 0, -0.90996074676513671, 0.414694398641586303, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+138, 182260, 534, 3606, 3708, 1, 1, 5367.7119140625, -2861.563720703125, 1512.8070068359375, 4.817109584808349609, 0, 0, -0.66913032531738281, 0.74314504861831665, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+139, 182260, 534, 3606, 3708, 1, 1, 5371.72119140625, -2861.241455078125, 1538.8519287109375, 2.199114561080932617, 0, 0, 0.8910064697265625, 0.453990638256072998, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+140, 182260, 534, 3606, 3708, 1, 1, 5391.5703125, -2883.248291015625, 1515.263427734375, 4.328419685363769531, 0, 0, -0.82903671264648437, 0.559194147586822509, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+141, 182260, 534, 3606, 3708, 1, 1, 5572.4638671875, -3009.01513671875, 1564.4053955078125, 3.124123096466064453, 0, 0, 0.99996185302734375, 0.008734640665352344, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+142, 182260, 534, 3606, 3708, 1, 1, 5521.40625, -2978.717041015625, 1538.1478271484375, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+143, 182260, 534, 3606, 3708, 1, 1, 5546.2666015625, -2975.103271484375, 1568.905517578125, 2.565631866455078125, 0, 0, 0.958819389343261718, 0.284016460180282592, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+144, 182260, 534, 3606, 3708, 1, 1, 5529.134765625, -3003.891845703125, 1564.8604736328125, 0.855210542678833007, 0, 0, 0.414692878723144531, 0.909961462020874023, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+145, 182260, 534, 3606, 3708, 1, 1, 5544.53369140625, -2993.587646484375, 1589.5816650390625, 5.550147056579589843, 0, 0, -0.358367919921875, 0.933580458164215087, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+146, 182260, 534, 3606, 3708, 1, 1, 5424.296875, -3007.647705078125, 1559.922119140625, 2.426007747650146484, 0, 0, 0.936672210693359375, 0.350207358598709106, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+147, 182260, 534, 3606, 3708, 1, 1, 5415.732421875, -3016.1171875, 1552.0714111328125, 2.129300594329833984, 0, 0, 0.874619483947753906, 0.484810054302215576, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+148, 182260, 534, 3606, 3708, 1, 1, 5341.572265625, -3010.39306640625, 1553.3245849609375, 0.314158439636230468, 0, 0, 0.156434059143066406, 0.987688362598419189, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+149, 182260, 534, 3606, 3708, 1, 1, 5337.37939453125, -2975.14697265625, 1539.11865234375, 3.595378875732421875, 0, 0, -0.97437000274658203, 0.224951311945915222, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+150, 182260, 534, 3606, 3708, 1, 1, 5350.8857421875, -2989.58984375, 1577.73876953125, 3.752462387084960937, 0, 0, -0.95371627807617187, 0.300707906484603881, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject2
(@OGUID+151, 182260, 534, 3606, 3708, 1, 1, 5338.1494140625, -3095.593017578125, 1612.33203125, 5.654868602752685546, 0, 0, -0.30901622772216796, 0.95105677843093872, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+152, 182260, 534, 3606, 3708, 1, 1, 5340.33544921875, -3098.83251953125, 1595.2388916015625, 5.270895957946777343, 0, 0, -0.48480892181396484, 0.87462007999420166, 604800, 255, 1, 53162), -- 182260 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+153, 3960, 534, 3606, 3708, 1, 1, 5164.73583984375, -3035.972900390625, 1570.8802490234375, 2.164205789566040039, 0, 0, 0.882946968078613281, 0.469472706317901611, 604800, 255, 1, 53162), -- 3960 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+154, 185557, 534, 3606, 3708, 1, 1, 5261.6201171875, -3331.56005859375, 1668.699951171875, 3.281238555908203125, 0, 0, -0.99756336212158203, 0.069766148924827575, 604800, 255, 1, 53162), -- 185557 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+155, 185557, 534, 3606, 3708, 1, 1, 5418.22021484375, -3308.360107421875, 1631.800048828125, 2.059488296508789062, 0, 0, 0.857167243957519531, 0.515038192272186279, 604800, 255, 1, 53162), -- 185557 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+156, 177279, 534, 3606, 3708, 1, 1, 5184.26025390625, -3349.457275390625, 1641.0997314453125, 5.31452798843383789, 0, 0, -0.46561431884765625, 0.88498777151107788, 604800, 255, 1, 53162), -- 177279 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+157, 185557, 534, 3606, 3708, 1, 1, 5154.05908203125, -3328.44580078125, 1651.128662109375, 3.769911527633666992, 0, 0, -0.95105648040771484, 0.309017121791839599, 604800, 255, 1, 53162), -- 185557 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+158, 185557, 534, 3606, 3708, 1, 1, 5375.83447265625, -3418.323486328125, 1654.07275390625, 5.323255538940429687, 0, 0, -0.46174812316894531, 0.887011110782623291, 604800, 255, 1, 53162), -- 185557 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+159, 177278, 534, 3606, 3708, 1, 1, 5327.59375, -3469.451416015625, 1569.7166748046875, 4.790929317474365234, 0, 0, -0.67880058288574218, 0.734322667121887207, 604800, 255, 1, 53162), -- 177278 (Area: 3708 - Difficulty: 4) CreateObject1
(@OGUID+160, 185557, 534, 3606, 0, 1, 1, 5178.8642578125, -3516.21533203125, 1613.1845703125, 2.862335443496704101, 0, 0, 0.990267753601074218, 0.139175355434417724, 604800, 255, 1, 53162), -- 185557 (Area: 0 - Difficulty: 4) CreateObject1
(@OGUID+161, 177279, 534, 3606, 3709, 1, 1, 5497.61669921875, -3730.3935546875, 1593.6480712890625, 4.459316730499267578, 0, 0, -0.79068946838378906, 0.612217426300048828, 604800, 255, 1, 53162); -- 177279 (Area: 3709 - Difficulty: 4) CreateObject1

DELETE FROM `waypoint_data` WHERE `id` IN (177721,177722,177723,177724,177725,177726,177727,178521,178522,178523,178524,178525,178526,179481,179482,179483,179061,179062,179063,179064,179065,179066,179071,179072,179073,178527);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- Alliance Base
-- Charge 1:
(177721,1 ,4905.356,-1557.7439,1332.1577,NULL,0,1,0,100,0),
(177721,2 ,4901.935,-1576.6415,1332.7456,NULL,0,1,0,100,0),
(177721,3 ,4898.2646,-1595.9999,1331.3639,NULL,0,1,0,100,0),
(177721,4 ,4898.5874,-1619.1588,1328.4226,NULL,0,1,0,100,0),
(177721,5 ,4905.5566,-1645.4225,1324.7345,NULL,0,1,0,100,0),
(177721,6 ,4911.504,-1659.2622,1322.0311,NULL,0,1,0,100,0),
(177721,7 ,4922.8374,-1675.6334,1325.3477,NULL,0,1,0,100,0),
(177721,8 ,4933.7256,-1687.7668,1331.5618,NULL,0,1,0,100,0),
(177721,9 ,4951.112,-1691.7296,1337.625,NULL,0,1,0,100,0),
(177721,10,4966.0347,-1693.6628,1340.4731,NULL,0,1,0,100,0),
(177721,11,4978.3486,-1707.7675,1339.018,NULL,0,1,0,100,0),
(177721,12,4996.694,-1721.572,1332.9572,NULL,0,1,0,100,0),
(177721,13,5013.205,-1729.1337,1326.7311,NULL,0,1,0,100,0),
(177721,14,5024.1514,-1743.2828,1322.644,NULL,0,1,0,100,0),
-- Charge 2:
(177722,1 ,4912.507,-1554.8761,1330.112,NULL,0,1,0,100,0),
(177722,2 ,4906.32,-1575.0999,1332.1853,NULL,0,1,0,100,0),
(177722,3 ,4903.5605,-1593.3805,1331.5122,NULL,0,1,0,100,0),
(177722,4 ,4902.4185,-1618.6987,1329.2092,NULL,0,1,0,100,0),
(177722,5 ,4909.0903,-1644.3761,1325.9421,NULL,0,1,0,100,0),
(177722,6 ,4927.3647,-1665.5762,1324.3373,NULL,0,1,0,100,0),
(177722,7 ,4935.9062,-1678.7903,1330.0665,NULL,0,1,0,100,0),
(177722,8 ,4944.057,-1689.1742,1335.3041,NULL,0,1,0,100,0),
(177722,9 ,4954.9106,-1690.6743,1338.822,NULL,0,1,0,100,0),
(177722,10,4966.013,-1692.9121,1340.5206,NULL,0,1,0,100,0),
(177722,11,4974.324,-1695.6461,1340.7998,NULL,0,1,0,100,0),
(177722,12,4982.889,-1704.425,1339.9037,NULL,0,1,0,100,0),
(177722,13,4993.569,-1715.8959,1335.0872,NULL,0,1,0,100,0),
(177722,14,5008.3184,-1728.438,1328.1224,NULL,0,1,0,100,0),
(177722,15,5024.3223,-1743.6403,1322.6418,NULL,0,1,0,100,0),
-- Charge 3:
(177723,1 ,4895.4277,-1590.8092,1332.0581,NULL,0,1,0,100,0),
(177723,2 ,4896.3594,-1608.7734,1330.3589,NULL,0,1,0,100,0),
(177723,3 ,4896.902,-1626.4156,1325.7756,NULL,0,1,0,100,0),
(177723,4 ,4898.7827,-1643.9562,1322.4677,NULL,0,1,0,100,0),
(177723,5 ,4905.4478,-1667.2998,1320.8079,NULL,0,1,0,100,0),
(177723,6 ,4917.0723,-1678.6937,1324.125,NULL,0,1,0,100,0),
(177723,7 ,4930.0024,-1688.5887,1330.6844,NULL,0,1,0,100,0),
(177723,8 ,4946.3384,-1695.8247,1337.4321,NULL,0,1,0,100,0),
(177723,9 ,4963.5435,-1698.3932,1340.348,NULL,0,1,0,100,0),
(177723,10,4975.788,-1711.2136,1339.3091,NULL,0,1,0,100,0),
(177723,11,4985.0093,-1720.7201,1336.5997,NULL,0,1,0,100,0),
(177723,12,5007.493,-1740.4618,1326.7266,NULL,0,1,0,100,0),
(177723,13,5016.9443,-1749.0211,1322.3903,NULL,0,1,0,100,0),
-- Patrol 1:
(177724,1 ,5036.9863,-1763.0171,1324.196,NULL,0,0,0,100,0),
(177724,2 ,5051.2954,-1777.903,1322.4426,NULL,0,0,0,100,0),
(177724,3 ,5067.457,-1793.0005,1321.1865,NULL,0,0,0,100,0),
(177724,4 ,5082.547,-1813.8169,1325.229,NULL,0,0,0,100,0),
(177724,5 ,5098.916,-1827.3698,1328.5408,NULL,0,0,0,100,0),
(177724,6 ,5091.4033,-1844.0017,1328.865,NULL,0,0,0,100,0),
(177724,7 ,5077.985,-1855.918,1330.4878,NULL,0,0,0,100,0),
(177724,8 ,5066.3843,-1864.4537,1330.9604,NULL,0,0,0,100,0),
(177724,9 ,5058.0044,-1871.4723,1330.9235,NULL,0,0,0,100,0),
(177724,10,5045.224,-1881.6198,1331.2219,NULL,0,0,0,100,0),
(177724,11,5032.2256,-1890.5438,1328.8651,NULL,0,0,0,100,0),
(177724,12,5000.72,-1892.6333,1325.5928,NULL,0,0,0,100,0),
(177724,13,4986.086,-1888.0851,1322.851,NULL,0,0,0,100,0),
(177724,14,4969.1865,-1880.2368,1320.9674,NULL,0,0,0,100,0),
(177724,15,4984.005,-1855.8842,1320.4905,NULL,0,0,0,100,0),
(177724,16,4997.5825,-1851.2489,1321.2733,NULL,0,0,0,100,0),
(177724,17,5010.9634,-1830.5931,1321.7004,NULL,0,0,0,100,0),
(177724,18,5028.895,-1833.8156,1322.4952,NULL,0,0,0,100,0),
(177724,19,5024.8853,-1812.1683,1321.7678,NULL,0,0,0,100,0),
(177724,20,5032.1426,-1797.3307,1321.6145,NULL,0,0,0,100,0),
(177724,21,5030.104,-1778.1888,1321.8259,NULL,0,0,0,100,0),
(177724,22,5017.017,-1763.2999,1322.1216,NULL,0,0,0,100,0),
(177724,23,5018.9844,-1754.1285,1322.2491,NULL,0,0,0,100,0),
(177724,24,5024.4463,-1745.1969,1322.6123,NULL,0,0,0,100,0),
(177724,25,5036.9863,-1763.0171,1324.196,NULL,0,0,0,100,0),
-- Patrol 2:
(177725,1 ,5040.8823,-1739.3463,1321.0178,NULL,0,0,0,100,0),
(177725,2 ,5049.84,-1727.2213,1320.6362,NULL,0,0,0,100,0),
(177725,3 ,5065.362,-1729.1849,1325.4052,NULL,0,0,0,100,0),
(177725,4 ,5073.5938,-1733.7819,1327.9532,NULL,0,0,0,100,0),
(177725,5 ,5073.69,-1748.98,1328.4124,NULL,0,0,0,100,0),
(177725,6 ,5081.6455,-1757.6251,1327.6125,NULL,0,0,0,100,0),
(177725,7 ,5090.2153,-1746.2799,1329.4159,NULL,0,0,0,100,0),
(177725,8 ,5098.849,-1743.6261,1329.9194,NULL,0,0,0,100,0),
(177725,9 ,5110.326,-1744.3123,1331.8342,NULL,0,0,0,100,0),
(177725,10,5126.926,-1751.5873,1335.071,NULL,0,0,0,100,0),
(177725,11,5140.555,-1751.1836,1334.7582,NULL,0,0,0,100,0),
(177725,12,5148.2764,-1771.5848,1336.1473,NULL,0,0,0,100,0),
(177725,13,5168.8477,-1770.1842,1338.1666,NULL,0,0,0,100,0),
(177725,14,5184.3774,-1762.5963,1340.6674,NULL,0,0,0,100,0),
(177725,15,5183.5244,-1783.2174,1340.389,NULL,0,0,0,100,0),
(177725,16,5170.168,-1792.5239,1338.1348,NULL,0,0,0,100,0),
(177725,17,5160.3525,-1806.5145,1338.7048,NULL,0,0,0,100,0),
(177725,18,5147.3994,-1815.1638,1338.2115,NULL,0,0,0,100,0),
(177725,19,5135.8887,-1819.9883,1337.875,NULL,0,0,0,100,0),
(177725,20,5116.687,-1830.0474,1333.5437,NULL,0,0,0,100,0),
(177725,21,5105.4844,-1834.3359,1331.4532,NULL,0,0,0,100,0),
(177725,22,5090.777,-1835.07,1327.5358,NULL,0,0,0,100,0),
(177725,23,5087.5376,-1816.1041,1324.8286,NULL,0,0,0,100,0),
(177725,24,5064.8945,-1794.3627,1321.3605,NULL,0,0,0,100,0),
(177725,25,5051.826,-1782.5173,1322.4979,NULL,0,0,0,100,0),
(177725,26,5042.6665,-1775.2366,1323.1747,NULL,0,0,0,100,0),
(177725,27,5033.6685,-1768.1617,1323.9828,NULL,0,0,0,100,0),
(177725,28,5024.7646,-1756.1022,1322.9534,NULL,0,0,0,100,0),
(177725,29,5024.916,-1745.7236,1322.6158,NULL,0,0,0,100,0),
(177725,30,5040.8823,-1739.3463,1321.0178,NULL,0,0,0,100,0),
-- Patrol 3:
(177726,1 ,5040.8823,-1739.3463,1321.0178,NULL,0,0,0,100,0),
(177726,2 ,5049.84,-1727.2213,1320.6362,NULL,0,0,0,100,0),
(177726,3 ,5065.362,-1729.1849,1325.4052,NULL,0,0,0,100,0),
(177726,4 ,5073.5938,-1733.7819,1327.9532,NULL,0,0,0,100,0),
(177726,5 ,5073.69,-1748.98,1328.4124,NULL,0,0,0,100,0),
(177726,6 ,5081.6455,-1757.6251,1327.6125,NULL,0,0,0,100,0),
(177726,7 ,5090.2153,-1746.2799,1329.4159,NULL,0,0,0,100,0),
(177726,8 ,5098.849,-1743.6261,1329.9194,NULL,0,0,0,100,0),
(177726,9 ,5110.326,-1744.3123,1331.8342,NULL,0,0,0,100,0),
(177726,10,5126.926,-1751.5873,1335.071,NULL,0,0,0,100,0),
(177726,11,5140.555,-1751.1836,1334.7582,NULL,0,0,0,100,0),
(177726,12,5148.2764,-1771.5848,1336.1473,NULL,0,0,0,100,0),
(177726,13,5168.8477,-1770.1842,1338.1666,NULL,0,0,0,100,0),
(177726,14,5184.3774,-1762.5963,1340.6674,NULL,0,0,0,100,0),
(177726,15,5183.5244,-1783.2174,1340.389,NULL,0,0,0,100,0),
(177726,16,5170.168,-1792.5239,1338.1348,NULL,0,0,0,100,0),
(177726,17,5160.3525,-1806.5145,1338.7048,NULL,0,0,0,100,0),
(177726,18,5147.3994,-1815.1638,1338.2115,NULL,0,0,0,100,0),
(177726,19,5135.8887,-1819.9883,1337.875,NULL,0,0,0,100,0),
(177726,20,5116.687,-1830.0474,1333.5437,NULL,0,0,0,100,0),
(177726,21,5105.4844,-1834.3359,1331.4532,NULL,0,0,0,100,0),
(177726,22,5090.777,-1835.07,1327.5358,NULL,0,0,0,100,0),
(177726,23,5087.5376,-1816.1041,1324.8286,NULL,0,0,0,100,0),
(177726,24,5064.8945,-1794.3627,1321.3605,NULL,0,0,0,100,0),
(177726,25,5051.826,-1782.5173,1322.4979,NULL,0,0,0,100,0),
(177726,26,5042.6665,-1775.2366,1323.1747,NULL,0,0,0,100,0),
(177726,27,5033.6685,-1768.1617,1323.9828,NULL,0,0,0,100,0),
(177726,28,5024.7646,-1756.1022,1322.9534,NULL,0,0,0,100,0),
(177726,29,5024.916,-1745.7236,1322.6158,NULL,0,0,0,100,0),
(177726,30,5040.8823,-1739.3463,1321.0178,NULL,0,0,0,100,0),
-- Jaina Proudmoore
(177727,1,5056.2324,-1791.0172,1321.4271,NULL,0,0,0,100,0),
(177727,2,5046.4404,-1787.5228,1321.5262,NULL,0,0,0,100,0),
(177727,3,5034.4487,-1783.316,1321.7091,NULL,0,0,0,100,0),
(177727,4,5034.4487,-1783.316,1321.7091,2.804605484008789062,0,0,0,100,0),
-- Horde Base
-- Charge 1:
(178521,1,5515.898,-2439.3828,1466.8087,NULL,0,1,0,100,0),
(178521,2,5520.83,-2448.0742,1467.7144,NULL,0,1,0,100,0),
(178521,3,5529.913,-2455.678,1468.8508,NULL,0,1,0,100,0),
(178521,4,5539.6553,-2462.6702,1470.1555,NULL,0,1,0,100,0),
(178521,5,5544.354,-2475.4788,1471.8378,NULL,0,1,0,100,0),
(178521,6,5547.019,-2490.7827,1473.488,NULL,0,1,0,100,0),
(178521,7,5553.027,-2506.7349,1475.2065,NULL,0,1,0,100,0),
(178521,8,5555.9307,-2520.341,1476.6785,NULL,0,1,0,100,0),
(178521,9,5552.3213,-2531.7793,1477.6876,NULL,0,1,0,100,0),
(178521,10,5550.154,-2547.3293,1478.4451,NULL,0,1,0,100,0),
(178521,11,5547.8896,-2572.1597,1479.0669,NULL,0,1,0,100,0),
(178521,12,5545.49,-2599.0547,1480.0295,NULL,0,1,0,100,0),
(178521,13,5544.612,-2614.3767,1480.5232,NULL,0,1,0,100,0),
(178521,14,5539.0337,-2632.818,1480.8608,NULL,0,1,0,100,0),
-- Charge 2:
(178522,1,5527.5967,-2409.1858,1468.7676,NULL,0,1,0,100,0),
(178522,2,5535.3145,-2422.0715,1470.3575,NULL,0,1,0,100,0),
(178522,3,5545.852,-2452.0334,1471.0311,NULL,0,1,0,100,0),
(178522,4,5555.303,-2483.8545,1474.3467,NULL,0,1,0,100,0),
(178522,5,5560.874,-2498.6453,1476.1173,NULL,0,1,0,100,0),
(178522,6,5564.8145,-2513.1172,1477.7604,NULL,0,1,0,100,0),
(178522,7,5562.932,-2539.0774,1480.762,NULL,0,1,0,100,0),
(178522,8,5560.0225,-2558.4626,1480.3805,NULL,0,1,0,100,0),
(178522,9,5557.0625,-2579.365,1481.1226,NULL,0,1,0,100,0),
(178522,10,5554.618,-2610.5325,1482.8214,NULL,0,1,0,100,0),
(178522,11,5548.197,-2632.0112,1482.8678,NULL,0,1,0,100,0),
-- Charge 3:
(178523,1,5508.9287,-2425.5154,1465.0233,NULL,0,1,0,100,0),
(178523,2,5515.898,-2439.3828,1466.8087,NULL,0,1,0,100,0),
(178523,3,5520.83,-2448.0742,1467.7144,NULL,0,1,0,100,0),
(178523,4,5529.913,-2455.678,1468.8508,NULL,0,1,0,100,0),
(178523,5,5539.6553,-2462.6702,1470.1555,NULL,0,1,0,100,0),
(178523,6,5544.354,-2475.4788,1471.8378,NULL,0,1,0,100,0),
(178523,7,5547.019,-2490.7827,1473.488,NULL,0,1,0,100,0),
(178523,8,5553.027,-2506.7349,1475.2065,NULL,0,1,0,100,0),
(178523,9,5555.9307,-2520.341,1476.6785,NULL,0,1,0,100,0),
(178523,10,5552.3213,-2531.7793,1477.6876,NULL,0,1,0,100,0),
(178523,11,5550.154,-2547.3293,1478.4451,NULL,0,1,0,100,0),
(178523,12,5547.8896,-2572.1597,1479.0669,NULL,0,1,0,100,0),
(178523,13,5545.49,-2599.0547,1480.0295,NULL,0,1,0,100,0),
(178523,14,5544.612,-2614.3767,1480.5232,NULL,0,1,0,100,0),
(178523,15,5539.0337,-2632.818,1480.8608,NULL,0,1,0,100,0),
-- Patrol 1:
(178524,1 ,5568.778,-2645.6055,1486.9862,NULL,0,0,0,100,0),
(178524,2 ,5584.9697,-2660.7166,1488.8943,NULL,0,0,0,100,0),
(178524,3 ,5589.07,-2675.5715,1488.4685,NULL,0,0,0,100,0),
(178524,4 ,5586.555,-2700.6943,1491.797,NULL,0,0,0,100,0),
(178524,5 ,5585.324,-2715.9377,1492.3906,NULL,0,0,0,100,0),
(178524,6 ,5583.584,-2737.8516,1492.2336,NULL,0,0,0,100,0),
(178524,7 ,5578.492,-2756.6133,1494.9377,NULL,0,0,0,100,0),
(178524,8 ,5551.664,-2765.3132,1495.0864,NULL,0,0,0,100,0),
(178524,9 ,5538.9116,-2778.416,1495.5771,NULL,0,0,0,100,0),
(178524,10,5520.1265,-2790.365,1497.8389,NULL,0,0,0,100,0),
(178524,11,5509.284,-2798.237,1499.7949,NULL,0,0,0,100,0),
(178524,12,5496.225,-2817.7764,1501.4862,NULL,0,0,0,100,0),
(178524,13,5497.596,-2828.4814,1502.4352,NULL,0,0,0,100,0),
(178524,14,5501.622,-2845.3489,1506.0148,NULL,0,0,0,100,0),
(178524,15,5510.1943,-2853.306,1506.7236,NULL,0,0,0,100,0),
(178524,16,5522.693,-2856.1985,1506.4766,NULL,0,0,0,100,0),
(178524,17,5540.6934,-2855.918,1506.6383,NULL,0,0,0,100,0),
(178524,18,5555.453,-2855.1829,1507.7351,NULL,0,0,0,100,0),
(178524,19,5578.8203,-2853.4954,1508.4988,NULL,0,0,0,100,0),
(178524,20,5600.924,-2865.9172,1510.0449,NULL,0,0,0,100,0),
(178524,21,5611.5435,-2858.2832,1510.0449,NULL,0,0,0,100,0),
(178524,22,5609.9824,-2846.4702,1508.4711,NULL,0,0,0,100,0),
(178524,23,5604.1978,-2835.6584,1506.0844,NULL,0,0,0,100,0),
(178524,24,5604.235,-2820.8938,1502.7279,NULL,0,0,0,100,0),
(178524,25,5599.551,-2804.6838,1499.9973,NULL,0,0,0,100,0),
(178524,26,5588.5654,-2793.886,1497.8118,NULL,0,0,0,100,0),
(178524,27,5576.909,-2792.0662,1496.1624,NULL,0,0,0,100,0),
(178524,28,5564.8228,-2788.3489,1495.9127,NULL,0,0,0,100,0),
(178524,29,5553.541,-2782.4219,1496.4569,NULL,0,0,0,100,0),
(178524,30,5543.0117,-2773.559,1495.3135,NULL,0,0,0,100,0),
(178524,31,5533.3296,-2765.0774,1492.9589,NULL,0,0,0,100,0),
(178524,32,5527.204,-2757.838,1490.349,NULL,0,0,0,100,0),
(178524,33,5519.7197,-2749.5457,1487.0782,NULL,0,0,0,100,0),
(178524,34,5515.1313,-2742.8567,1485.7285,NULL,0,0,0,100,0),
(178524,35,5515.746,-2729.4307,1484.2761,NULL,0,0,0,100,0),
(178524,36,5519.233,-2696.7622,1480.7529,NULL,0,0,0,100,0),
(178524,37,5524.063,-2662.2192,1479.2719,NULL,0,0,0,100,0),
(178524,38,5529.2163,-2648.1167,1480.1172,NULL,0,0,0,100,0),
(178524,39,5536.944,-2639.985,1480.5801,NULL,0,0,0,100,0),
(178524,40,5546.701,-2637.048,1482.9175,NULL,0,0,0,100,0),
(178524,41,5568.778,-2645.6055,1486.9862,NULL,0,0,0,100,0),
-- Patrol 2:
(178525,1 ,5568.778,-2645.6055,1486.9862,NULL,0,0,0,100,0),
(178525,2 ,5584.9697,-2660.7166,1488.8943,NULL,0,0,0,100,0),
(178525,3 ,5589.07,-2675.5715,1488.4685,NULL,0,0,0,100,0),
(178525,4 ,5586.555,-2700.6943,1491.797,NULL,0,0,0,100,0),
(178525,5 ,5585.324,-2715.9377,1492.3906,NULL,0,0,0,100,0),
(178525,6 ,5583.584,-2737.8516,1492.2336,NULL,0,0,0,100,0),
(178525,7 ,5578.492,-2756.6133,1494.9377,NULL,0,0,0,100,0),
(178525,8 ,5551.664,-2765.3132,1495.0864,NULL,0,0,0,100,0),
(178525,9 ,5538.9116,-2778.416,1495.5771,NULL,0,0,0,100,0),
(178525,10,5520.1265,-2790.365,1497.8389,NULL,0,0,0,100,0),
(178525,11,5509.284,-2798.237,1499.7949,NULL,0,0,0,100,0),
(178525,12,5499.019,-2807.908,1499.7987,NULL,0,0,0,100,0),
(178525,13,5496.225,-2817.7764,1501.4862,NULL,0,0,0,100,0),
(178525,14,5497.596,-2828.4814,1502.4352,NULL,0,0,0,100,0),
(178525,15,5501.622,-2845.3489,1506.0148,NULL,0,0,0,100,0),
(178525,16,5510.1943,-2853.306,1506.7236,NULL,0,0,0,100,0),
(178525,17,5522.693,-2856.1985,1506.4766,NULL,0,0,0,100,0),
(178525,18,5540.6934,-2855.918,1506.6383,NULL,0,0,0,100,0),
(178525,19,5555.453,-2855.1829,1507.7351,NULL,0,0,0,100,0),
(178525,20,5578.8203,-2853.4954,1508.4988,NULL,0,0,0,100,0),
(178525,21,5600.924,-2865.9172,1510.0449,NULL,0,0,0,100,0),
(178525,22,5611.5435,-2858.2832,1510.0449,NULL,0,0,0,100,0),
(178525,23,5609.9824,-2846.4702,1508.4711,NULL,0,0,0,100,0),
(178525,24,5604.1978,-2835.6584,1506.0844,NULL,0,0,0,100,0),
(178525,25,5604.235,-2820.8938,1502.7279,NULL,0,0,0,100,0),
(178525,26,5599.551,-2804.6838,1499.9973,NULL,0,0,0,100,0),
(178525,27,5588.5654,-2793.886,1497.8118,NULL,0,0,0,100,0),
(178525,28,5576.909,-2792.0662,1496.1624,NULL,0,0,0,100,0),
(178525,29,5564.8228,-2788.3489,1495.9127,NULL,0,0,0,100,0),
(178525,30,5553.541,-2782.4219,1496.4569,NULL,0,0,0,100,0),
(178525,31,5543.0117,-2773.559,1495.3135,NULL,0,0,0,100,0),
(178525,32,5533.3296,-2765.0774,1492.9589,NULL,0,0,0,100,0),
(178525,33,5519.7197,-2749.5457,1487.0782,NULL,0,0,0,100,0),
(178525,34,5515.1313,-2742.8567,1485.7285,NULL,0,0,0,100,0),
(178525,35,5515.746,-2729.4307,1484.2761,NULL,0,0,0,100,0),
(178525,36,5519.233,-2696.7622,1480.7529,NULL,0,0,0,100,0),
(178525,37,5524.063,-2662.2192,1479.2719,NULL,0,0,0,100,0),
(178525,38,5529.2163,-2648.1167,1480.1172,NULL,0,0,0,100,0),
(178525,39,5536.944,-2639.985,1480.5801,NULL,0,0,0,100,0),
(178525,40,5546.701,-2637.048,1482.9175,NULL,0,0,0,100,0),
(178525,41,5557.5415,-2636.9978,1485.0974,NULL,0,0,0,100,0),
(178525,42,5568.778,-2645.6055,1486.9862,NULL,0,0,0,100,0),
-- Patrol 3:
(178526,1,5527.2466,-2652.405,1479.9614,NULL,0,0,0,100,0),
(178526,2,5524.6973,-2662.2053,1479.2505,NULL,0,0,0,100,0),
(178526,3,5525.4443,-2676.5356,1478.5315,NULL,0,0,0,100,0),
(178526,4,5532.674,-2701.005,1478.9833,NULL,0,0,0,100,0),
(178526,5,5533.311,-2714.4526,1480.9232,NULL,0,0,0,100,0),
(178526,6,5523.3853,-2735.5725,1484.2266,NULL,0,0,0,100,0),
(178526,7,5506.166,-2749.2395,1486.8292,NULL,0,0,0,100,0),
(178526,8,5482.4634,-2761.2205,1489.4114,NULL,0,0,0,100,0),
(178526,9,5460.8804,-2772.1824,1493.2781,NULL,0,0,0,100,0),
(178526,10,5438.692,-2789.125,1497.3811,NULL,0,0,0,100,0),
(178526,11,5421.501,-2812.5176,1503.2144,NULL,0,0,0,100,0),
(178526,12,5414.5376,-2826.3247,1506.4531,NULL,0,0,0,100,0),
(178526,13,5413.6997,-2838.2449,1509.0342,NULL,0,0,0,100,0),
(178526,14,5416.8,-2863.0488,1514.5923,NULL,0,0,0,100,0),
(178526,15,5418.9614,-2884.162,1519.9419,NULL,0,0,0,100,0),
(178526,16,5415.55,-2899.0007,1523.2181,NULL,0,0,0,100,0),
(178526,17,5407.479,-2916.3518,1526.3264,NULL,0,0,0,100,0),
(178526,18,5396.5786,-2923.0688,1528.0256,NULL,0,0,0,100,0),
(178526,19,5381.2188,-2930.678,1529.043,NULL,0,0,0,100,0),
(178526,20,5365.907,-2936.9365,1530.6816,NULL,0,0,0,100,0),
(178526,21,5329.409,-2954.647,1534.9066,NULL,0,0,0,100,0),
(178526,22,5286.5693,-2974.859,1540.2617,NULL,0,0,0,100,0),
(178526,23,5272.2627,-2986.726,1544.0474,NULL,0,0,0,100,0),
(178526,24,5261.2944,-3006.1926,1549.0981,NULL,0,0,0,100,0),
(178526,25,5254.3,-3035.2554,1555.6816,NULL,0,0,0,100,0),
(178526,26,5252.576,-3071.5354,1562.3926,NULL,0,0,0,100,0),
(178526,27,5256.0547,-3097.2812,1569.3075,NULL,0,0,0,100,0),
(178526,28,5270.7017,-3127.9146,1577.349,NULL,0,0,0,100,0),
(178526,29,5285.6714,-3134.7817,1581.3932,NULL,0,0,0,100,0),
(178526,30,5307.5996,-3133.8494,1587.1412,NULL,0,0,0,100,0),
(178526,31,5324.1426,-3127.4465,1586.9525,NULL,0,0,0,100,0),
(178526,32,5347.4434,-3135.7256,1586.0203,NULL,0,0,0,100,0),
(178526,33,5361.625,-3145.2058,1585.8694,NULL,0,0,0,100,0),
(178526,34,5374.8394,-3155.3123,1585.5886,NULL,0,0,0,100,0),
(178526,35,5361.625,-3145.2058,1585.8694,NULL,0,0,0,100,0),
(178526,36,5347.4434,-3135.7256,1586.0203,NULL,0,0,0,100,0),
(178526,37,5324.1426,-3127.4465,1586.9525,NULL,0,0,0,100,0),
(178526,38,5307.5996,-3133.8494,1587.1412,NULL,0,0,0,100,0),
(178526,39,5285.6714,-3134.7817,1581.3932,NULL,0,0,0,100,0),
(178526,40,5270.7017,-3127.9146,1577.349,NULL,0,0,0,100,0),
(178526,41,5256.0596,-3097.3687,1569.3184,NULL,0,0,0,100,0),
(178526,42,5252.581,-3071.623,1562.3523,NULL,0,0,0,100,0),
(178526,43,5254.3,-3035.2554,1555.6816,NULL,0,0,0,100,0),
(178526,44,5261.2944,-3006.1926,1549.0981,NULL,0,0,0,100,0),
(178526,45,5272.2627,-2986.726,1544.0474,NULL,0,0,0,100,0),
(178526,46,5286.5693,-2974.859,1540.2617,NULL,0,0,0,100,0),
(178526,47,5329.409,-2954.647,1534.9066,NULL,0,0,0,100,0),
(178526,48,5365.907,-2936.9365,1530.6816,NULL,0,0,0,100,0),
(178526,49,5381.2188,-2930.678,1529.043,NULL,0,0,0,100,0),
(178526,50,5396.459,-2923.1406,1528.0612,NULL,0,0,0,100,0),
(178526,51,5407.479,-2916.3518,1526.3264,NULL,0,0,0,100,0),
(178526,52,5415.55,-2899.0007,1523.2181,NULL,0,0,0,100,0),
(178526,53,5418.9614,-2884.162,1519.9419,NULL,0,0,0,100,0),
(178526,54,5416.7974,-2863.0688,1514.5718,NULL,0,0,0,100,0),
(178526,55,5413.6963,-2838.2637,1508.9664,NULL,0,0,0,100,0),
(178526,56,5414.5376,-2826.3247,1506.4531,NULL,0,0,0,100,0),
(178526,57,5421.494,-2812.5195,1503.071,NULL,0,0,0,100,0),
(178526,58,5438.692,-2789.125,1497.3811,NULL,0,0,0,100,0),
(178526,59,5460.8804,-2772.1824,1493.2781,NULL,0,0,0,100,0),
(178526,60,5482.4634,-2761.2205,1489.4114,NULL,0,0,0,100,0),
(178526,61,5506.166,-2749.2395,1486.8292,NULL,0,0,0,100,0),
(178526,62,5523.3853,-2735.5725,1484.2266,NULL,0,0,0,100,0),
(178526,63,5533.311,-2714.4526,1480.9232,NULL,0,0,0,100,0),
(178526,64,5532.674,-2701.005,1478.9833,NULL,0,0,0,100,0),
(178526,65,5525.4443,-2676.5356,1478.5315,NULL,0,0,0,100,0),
(178526,66,5524.6973,-2662.2053,1479.2505,NULL,0,0,0,100,0),
(178526,67,5527.2466,-2652.405,1479.9614,NULL,0,0,0,100,0),
(178526,68,5531.0767,-2645.1294,1480.3168,NULL,0,0,0,100,0),
(178526,69,5527.2466,-2652.405,1479.9614,NULL,0,0,0,100,0),
-- Gargoyles
-- Troll Camp
(179061,1 ,5789.4087,-2929.6438,1667.9263,NULL,0,2,0,100,0),
(179061,2 ,5776.0884,-2958.0073,1667.9263,NULL,0,2,0,100,0),
(179061,3 ,5741.612,-2957.775,1664.3147,NULL,0,2,0,100,0),
(179061,4 ,5709.1914,-2923.986,1659.8978,NULL,0,2,0,100,0),
(179061,5 ,5685.663,-2892.7595,1645.5927,NULL,0,2,0,100,0),
(179061,6 ,5667.6,-2851.5613,1640.0095,NULL,0,2,0,100,0),
(179061,7 ,5664.902,-2871.7073,1622.7042,NULL,0,2,0,100,0),
(179061,8 ,5655.4087,-2913.4033,1622.7042,NULL,0,2,0,100,0),
(179061,9 ,5636.6206,-2932.306,1616.0096,NULL,0,2,0,100,0),
(179061,10,5626.667,-2903.931,1602.6484,NULL,0,2,0,100,0),
(179061,11,5648.7744,-2867.5205,1581.5931,NULL,0,2,0,100,0),
(179061,12,5607.216,-2842.9224,1568.0095,NULL,0,2,0,100,0),
(179061,13,5616.811,-2800.8193,1526.867,NULL,0,2,0,100,0),
(179061,14,5615.486,-2810.1624,1521.6168,NULL,0,2,0,100,0),
(179061,15,5576.133,-2835.8586,1521.6168,NULL,0,2,0,100,0),
(179061,16,5581.821,-2853.3103,1515.8383,NULL,0,2,0,100,0),

(179062,1 ,5761.9434,-2873.9258,1644.555,NULL,0,2,0,100,0),
(179062,2 ,5722.308,-2843.4822,1644.555,NULL,0,2,0,100,0),
(179062,3 ,5698.5537,-2878.909,1640.1102,NULL,0,2,0,100,0),
(179062,4 ,5677.0444,-2896.2961,1614.8881,NULL,0,2,0,100,0),
(179062,5 ,5667.3145,-2878.6118,1599.0267,NULL,0,2,0,100,0),
(179062,6 ,5648.7646,-2834.6846,1586.4705,NULL,0,2,0,100,0),
(179062,7 ,5626.645,-2820.9053,1576.6653,NULL,0,2,0,100,0),
(179062,8 ,5570.3306,-2878.28,1531.1624,NULL,0,2,0,100,0),
(179062,9 ,5573.5786,-2843.5947,1531.1624,NULL,0,2,0,100,0),
(179062,10,5593.0723,-2820.8176,1522.1067,NULL,0,2,0,100,0),
(179062,11,5612.739,-2818.3838,1508.9122,NULL,0,2,0,100,0),

(179063,1 ,5761.905,-2817.4917,1623.4761,NULL,0,2,0,100,0),
(179063,2 ,5722.007,-2799.2385,1623.4762,NULL,0,2,0,100,0),
(179063,3 ,5690.47,-2801.3638,1623.4762,NULL,0,2,0,100,0),
(179063,4 ,5685.317,-2826.5938,1611.9487,NULL,0,2,0,100,0),
(179063,5 ,5671.659,-2870.058,1595.3376,NULL,0,2,0,100,0),
(179063,6 ,5644.558,-2902.4185,1588.5878,NULL,0,2,0,100,0),
(179063,7 ,5604.918,-2919.8547,1580.282,NULL,0,2,0,100,0),
(179063,8 ,5576.506,-2892.3958,1569.8376,NULL,0,2,0,100,0),
(179063,9 ,5579.018,-2822.3298,1540.3124,NULL,0,2,0,100,0),
(179063,10,5594.3306,-2840.3704,1521.7571,NULL,0,2,0,100,0),
(179063,11,5602.2344,-2858.0547,1515.1736,NULL,0,2,0,100,0),
-- Fortress
(179064,1 ,5464.7837,-2556.5557,1579.4302,NULL,0,2,0,100,0),
(179064,2 ,5473.281,-2590.3606,1579.4302,NULL,0,2,0,100,0),
(179064,3 ,5452.608,-2605.0217,1571.291,NULL,0,2,0,100,0),
(179064,4 ,5419.826,-2619.2913,1548.0132,NULL,0,2,0,100,0),
(179064,5 ,5447.678,-2658.0947,1543.1797,NULL,0,2,0,100,0),
(179064,6 ,5530.9634,-2638.3645,1504.498,NULL,0,2,0,100,0),
(179064,7 ,5548.758,-2669.7214,1504.498,NULL,0,2,0,100,0),
(179064,8 ,5573.7695,-2685.0193,1501.2485,NULL,0,2,0,100,0),
(179064,9 ,5561.074,-2700.5112,1496.8594,NULL,0,2,0,100,0),
(179064,10,5541.3833,-2700.1003,1487.6637,NULL,0,2,0,100,0),
(179064,11,5522.594,-2696.1624,1486.1919,NULL,0,2,0,100,0),

(179065,1 ,5484.6777,-2545.9453,1564.7673,NULL,0,2,0,100,0),
(179065,2 ,5501.7715,-2559.405,1561.1006,NULL,0,2,0,100,0),
(179065,3 ,5503.5063,-2579.7126,1554.5449,NULL,0,2,0,100,0),
(179065,4 ,5502.717,-2607.364,1541.2114,NULL,0,2,0,100,0),
(179065,5 ,5501.8696,-2624.7192,1533.2388,NULL,0,2,0,100,0),
(179065,6 ,5498.2217,-2643.048,1506.3585,NULL,0,2,0,100,0),
(179065,7 ,5498.6045,-2649.001,1501.8579,NULL,0,2,0,100,0),
(179065,8 ,5503.9775,-2662.72,1495.4412,NULL,0,2,0,100,0),
(179065,9 ,5507.269,-2668.4236,1493.3021,NULL,0,2,0,100,0),
(179065,10,5512.2837,-2675.3215,1487.191,NULL,0,2,0,100,0),

(179066,1,5442.2817,-2569.3784,1595.6707,NULL,0,2,0,100,0),
(179066,2,5457.5273,-2598.679,1595.6707,NULL,0,2,0,100,0),
(179066,3,5484.3843,-2601.2266,1578.9481,NULL,0,2,0,100,0),
(179066,4,5487.3296,-2622.1963,1559.6428,NULL,0,2,0,100,0),
(179066,5,5487.329,-2644.8928,1555.1423,NULL,0,2,0,100,0),
(179066,6,5466.6343,-2663.3906,1503.2643,NULL,0,2,0,100,0),
(179066,7,5485.3164,-2684.8352,1497.6252,NULL,0,2,0,100,0),
(179066,8,5486.4707,-2691.6943,1493.264,NULL,0,2,0,100,0),
(179066,9,5476.5684,-2708.7092,1494.3473,NULL,0,2,0,100,0),
-- Frost Wyrm
-- Troll Camp
(179071,1,5730.1025,-2705.8052,1642.4415,NULL,0,2,0,100,0),
(179071,2,5696.63,-2721.4583,1613.6079,NULL,0,2,0,100,0),
(179071,3,5658.11,-2720.3833,1581.1346,NULL,0,2,0,100,0),
(179071,4,5585.4644,-2721.9814,1521.0239,NULL,0,2,0,100,0),
(179071,5,5553.9863,-2745.591,1516.0532,NULL,0,2,0,100,0),
(179071,6,5531.0425,-2766.5369,1514.9421,NULL,0,2,0,100,0),
(179071,7,5495.4756,-2790.478,1518.5535,NULL,0,2,0,100,0),
-- Fortress
(179072,1,5452.1763,-2562.7847,1586.864,NULL,0,2,0,100,0),
(179072,2,5464.0854,-2603.0518,1577.1414,NULL,0,2,0,100,0),
(179072,3,5466.6055,-2624.5786,1546.669,NULL,0,2,0,100,0),
(179072,4,5476.5225,-2651.3633,1527.4747,NULL,0,2,0,100,0),
(179072,5,5488.03,-2706.1182,1505.735,NULL,0,2,0,100,0),
(179072,6,5489.804,-2724.4993,1505.735,NULL,0,2,0,100,0),
(179072,7,5496.988,-2735.5552,1505.735,NULL,0,2,0,100,0),
-- Fortress Patrol
(179073,1,5526.811,-2776.2566,1520.1216,NULL,0,2,0,100,0),
(179073,2,5496.6333,-2758.9856,1515.2327,NULL,0,2,0,100,0),
(179073,3,5490.1846,-2745.432,1514.6771,NULL,0,2,0,100,0),
(179073,4,5480.4917,-2700.8108,1508.454,NULL,0,2,0,100,0),
(179073,5,5496.185,-2679.2996,1498.5836,NULL,0,2,0,100,0),
(179073,6,5510.9883,-2680.2778,1498.5836,NULL,0,2,0,100,0),
(179073,7,5530.7856,-2696.4175,1507,NULL,0,2,0,100,0),
(179073,8,5541.916,-2738.5515,1507.5006,NULL,0,2,0,100,0),
(179073,9,5523.5923,-2768.9214,1510.3065,NULL,0,2,0,100,0),
-- Night Elf Base
-- Charge 1:
(179481,1,5387.522,-3330.545,1639.99,NULL,0,1,0,100,0),
(179481,2,5397.058,-3346.455,1649.818,NULL,0,1,0,100,0),
(179481,3,5402.736,-3365.092,1656.344,NULL,0,1,0,100,0),
(179481,4,5397.563,-3378.536,1655.863,NULL,0,1,0,100,0),
(179481,5,5387.921,-3391.964,1655.882,NULL,0,1,0,100,0),
(179481,6,5375.036,-3399.461,1656.059,NULL,0,1,0,100,0),
(179481,7,5353.401,-3400.13,1655.62,NULL,0,1,0,100,0),
(179481,8,5336.491,-3392.575,1656.496,NULL,0,1,0,100,0),
(179481,9,5313.634,-3376.501,1655.797,NULL,0,1,0,100,0),
(179481,10,5280.848,-3365.127,1653.092,NULL,0,1,0,100,0),
(179481,11,5254.949,-3367.361,1648.863,NULL,0,1,0,100,0),
(179481,12,5226.675,-3366.948,1644.124,NULL,0,1,0,100,0),
-- Charge 2:
(179482,1,5398.465,-3334.413,1644.141,NULL,0,1,0,100,0),
(179482,2,5407.866,-3345.39,1651.781,NULL,0,1,0,100,0),
(179482,3,5412.883,-3367.02,1657.027,NULL,0,1,0,100,0),
(179482,4,5404.455,-3381.731,1655.2,NULL,0,1,0,100,0),
(179482,5,5389.292,-3401.008,1655.364,NULL,0,1,0,100,0),
(179482,6,5360.398,-3409.638,1655.639,NULL,0,1,0,100,0),
(179482,7,5330.377,-3398.786,1656.515,NULL,0,1,0,100,0),
(179482,8,5296.179,-3382.857,1654.626,NULL,0,1,0,100,0),
(179482,9,5256.719,-3381.501,1647.335,NULL,0,1,0,100,0),
(179482,10,5213.828,-3395.125,1640.61,NULL,0,1,0,100,0),
-- Charge 3:
(179483,1,5399.099,-3341.225,1647.559,NULL,0,1,0,100,0),
(179483,2,5406.6,-3353.619,1653.833,NULL,0,1,0,100,0),
(179483,3,5404.329,-3374.294,1656.086,NULL,0,1,0,100,0),
(179483,4,5382.261,-3399.495,1655.743,NULL,0,1,0,100,0),
(179483,5,5351.165,-3403.543,1655.657,NULL,0,1,0,100,0),
(179483,6,5328.1,-3388.948,1656.283,NULL,0,1,0,100,0),
(179483,7,5301.664,-3373.906,1654.735,NULL,0,1,0,100,0),
(179483,8,5269.483,-3372.737,1650.542,NULL,0,1,0,100,0),
(179483,9,5245.462,-3365.261,1647.703,NULL,0,1,0,100,0),
(179483,10,5230.952,-3377.044,1644.762,NULL,0,1,0,100,0),
-- Path Kazrogal/Azgalor
(178527,1,5539.676,-2464.6082,1470.3188,NULL,0,0,0,100,0),
(178527,2,5544.0605,-2473.5918,1471.5969,NULL,0,0,0,100,0),
(178527,3,5545.5415,-2484.1462,1472.698,NULL,0,0,0,100,0),
(178527,4,5548.466,-2493.9016,1473.9652,NULL,0,0,0,100,0),
(178527,5,5550.698,-2500.9626,1474.5732,NULL,0,0,0,100,0),
(178527,6,5553.463,-2510.5525,1475.7313,NULL,0,0,0,100,0),
(178527,7,5554.3345,-2520.8079,1476.6929,NULL,0,0,0,100,0),
(178527,8,5552.836,-2531.5496,1477.6594,NULL,0,0,0,100,0),
(178527,9,5550.8276,-2545.3945,1478.4252,NULL,0,0,0,100,0),
(178527,10,5548.969,-2559.7285,1478.7358,NULL,0,0,0,100,0),
(178527,11,5547.0005,-2577.7766,1479.2656,NULL,0,0,0,100,0),
(178527,12,5546.04,-2594.6523,1479.6841,NULL,0,0,0,100,0),
(178527,13,5544.9263,-2614.3945,1480.5408,NULL,0,0,0,100,0),
(178527,14,5535.924,-2632.5027,1480.8146,NULL,0,0,0,100,0),
(178527,15,5524.599,-2645.593,1480.7798,NULL,0,0,0,100,0),
(178527,16,5516.548,-2653.839,1480.2125,NULL,0,0,0,100,0),
(178527,17,5507.936,-2661.7375,1480.3279,NULL,0,0,0,100,0),
(178527,18,5497.164,-2674.424,1481.0802,NULL,0,0,0,100,0),
(178527,19,5486.778,-2687.503,1480.3407,NULL,0,0,0,100,0),
(178527,20,5473.4985,-2701.9478,1484.2719,NULL,0,0,0,100,0),
(178527,21,5464.584,-2728.4707,1484.943,NULL,0,0,0,100,0);

SET @CGUID := 139500;

DELETE FROM `creature` WHERE `map` = 534;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+0  , 17919, 534, 3606, 3707, 1, 4977.43, -1754.19, 1330.72, 1.48353, 604800, 0, 0, 53212, 1, ''),
(@CGUID+1  , 17919, 534, 3606, 3707, 1, 4985.85, -1752.35, 1331.03, 1.76278, 604800, 0, 0, 53212, 1, ''),
(@CGUID+2  , 17919, 534, 3606, 3707, 1, 5009.64, -1747.02, 1324.64, 2.26893, 604800, 0, 0, 53212, 1, ''),
(@CGUID+3  , 17921, 534, 3606, 3707, 1, 5011.44, -1841.32, 1322.15, 0.942478, 604800, 0, 0, 53212, 1, ''),
(@CGUID+4  , 17919, 534, 3606, 3707, 1, 5011.84, -1744.41, 1324.42, 2.33874, 604800, 0, 0, 53212, 1, ''),
(@CGUID+5  , 17921, 534, 3606, 3707, 1, 5012.54, -1836.02, 1322.04, 5.02655, 604800, 0, 0, 53212, 1, ''),
(@CGUID+6  , 17919, 534, 3606, 3707, 1, 5012.55, -1747.23, 1323.83, 2.32129, 604800, 0, 0, 53212, 1, ''),
(@CGUID+7  , 17919, 534, 3606, 3707, 1, 5014.69, -1741.37, 1324.34, 2.44346, 604800, 0, 0, 53212, 1, ''),
(@CGUID+8  , 17921, 534, 3606, 3707, 1, 5016.63, -1839.55, 1322.03, 2.80998, 604800, 0, 0, 53212, 1, ''),
(@CGUID+9  , 17919, 534, 3606, 3707, 1, 5017.03, -1738.56, 1324.54, 2.54818, 604800, 0, 0, 53212, 1, ''),
(@CGUID+10 , 17919, 534, 3606, 3707, 1, 5017.44, -1742.19, 1323.47, 2.47837, 604800, 0, 0, 53212, 1, ''),
(@CGUID+11 , 17920, 534, 3606, 3707, 1, 5021.25, -1776.61, 1322.21, 2.23402, 604800, 0, 0, 53212, 1, ''),
(@CGUID+12 , 17921, 534, 3606, 3707, 1, 5026.31, -1839.29, 1322.47, 5.18363, 604800, 0, 0, 53212, 1, ''),
(@CGUID+13 , 17921, 534, 3606, 3707, 1, 5027.99, -1838.47, 1322.52, 5.09636, 604800, 0, 0, 53212, 1, ''),
(@CGUID+14 , 17920, 534, 3606, 3707, 1, 5032.09, -1770.5, 1323.45, 2.33874, 604800, 0, 0, 53212, 1, ''),
(@CGUID+15 , 17920, 534, 3606, 3707, 1, 5036.07, -1768.19, 1324.37, 2.44346, 604800, 0, 0, 53212, 1, ''),
(@CGUID+16 , 17919, 534, 3606, 3707, 1, 5038.15, -1828.31, 1323.34, 6.26573, 604800, 0, 0, 53212, 1, ''),
(@CGUID+17 , 17919, 534, 3606, 3707, 1, 5039.06, -1832.64, 1323.65, 6.14356, 604800, 0, 0, 53212, 1, ''),
(@CGUID+18 , 18410, 534, 3606, 3707, 0, 5051.43, -1820.68, 1331.49, 2.75762, 604800, 0, 0, 53212, 1, ''),
(@CGUID+19 , 18410, 534, 3606, 3707, 0, 5052.48, -1816.86, 1331.29, 3.00197, 604800, 0, 0, 53212, 1, ''),
(@CGUID+20 , 17921, 534, 3606, 3707, 1, 5055.64, -1752.62, 1328.71, 3.14159, 604800, 0, 0, 53212, 1, ''),
(@CGUID+21 , 17921, 534, 3606, 3707, 1, 5057.68, -1749.18, 1328.15, 2.93215, 604800, 0, 0, 53212, 1, ''),
(@CGUID+22 , 17921, 534, 3606, 3707, 1, 5058.63, -1758.04, 1328.41, 3.75246, 604800, 0, 0, 53212, 1, ''),
(@CGUID+23 , 17921, 534, 3606, 3707, 1, 5058.78, -1761.69, 1329.22, 2.84489, 604800, 0, 0, 53212, 1, ''),
(@CGUID+24 , 17928, 534, 3606, 3707, 1, 5060.04, -1754.87, 1328.39, 3.57792, 604800, 0, 0, 53212, 1, ''),
(@CGUID+25 , 17921, 534, 3606, 3707, 1, 5060.19, -1746.06, 1328.7, 2.72271, 604800, 0, 0, 53212, 1, ''),
(@CGUID+26 , 17922, 534, 3606, 3707, 0, 5060.53, -1750.8, 1328.27, 2.67035, 604800, 0, 0, 53212, 1, ''),
(@CGUID+27 , 17921, 534, 3606, 3707, 1, 5060.55, -1742.24, 1329.54, 2.86234, 604800, 0, 0, 53212, 1, ''),
(@CGUID+28 , 17928, 534, 3606, 3707, 1, 5077.1, -1781.57, 1321.37, 3.56047, 604800, 0, 0, 53212, 1, ''),
(@CGUID+29 , 17922, 534, 3606, 3707, 0, 5077.59, -1783.61, 1321.02, 3.19395, 604800, 0, 0, 53212, 1, ''),
(@CGUID+30 , 17928, 534, 3606, 3707, 1, 5078.57, -1798.11, 1321.71, 3.08923, 604800, 0, 0, 53212, 1, ''),
(@CGUID+31 , 17922, 534, 3606, 3707, 0, 5079.28, -1795.91, 1321.04, 3.1765, 604800, 0, 0, 53212, 1, ''),
(@CGUID+32 , 17931, 534, 3606, 3707, 1, 5079.44, -1866.83, 1332.61, 5.75217, 604800, 0, 0, 53212, 1, ''),
(@CGUID+33 , 17931, 534, 3606, 3707, 1, 5079.46, -1866.87, 1332.69, 5.044, 604800, 0, 0, 53212, 1, ''),
(@CGUID+34 , 17772, 534, 3606, 3707, 1, 5084.07, -1789.03, 1322.65, 3.24631, 604800, 0, 0, 53212, 1, ''),
(@CGUID+35 , 17920, 534, 3606, 3707, 1, 5089.45, -1848.55, 1329.33, 3.735, 604800, 0, 0, 53212, 1, ''),
(@CGUID+36 , 17920, 534, 3606, 3707, 1, 5093.99, -1844.91, 1329.47, 3.75246, 604800, 0, 0, 53212, 1, ''),
(@CGUID+37 , 17920, 534, 3606, 3707, 1, 5098.69, -1841.68, 1329.97, 3.75246, 604800, 0, 0, 53212, 1, ''),
(@CGUID+38 , 17931, 534, 3606, 3707, 1, 5127.41, -1837.42, 1336.22, 5.78592, 604800, 0, 0, 53212, 1, ''),
(@CGUID+39 , 17931, 534, 3606, 3707, 1, 5128.12, -1837.74, 1336.32, 5.81195, 604800, 0, 0, 53212, 1, ''),
(@CGUID+40 , 17943, 534, 3606, 3708, 1, 5157.44, -3426.03, 1627.39, 0.296706, 604800, 0, 0, 53212, 1, ''),
(@CGUID+41 , 17943, 534, 3606, 3708, 1, 5159.42, -3432.56, 1627.14, 0.191986, 604800, 0, 0, 53212, 1, ''),
(@CGUID+42 , 18485, 534, 3606, 3708, 0, 5163.26, -3345.21, 1641.04, 5.74213, 604800, 0, 0, 53212, 1, ''),
(@CGUID+43 , 18486, 534, 3606, 3708, 0, 5165.14, -3453.25, 1621.98, 0.977384, 604800, 0, 0, 53212, 1, ''),
(@CGUID+44 , 17943, 534, 3606, 3708, 1, 5168.94, -3368.8, 1639.53, 6.10865, 604800, 0, 0, 53212, 1, ''),
(@CGUID+45 , 17943, 534, 3606, 3708, 1, 5169.7, -3361.55, 1639.84, 6.21337, 604800, 0, 0, 53212, 1, ''),
(@CGUID+46 , 17931, 534, 3606, 3707, 1, 5180.82, -1747.63, 1341.96, 1.11701, 604800, 0, 0, 53212, 1, ''),
(@CGUID+47 , 17931, 534, 3606, 3707, 1, 5180.83, -1747.66, 1341.88, 1.72764, 604800, 0, 0, 53212, 1, ''),
(@CGUID+48 , 17943, 534, 3606, 3708, 1, 5181.5, -3379.46, 1638.86, 5.84685, 604800, 0, 0, 53212, 1, ''),
(@CGUID+50 , 17943, 534, 3606, 3708, 1, 5182.59, -3388.5, 1637.03, 6.24828, 604800, 0, 0, 53212, 1, ''),
(@CGUID+51 , 3794, 534, 3606, 3708, 1, 5183.22, -3376.29, 1639.24, 6.19592, 604800, 0, 0, 53212, 1, ''),
(@CGUID+52 , 3794, 534, 3606, 3708, 1, 5183.81, -3391.38, 1636.23, 0.366519, 604800, 0, 0, 53212, 1, ''),
(@CGUID+53 , 17948, 534, 3606, 3708, 0, 5184.97, -3383.56, 1638.26, 6.00393, 604800, 0, 0, 53212, 1, ''),
(@CGUID+56 , 17944, 534, 3606, 3708, 1, 5187.18, -3362.79, 1642.36, 0.0349066, 604800, 0, 0, 53212, 1, ''),
(@CGUID+57 , 3794, 534, 3606, 3708, 1, 5193.57, -3360.87, 1642.32, 5.79449, 604800, 0, 0, 53212, 1, ''),
(@CGUID+58 , 3794, 534, 3606, 3708, 1, 5196.91, -3356.22, 1642.46, 5.81195, 604800, 0, 0, 53212, 1, ''),
(@CGUID+59 , 17944, 534, 3606, 3708, 1, 5199.48, -3352.92, 1643.05, 5.34071, 604800, 0, 0, 53212, 1, ''),
(@CGUID+60 , 18487, 534, 3606, 3709, 0, 5200.97, -3390.43, 1638.45, 4.02865, 604800, 0, 0, 53212, 1, ''),
(@CGUID+64 , 3795, 534, 3606, 3708, 0, 5209.27, -3372.83, 1642.43, 0, 604800, 0, 0, 53212, 1, ''),
(@CGUID+65 , 3795, 534, 3606, 3708, 0, 5209.52, -3368.27, 1643.27, 6.16101, 604800, 0, 0, 53212, 1, ''),
(@CGUID+66 , 3795, 534, 3606, 3708, 0, 5213.44, -3391.02, 1641.29, 0.10472, 604800, 0, 0, 53212, 1, ''),
(@CGUID+67 , 17945, 534, 3606, 3708, 1, 5213.45, -3366.19, 1643.96, 6.14356, 604800, 0, 0, 53212, 1, ''),
(@CGUID+68 , 18487, 534, 3606, 3708, 0, 5215.74, -3527.86, 1596.18, 1.76278, 604800, 0, 0, 53212, 1, ''),
(@CGUID+69 , 17945, 534, 3606, 3708, 1, 5215.75, -3386.85, 1642.16, 0.279253, 604800, 0, 0, 53212, 1, ''),
(@CGUID+70 , 17945, 534, 3606, 3708, 1, 5215.99, -3375.89, 1642.73, 6.21337, 604800, 0, 0, 53212, 1, ''),
(@CGUID+71 , 17945, 534, 3606, 3708, 1, 5216.91, -3370.14, 1643.44, 6.03884, 604800, 0, 0, 53212, 1, ''),
(@CGUID+72 , 17945, 534, 3606, 3708, 1, 5219.65, -3380.75, 1643.05, 0.226893, 604800, 0, 0, 53212, 1, ''),
(@CGUID+73 , 17945, 534, 3606, 3708, 1, 5219.88, -3392.31, 1641.99, 0.610865, 604800, 0, 0, 53212, 1, ''),
(@CGUID+74 , 17945, 534, 3606, 3708, 1, 5220.54, -3387.66, 1643.1, 0.331613, 604800, 0, 0, 53212, 1, ''),
(@CGUID+75 , 17945, 534, 3606, 3708, 1, 5225.43, -3392.89, 1642.7, 0.733038, 604800, 0, 0, 53212, 1, ''),
(@CGUID+76 , 17944, 534, 3606, 3709, 1, 5252.84, -3696.61, 1593.73, 4.96102, 604800, 0, 0, 53212, 1, ''),
(@CGUID+78 , 17944, 534, 3606, 3710, 1, 5254.69, -3702.35, 1593.68, 5.51092, 604800, 0, 0, 53212, 1, ''),
(@CGUID+80 , 18487, 534, 3606, 3708, 0, 5265.96, -3537.11, 1593.15, 2.35619, 604800, 0, 0, 53212, 1, ''),
(@CGUID+83 , 18487, 534, 3606, 0, 0, 5270.64, -3647.01, 1593.63, 2.07694, 604800, 0, 0, 53212, 1, ''),
(@CGUID+87 , 17943, 534, 3606, 3708, 1, 5290.49, -3476.89, 1571.57, 5.77704, 604800, 0, 0, 53212, 1, ''),
(@CGUID+91 , 17932, 534, 3606, 3708, 1, 5295.08, -2918.28, 1528.73, 5.98648, 604800, 0, 0, 53212, 1, ''),
(@CGUID+92 , 17943, 534, 3606, 3708, 1, 5296.21, -3468.5, 1571.3, 5.5676, 604800, 0, 0, 53212, 1, ''),
(@CGUID+93 , 17943, 534, 3606, 3709, 1, 5296.49, -3724.58, 1593.67, 1.62316, 604800, 0, 0, 53212, 1, ''),
(@CGUID+94 , 17932, 534, 3606, 3708, 1, 5296.51, -2912.17, 1528.68, 5.84685, 604800, 0, 0, 53212, 1, ''),
(@CGUID+95 , 17945, 534, 3606, 3709, 1, 5299.27, -3478.36, 1571.58, 5.82996, 604800, 0, 0, 53212, 1, ''),
(@CGUID+96 , 17945, 534, 3606, 3710, 1, 5299.28, -3478.36, 1571.58, 5.82996, 604800, 0, 0, 53212, 1, ''),
(@CGUID+98 , 18487, 534, 3606, 3708, 0, 5306.79, -3502.34, 1574.73, 0.279253, 604800, 0, 0, 53212, 1, ''),
(@CGUID+100, 3794, 534, 3606, 3708, 1, 5322.81, -3479.56, 1571.21, 5.18363, 604800, 0, 0, 53212, 1, ''),
(@CGUID+101, 17943, 534, 3606, 3708, 1, 5325.3, -3513.76, 1575.8, 0.523599, 604800, 0, 0, 53212, 1, ''),
(@CGUID+103, 3795, 534, 3606, 3708, 0, 5327.88, -3480.59, 1571.53, 5.09636, 604800, 0, 0, 53212, 1, ''),
(@CGUID+104, 17943, 534, 3606, 3708, 1, 5327.99, -3517.7, 1575.53, 0.750492, 604800, 0, 0, 53212, 1, ''),
(@CGUID+106, 17944, 534, 3606, 3708, 1, 5339.67, -3472.82, 1570.84, 4.69494, 604800, 0, 0, 53212, 1, ''),
(@CGUID+110, 18487, 534, 3606, 3709, 0, 5352.73, -3737.26, 1594.15, 2.28638, 604800, 0, 0, 53212, 1, ''),
(@CGUID+116, 17937, 534, 3606, 0, 0, 5379.86, -2782.37, 1500.94, 4.7822, 604800, 0, 0, 53212, 1, ''),
(@CGUID+117, 18242, 534, 3606, 0, 0, 5395.46, -2701, 1591.39, 1.3439, 604800, 0, 0, 53212, 1, ''),
(@CGUID+118, 17932, 534, 3606, 0, 1, 5402.67, -2636.82, 1485.95, 2.42601, 604800, 0, 0, 53212, 1, ''),
(@CGUID+119, 17932, 534, 3606, 0, 1, 5404.11, -2640.58, 1485.89, 3.92699, 604800, 0, 0, 53212, 1, ''),
(@CGUID+120, 17936, 534, 3606, 0, 1, 5406.02, -2634.9, 1485.99, 3.61283, 604800, 0, 0, 53212, 1, ''),
(@CGUID+123, 21075, 534, 3606, 0, 0, 5423.341, -2776.2817, 1495.845, 2.0135, 604800, 18, 1, 53212, 1, ''), -- .go xyz 5423.341 -2776.2817 1495.845
(@CGUID+124, 17932, 534, 3606, 0, 1, 5429.73, -2719.02, 1493.5, 5.89921, 604800, 0, 0, 53212, 1, ''),
(@CGUID+125, 17932, 534, 3606, 0, 1, 5432.78, -2712.07, 1493.44, 5.77704, 604800, 0, 0, 53212, 1, ''),
(@CGUID+129, 17937, 534, 3606, 0, 0, 5443.33, -2641.77, 1486.11, 0.593412, 604800, 0, 0, 53212, 1, ''),
(@CGUID+130, 17936, 534, 3606, 0, 1, 5446.2, -2733.61, 1486.78, 5.98648, 604800, 0, 0, 53212, 1, ''),
(@CGUID+131, 17945, 534, 3606, 3710, 1, 5446.23, -3752, 1593.45, 3.28128, 604800, 0, 0, 53212, 1, ''),
(@CGUID+132, 17932, 534, 3606, 0, 1, 5448.03, -2730.4, 1486.34, 5.77704, 604800, 0, 0, 53212, 1, ''),
(@CGUID+136, 17945, 534, 3606, 3710, 1, 5450.3, -3752.03, 1593.6, 3.01291, 604800, 0, 0, 53212, 1, ''),
(@CGUID+137, 17852, 534, 3606, 0, 1, 5450.54, -2723.97, 1485.59, 6.00393, 604800, 0, 0, 53212, 1, ''),
(@CGUID+138, 17932, 534, 3606, 0, 1, 5453.02, -2717.91, 1485.41, 5.75959, 604800, 0, 0, 53212, 1, ''),
(@CGUID+139, 17936, 534, 3606, 0, 1, 5454.26, -2714.02, 1485.84, 5.74213, 604800, 0, 0, 53212, 1, ''),
(@CGUID+140, 17937, 534, 3606, 3708, 0, 5462, -3020.82, 1550.56, 5.00909, 604800, 0, 0, 53212, 1, ''),
(@CGUID+141, 17932, 534, 3606, 3708, 1, 5474.48, -2960.79, 1538.62, 3.33358, 604800, 0, 0, 53212, 1, ''),
(@CGUID+142, 17932, 534, 3606, 3708, 1, 5475.69, -2962.18, 1538.61, 4.76475, 604800, 0, 0, 53212, 1, ''),
(@CGUID+143, 17936, 534, 3606, 3708, 1, 5479.41, -2960.67, 1538.67, 6.21337, 604800, 0, 0, 53212, 1, ''),
(@CGUID+144, 21075, 534, 3606, 0, 0, 5484.9087, -2703.8464, 1482.2607, 5.6719, 604800, 18, 1, 53212, 1, ''), -- .go xyz 5484.9087 -2703.8464 1482.2607
(@CGUID+145, 21075, 534, 3606, 0, 0, 5491.1406, -2642.3113, 1483.6621, 1.75461, 604800, 18, 1, 53212, 1, ''), -- .go xyz 5491.1406 -2642.3113 1483.6621
(@CGUID+146, 22418, 534, 3606, 3708, 0, 5502.29, -3525.47, 1607.91, 2.61799, 604800, 0, 0, 53212, 1, ''),
(@CGUID+147, 18242, 534, 3606, 0, 0, 5511.56, -2613.27, 1571.1, 4.95674, 604800, 0, 0, 53212, 1, ''),
(@CGUID+148, 17936, 534, 3606, 0, 1, 5525.91, -2651.66, 1480.31, 0.994838, 604800, 0, 0, 53212, 1, ''),
(@CGUID+149, 17934, 534, 3606, 0, 1, 5527.72, -2654.04, 1480.4, 1.11701, 604800, 0, 0, 53212, 1, ''),
(@CGUID+150, 17935, 534, 3606, 0, 1, 5527.88, -2647.67, 1480.53, 0.942478, 604800, 0, 0, 53212, 1, ''),
(@CGUID+151, 21075, 534, 3606, 0, 0, 5525.578, -2775.6309, 1493.732, 0.289304, 604800, 18, 1, 53212, 1, ''), -- .go xyz 5525.578 -2775.6309 1493.732
(@CGUID+152, 17932, 534, 3606, 0, 1, 5530.38, -2616, 1482.05, 1.13446, 604800, 0, 0, 53212, 1, ''),
(@CGUID+153, 17934, 534, 3606, 0, 1, 5531.03, -2653.56, 1480.89, 1.27409, 604800, 0, 0, 53212, 1, ''),
(@CGUID+154, 17932, 534, 3606, 0, 1, 5531.22, -2646.66, 1480.8, 1.11701, 604800, 0, 0, 53212, 1, ''),
(@CGUID+155, 17934, 534, 3606, 0, 1, 5531.31, -2620.96, 1481.75, 1.15192, 604800, 0, 0, 53212, 1, ''),
(@CGUID+156, 17932, 534, 3606, 0, 1, 5533.26, -2649.4, 1480.99, 1.32645, 604800, 0, 0, 53212, 1, ''),
(@CGUID+157, 21075, 534, 3606, 0, 0, 5523.555, -2624.4573, 1483.3141, 2.53951, 604800, 18, 1, 53212, 1, ''), -- .go xyz 5523.555 -2624.4573 1483.3141
(@CGUID+158, 17932, 534, 3606, 0, 1, 5535.46, -2618.07, 1481.09, 1.3439, 604800, 0, 0, 53212, 1, ''),
(@CGUID+159, 18242, 534, 3606, 0, 0, 5536.6, -2813.09, 1607.19, 5.20108, 604800, 0, 0, 53212, 1, ''),
(@CGUID+163, 18242, 534, 3606, 0, 0, 5548.28, -2669.32, 1566.98, 1.69297, 604800, 0, 0, 53212, 1, ''),
(@CGUID+164, 17932, 534, 3606, 0, 1, 5553.03, -2620.14, 1483.44, 1.29154, 604800, 0, 0, 53212, 1, ''),
(@CGUID+165, 17934, 534, 3606, 0, 1, 5555.78, -2623.09, 1485.04, 1.39626, 604800, 0, 0, 53212, 1, ''),
(@CGUID+166, 17932, 534, 3606, 0, 1, 5558.76, -2619.38, 1484.9, 1.46608, 604800, 0, 0, 53212, 1, ''),
(@CGUID+167, 17933, 534, 3606, 0, 1, 5565.76, -2749.21, 1493.03, 0.471239, 604800, 0, 0, 53212, 1, ''),
(@CGUID+168, 21075, 534, 3606, 0, 0, 5569.671, -2711.739, 1486.5406, 4.62437, 604800, 18, 1, 53212, 1, ''), -- .go xyz 5569.671 -2711.739 1486.5406
(@CGUID+169, 17933, 534, 3606, 0, 1, 5567.78, -2767.72, 1496.12, 1.93732, 604800, 0, 0, 53212, 1, ''),
(@CGUID+170, 17937, 534, 3606, 0, 0, 5569.97, -2808.87, 1496.67, 5.51524, 604800, 0, 0, 53212, 1, ''),
(@CGUID+171, 17933, 534, 3606, 0, 1, 5574.74, -2765.05, 1496.11, 1.98968, 604800, 0, 0, 53212, 1, ''),
(@CGUID+172, 17937, 534, 3606, 0, 0, 5583.79, -2801, 1497.02, 3.76991, 604800, 0, 0, 53212, 1, ''),
(@CGUID+173, 17934, 534, 3606, 0, 1, 5583.92, -2871.97, 1509.32, 1.53589, 604800, 0, 0, 53212, 1, ''),
(@CGUID+174, 17935, 534, 3606, 0, 1, 5585.52, -2880.71, 1510.48, 0.506145, 604800, 0, 0, 53212, 1, ''),
(@CGUID+175, 17933, 534, 3606, 0, 1, 5589.5, -2747.72, 1494.99, 2.79253, 604800, 0, 0, 53212, 1, ''),
(@CGUID+176, 17933, 534, 3606, 0, 1, 5591.39, -2710.66, 1495.22, 2.23492, 604800, 0, 0, 53212, 1, ''),
(@CGUID+177, 17933, 534, 3606, 0, 1, 5593.42, -2705.79, 1495.34, 3.22171, 604800, 0, 0, 53212, 1, ''),
(@CGUID+178, 17935, 534, 3606, 0, 1, 5595.58, -2879.75, 1510.85, 2.25147, 604800, 0, 0, 53212, 1, ''),
(@CGUID+179, 17934, 534, 3606, 0, 1, 5597.48, -2872.26, 1510.43, 1.67552, 604800, 0, 0, 53212, 1, ''),
(@CGUID+180, 17968, 534, 3606, 3708, 0, 5601.94, -3446.28, 1577.49, 3.7001, 604800, 0, 0, 53212, 1, ''),
(@CGUID+181, 17935, 534, 3606, 3708, 1, 5610.72, -2864.04, 1510.41, 1.18682, 604800, 0, 0, 53212, 1, ''),
(@CGUID+182, 17934, 534, 3606, 3708, 1, 5613.05, -2863.32, 1510.57, 3.75246, 604800, 0, 0, 53212, 1, ''),
(@CGUID+183, 17934, 534, 3606, 3708, 1, 5613.93, -2861.24, 1510.55, 5.20108, 604800, 0, 0, 53212, 1, ''),
(@CGUID+184, 18242, 534, 3606, 0, 0, 5613.96, -2864.49, 1617.05, 0.488692, 604800, 0, 0, 53212, 1, ''),
(@CGUID+185, 17934, 534, 3606, 0, 1, 5620.57, -2838.21, 1510.05, 3.57792, 604800, 0, 0, 53212, 1, ''),
(@CGUID+186, 17935, 534, 3606, 0, 1, 5621.84, -2872.65, 1516.67, 2.37365, 604800, 0, 0, 53212, 1, ''),
(@CGUID+187, 17934, 534, 3606, 0, 1, 5623.98, -2851.45, 1510.88, 3.28122, 604800, 0, 0, 53212, 1, ''),
(@CGUID+188, 17935, 534, 3606, 0, 1, 5628.56, -2837.21, 1510.69, 4.79966, 604800, 0, 0, 53212, 1, ''),
(@CGUID+189, 17935, 534, 3606, 0, 1, 5633.4, -2847.48, 1510.89, 2.68781, 604800, 0, 0, 53212, 1, ''),
(@CGUID+190, 18242, 534, 3606, 0, 0, 5659.94, -2706.53, 1623.12, 6.17847, 604800, 0, 0, 53212, 1, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 17931);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1793100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1793100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 234, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - Actionlist - Set Emote State 234'),
(1793100, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - Actionlist - Set Emote State 0'),
(1793100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34450, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - Actionlist - Cast \'Serverside - Transform: Peasant w/ wood 1.5 scale\'');

-- Pathing for Alliance Peasant Entry: 17931
SET @NPC := @CGUID+32;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0, `position_x`=5003.422, `position_y`=-1812.4004, `position_z`=1324.9794, `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5003.422,-1812.4004,1324.9794,NULL,0,1,0,100,0),
(@PATH,2,5020.7896,-1822.1841,1321.8822,NULL,0,1,0,100,0),
(@PATH,3,5027.415,-1830.3462,1322.3582,NULL,0,1,0,100,0),
(@PATH,4,5032.8115,-1837.5527,1322.6923,NULL,0,1,0,100,0),
(@PATH,5,5029.3413,-1847.1005,1322.8157,NULL,0,1,0,100,0), -- Restore DisplayID
(@PATH,6,5017.648,-1832.1534,1322.2935,NULL,0,1,0,100,0),
(@PATH,7,5000.286,-1817.0605,1324.2848,NULL,0,1,0,100,0),
(@PATH,8,4994.4697,-1812.6699,1325.5862,NULL,0,1,0,100,0),
(@PATH,9,4988.094,-1810.8834,1326.4082,NULL,15000,1,0,100,0); -- EmoteState: 234, Wait, EmoteState: 0, Change DisplayID
-- 0x2041D042C01182C0001A700000400218 .go xyz 4988.094 -1810.8834 1326.4082

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+32));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+32), 0, 0, 0, 34, 0, 100, 0, 2, 4, 0, 0, 0, 0, 28, 34450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 5 - Morph To Creature Alliance Peasant'),
(-(@CGUID+32), 0, 1, 0, 34, 0, 100, 0, 2, 8, 0, 0, 0, 0, 80, 1793100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 9 - Run Script');

-- Pathing for Alliance Peasant Entry: 17931
SET @NPC := @CGUID+33;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0, `position_x`=5000.421, `position_y`=-1824.226, `position_z`=1322.8263, `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5000.421,-1824.226,1322.8263,NULL,0,1,0,100,0),
(@PATH,2,5014.165,-1829.6202,1321.8112,NULL,0,1,0,100,0),
(@PATH,3,5021.6553,-1837.3629,1322.1084,NULL,0,1,0,100,0),
(@PATH,4,5024.5986,-1844.7291,1322.3765,NULL,0,1,0,100,0), -- Drop-Off Point
(@PATH,5,5008.992,-1826.0797,1321.7955,NULL,0,1,0,100,0),
(@PATH,6,4991.596,-1823.4846,1322.3386,NULL,0,1,0,100,0),
(@PATH,7,4983.954,-1822.4202,1323.9797,NULL,15000,1,0,100,0); -- Gathering Point
-- 0x2041D042C01182C0001A700000C00218 .go xyz 5000.421 -1824.226 1322.8263

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+33));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+33), 0, 0, 0, 34, 0, 100, 0, 2, 3, 0, 0, 0, 0, 28, 34450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 4 - Morph To Creature Alliance Peasant'),
(-(@CGUID+33), 0, 1, 0, 34, 0, 100, 0, 2, 6, 0, 0, 0, 0, 80, 1793100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 7 - Run Script');

-- Pathing for Alliance Peasant Entry: 17931
SET @NPC := @CGUID+38;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0, `position_x`=4991.2017, `position_y`=-1890.2266, `position_z`=1323.8444, `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4991.2017,-1890.2266,1323.8444,NULL,0,1,0,100,0),
(@PATH,2,4990.703,-1877.779,1325.4882,NULL,0,1,0,100,0),
(@PATH,3,4994.119,-1861.8668,1323.8944,NULL,0,1,0,100,0),
(@PATH,4,5000.5195,-1848.0977,1321.4746,NULL,0,1,0,100,0),
(@PATH,5,5005.852,-1837.3362,1321.5898,NULL,0,1,0,100,0),
(@PATH,6,5010.9785,-1833.4484,1321.8032,NULL,0,1,0,100,0),
(@PATH,7,5017.1743,-1835.3833,1322.1208,NULL,0,1,0,100,0),
(@PATH,8,5022.0044,-1844.526,1322.1273,NULL,0,1,0,100,0), -- Drop-Off Point
(@PATH,9,5015.521,-1832.7224,1322.138,NULL,0,1,0,100,0),
(@PATH,10,5003.582,-1841.0365,1321.5421,NULL,0,1,0,100,0),
(@PATH,11,5001.8853,-1853.1309,1321.816,NULL,0,1,0,100,0),
(@PATH,12,4992.4297,-1862.9193,1323.7732,NULL,0,1,0,100,0),
(@PATH,13,4990.6484,-1892.488,1324.1987,NULL,0,1,0,100,0),
(@PATH,14,4987.013,-1906.442,1325.7903,NULL,15000,1,0,100,0); -- Gathering Point
-- 0x2041D042C01182C0001A700000C006A0 .go xyz 4991.2017 -1890.2266 1323.8444

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+38));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+38), 0, 0, 0, 34, 0, 100, 0, 2, 7, 0, 0, 0, 0, 28, 34450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 8 - Morph To Creature Alliance Peasant'),
(-(@CGUID+38), 0, 1, 0, 34, 0, 100, 0, 2, 13, 0, 0, 0, 0, 80, 1793100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 14 - Run Script');

-- Pathing for Alliance Peasant Entry: 17931
SET @NPC := @CGUID+39;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0, `position_x`=5069.4785, `position_y`=-1860.3552, `position_z`=1330.5989, `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5069.4785,-1860.3552,1330.5989,NULL,0,1,0,100,0),
(@PATH,2,5059.571,-1855.0143,1330.4702,NULL,0,1,0,100,0),
(@PATH,3,5047.421,-1850.3926,1325.5967,NULL,0,1,0,100,0),
(@PATH,4,5037.3306,-1847.6276,1323.2708,NULL,0,1,0,100,0),
(@PATH,5,5031.386,-1848.9727,1322.8899,NULL,0,1,0,100,0), -- Drop-Off Point
(@PATH,6,5044.1133,-1846.7307,1325.2062,NULL,0,1,0,100,0),
(@PATH,7,5052.628,-1850.0354,1328.3458,NULL,0,1,0,100,0),
(@PATH,8,5058.213,-1854.2598,1330.693,NULL,0,1,0,100,0),
(@PATH,9,5071.7656,-1862.3429,1330.9974,NULL,0,1,0,100,0),
(@PATH,10,5079.445,-1866.832,1332.6095,NULL,15000,1,0,100,0); -- Gathering Point
-- 0x2041D042C01182C0001A7000014006A0 .go xyz 5069.4785 -1860.3552 1330.5989

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+39));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+39), 0, 0, 0, 34, 0, 100, 0, 2, 4, 0, 0, 0, 0, 28, 34450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 5 - Morph To Creature Alliance Peasant'),
(-(@CGUID+39), 0, 1, 0, 34, 0, 100, 0, 2, 9, 0, 0, 0, 0, 80, 1793100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 10 - Run Script');

-- Pathing for Alliance Peasant Entry: 17931
SET @NPC := @CGUID+46;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0, `position_x`=5108.6543, `position_y`=-1829.8281, `position_z`=1332.1666, `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5108.6543,-1829.8281,1332.1666,NULL,0,1,0,100,0),
(@PATH,2,5090.1724,-1824.534,1326.0935,NULL,0,1,0,100,0),
(@PATH,3,5075.831,-1816.2897,1327.3918,NULL,0,1,0,100,0),
(@PATH,4,5065.625,-1819.1721,1328.3113,NULL,0,1,0,100,0), -- Drop-Off Point
(@PATH,5,5080.348,-1816.2665,1326.5297,NULL,0,1,0,100,0),
(@PATH,6,5093.8135,-1819.2887,1325.0078,NULL,0,1,0,100,0),
(@PATH,7,5105.567,-1825.8922,1331.2261,NULL,0,1,0,100,0),
(@PATH,8,5121.2637,-1834.0996,1334.7421,NULL,0,1,0,100,0),
(@PATH,9,5128.01,-1837.7463,1336.2344,NULL,15000,1,0,100,0); -- Gathering Point
-- 0x2041D042C01182C0001A700001C006A0 .go xyz 5108.6543 -1829.8281 1332.1666

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+46));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+46), 0, 0, 0, 34, 0, 100, 0, 2, 3, 0, 0, 0, 0, 28, 34450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 4 - Morph To Creature Alliance Peasant'),
(-(@CGUID+46), 0, 1, 0, 34, 0, 100, 0, 2, 8, 0, 0, 0, 0, 80, 1793100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 9 - Run Script');

-- Pathing for Alliance Peasant Entry: 17931
SET @NPC := @CGUID+47;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0, `position_x`=5185.7217, `position_y`=-1762.1578, `position_z`=1341.171, `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5185.7217,-1762.1578,1341.171,NULL,0,1,0,100,0),
(@PATH,2,5194.6743,-1770.3418,1342.8949,NULL,0,1,0,100,0), -- Drop-Off Point
(@PATH,3,5182.0474,-1755.3268,1341.0415,NULL,0,1,0,100,0),
(@PATH,4,5180.835,-1747.6619,1341.8806,NULL,15000,1,0,100,0); -- Gathering Point
-- 0x2041D042C01182C0001A7000024006A0 .go xyz 5185.7217 -1762.1578 1341.171

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+47));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+47), 0, 0, 0, 34, 0, 100, 0, 2, 1, 0, 0, 0, 0, 28, 34450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 2 - Morph To Creature Alliance Peasant'),
(-(@CGUID+47), 0, 1, 0, 34, 0, 100, 0, 2, 3, 0, 0, 0, 0, 80, 1793100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Peasant - On Reached Point 4 - Run Script');

-- Pathing for Night Elf Ancient Protector Entry: 18487
SET @NPC := @CGUID+60;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=5191.082,`position_y`=-3395.7676,`position_z`=1635.7031 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5191.082,-3395.7676,1635.7031,NULL,0,0,0,100,0),
(@PATH,2,5185.34,-3409.625,1631.2288,NULL,0,0,0,100,0),
(@PATH,3,5184.0737,-3427.5159,1626.4192,NULL,0,0,0,100,0),
(@PATH,4,5185.2446,-3447.1873,1619.7747,NULL,0,0,0,100,0),
(@PATH,5,5191.766,-3468.6787,1612.0193,NULL,0,0,0,100,0),
(@PATH,6,5209.388,-3494.7979,1602.2993,NULL,0,0,0,100,0),
(@PATH,7,5232.348,-3520.591,1594.947,NULL,0,0,0,100,0),
(@PATH,8,5247.761,-3542.484,1593.443,NULL,0,0,0,100,0),
(@PATH,9,5254.1987,-3565.466,1593.6853,NULL,0,0,0,100,0),
(@PATH,10,5255.0054,-3585.8901,1593.3921,NULL,0,0,0,100,0),
(@PATH,11,5261.713,-3612.1646,1593.4518,NULL,0,0,0,100,0),
(@PATH,12,5255.0054,-3585.8901,1593.3921,NULL,0,0,0,100,0),
(@PATH,13,5254.1987,-3565.466,1593.6853,NULL,0,0,0,100,0),
(@PATH,14,5247.761,-3542.484,1593.443,NULL,0,0,0,100,0),
(@PATH,15,5232.348,-3520.591,1594.947,NULL,0,0,0,100,0),
(@PATH,16,5209.388,-3494.7979,1602.2993,NULL,0,0,0,100,0),
(@PATH,17,5191.766,-3468.6787,1612.0193,NULL,0,0,0,100,0),
(@PATH,18,5185.2446,-3447.1873,1619.7747,NULL,0,0,0,100,0),
(@PATH,19,5184.0737,-3427.5159,1626.4192,NULL,0,0,0,100,0),
(@PATH,20,5185.3403,-3409.6243,1631.3291,NULL,0,0,0,100,0);
-- 0x20421042C0120DC0003937000043BE02 .go xyz 5191.082 -3395.7676 1635.7031

-- Pathing for Night Elf Huntress Entry: 17945
SET @NPC := @CGUID+95;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=5299.007,`position_y`=-3476.6523,`position_z`=1571.3604 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,9991,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5299.007,-3476.6523,1571.3604,NULL,0,0,0,100,0),
(@PATH,2,5305.033,-3481.1665,1571.6854,NULL,0,0,0,100,0),
(@PATH,3,5314.0376,-3488.2551,1571.8191,NULL,0,0,0,100,0),
(@PATH,4,5323.1606,-3495.5571,1572.3907,NULL,0,0,0,100,0),
(@PATH,5,5332.1885,-3505.6038,1572.3901,NULL,0,0,0,100,0),
(@PATH,6,5337.7344,-3522.8813,1573.6587,NULL,0,0,0,100,0),
(@PATH,7,5337.3877,-3538.5098,1574.0547,NULL,0,0,0,100,0),
(@PATH,8,5334.9575,-3562.013,1574.4476,NULL,0,0,0,100,0),
(@PATH,9,5331.947,-3577.3765,1576.1665,NULL,0,0,0,100,0),
(@PATH,10,5326.3457,-3592.1895,1578.2057,NULL,0,0,0,100,0),
(@PATH,11,5320.32,-3607.7139,1581.2488,NULL,0,0,0,100,0),
(@PATH,12,5316.1304,-3618.5278,1584.138,NULL,0,0,0,100,0),
(@PATH,13,5306.2314,-3623.1382,1586.6583,NULL,0,0,0,100,0),
(@PATH,14,5290.6953,-3617.834,1591.1653,NULL,0,0,0,100,0),
(@PATH,15,5282.639,-3615.638,1592.4778,NULL,0,0,0,100,0),
(@PATH,16,5271.6846,-3608.5305,1593.4456,NULL,0,0,0,100,0),
(@PATH,17,5282.639,-3615.638,1592.4778,NULL,0,0,0,100,0),
(@PATH,18,5290.6953,-3617.834,1591.1653,NULL,0,0,0,100,0),
(@PATH,19,5306.2314,-3623.1382,1586.6583,NULL,0,0,0,100,0),
(@PATH,20,5316.1304,-3618.5278,1584.138,NULL,0,0,0,100,0),
(@PATH,21,5320.32,-3607.7139,1581.2488,NULL,0,0,0,100,0),
(@PATH,22,5326.3457,-3592.1895,1578.2057,NULL,0,0,0,100,0),
(@PATH,23,5331.947,-3577.3765,1576.1665,NULL,0,0,0,100,0),
(@PATH,24,5334.9575,-3562.013,1574.4476,NULL,0,0,0,100,0),
(@PATH,25,5337.3877,-3538.5098,1574.0547,NULL,0,0,0,100,0),
(@PATH,26,5337.7344,-3522.8813,1573.6587,NULL,0,0,0,100,0),
(@PATH,27,5332.1885,-3505.6038,1572.3901,NULL,0,0,0,100,0),
(@PATH,28,5323.1606,-3495.5571,1572.3907,NULL,0,0,0,100,0),
(@PATH,29,5314.0376,-3488.2551,1571.8191,NULL,0,0,0,100,0),
(@PATH,30,5305.033,-3481.1665,1571.6854,NULL,0,0,0,100,0);
-- 0x20421042C0118640003937000443BE02 .go xyz 5299.007 -3476.6523 1571.3604

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+95;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+95, @CGUID+95, 0, 0, 515),
(@CGUID+95, @CGUID+96, 3, 90, 515);

-- Pathing for Night Elf Huntress Entry: 17945
SET @NPC := @CGUID+131;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=5435.328,`position_y`=-3752.5872,`position_z`=1593.2037 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,9991,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5435.328,-3752.5872,1593.2037,NULL,0,0,0,100,0),
(@PATH,2,5425.6167,-3751.1567,1593.217,NULL,0,0,0,100,0),
(@PATH,3,5415.356,-3748.309,1593.2809,NULL,0,0,0,100,0),
(@PATH,4,5406.085,-3743.683,1593.2966,NULL,0,0,0,100,0),
(@PATH,5,5397.433,-3737.2153,1593.2366,NULL,0,0,0,100,0),
(@PATH,6,5389.3877,-3727.9045,1593.2043,NULL,0,0,0,100,0),
(@PATH,7,5384.1357,-3721.515,1593.3615,NULL,0,0,0,100,0),
(@PATH,8,5379.6934,-3717.947,1593.5956,NULL,0,0,0,100,0),
(@PATH,9,5370.5493,-3716.3018,1593.4722,NULL,0,0,0,100,0),
(@PATH,10,5359.3945,-3717.097,1593.3472,NULL,0,0,0,100,0),
(@PATH,11,5349.4985,-3720.476,1593.375,NULL,0,0,0,100,0),
(@PATH,12,5337.5806,-3720.257,1593.3894,NULL,0,0,0,100,0),
(@PATH,13,5326.2163,-3716.001,1593.3934,NULL,0,0,0,100,0),
(@PATH,14,5316.3833,-3710.6594,1593.3799,NULL,0,0,0,100,0),
(@PATH,15,5308.631,-3708.5095,1593.3741,NULL,0,0,0,100,0),
(@PATH,16,5298.179,-3709.8281,1593.4276,NULL,0,0,0,100,0),
(@PATH,17,5293.256,-3713.177,1593.3756,NULL,0,0,0,100,0),
(@PATH,18,5283.939,-3714.4094,1593.377,NULL,0,0,0,100,0),
(@PATH,19,5275.0806,-3713.0027,1593.3689,NULL,0,0,0,100,0),
(@PATH,20,5268.3247,-3709.4844,1593.2709,NULL,0,0,0,100,0),
(@PATH,21,5263.3296,-3704.3174,1593.2239,NULL,0,0,0,100,0),
(@PATH,22,5259.268,-3697.881,1593.3438,NULL,0,0,0,100,0),
(@PATH,23,5263.3296,-3704.3174,1593.2239,NULL,0,0,0,100,0),
(@PATH,24,5268.3247,-3709.4844,1593.2709,NULL,0,0,0,100,0),
(@PATH,25,5275.0806,-3713.0027,1593.3689,NULL,0,0,0,100,0),
(@PATH,26,5283.939,-3714.4094,1593.377,NULL,0,0,0,100,0),
(@PATH,27,5293.256,-3713.177,1593.3756,NULL,0,0,0,100,0),
(@PATH,28,5298.179,-3709.8281,1593.4276,NULL,0,0,0,100,0),
(@PATH,29,5308.631,-3708.5095,1593.3741,NULL,0,0,0,100,0),
(@PATH,30,5316.3833,-3710.6594,1593.3799,NULL,0,0,0,100,0),
(@PATH,31,5326.2163,-3716.001,1593.3934,NULL,0,0,0,100,0),
(@PATH,32,5337.5806,-3720.257,1593.3894,NULL,0,0,0,100,0),
(@PATH,33,5349.4985,-3720.476,1593.375,NULL,0,0,0,100,0),
(@PATH,34,5359.3945,-3717.097,1593.3472,NULL,0,0,0,100,0),
(@PATH,35,5370.5493,-3716.3018,1593.4722,NULL,0,0,0,100,0),
(@PATH,36,5379.6934,-3717.947,1593.5956,NULL,0,0,0,100,0),
(@PATH,37,5384.1357,-3721.515,1593.3615,NULL,0,0,0,100,0),
(@PATH,38,5389.3877,-3727.9045,1593.2043,NULL,0,0,0,100,0),
(@PATH,39,5397.433,-3737.2153,1593.2366,NULL,0,0,0,100,0),
(@PATH,40,5406.085,-3743.683,1593.2966,NULL,0,0,0,100,0),
(@PATH,41,5415.356,-3748.309,1593.2809,NULL,0,0,0,100,0),
(@PATH,42,5425.6167,-3751.1567,1593.217,NULL,0,0,0,100,0),
(@PATH,43,5435.328,-3752.5872,1593.2037,NULL,0,0,0,100,0),
(@PATH,44,5442.177,-3752.573,1593.3159,NULL,0,0,0,100,0),
(@PATH,45,5448.136,-3751.9253,1593.4143,NULL,0,0,0,100,0),
(@PATH,46,5442.177,-3752.573,1593.3159,NULL,0,0,0,100,0);
-- 0x20421042C0118640003937000543C11A .go xyz 5435.328 -3752.5872 1593.2037

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+131;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+131, @CGUID+131, 0, 0, 515),
(@CGUID+131, @CGUID+136, 3, 90, 515);

-- Pathing for Dryad Entry: 17944
SET @NPC := @CGUID+76;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=5264.7056,`position_y`=-3713.448,`position_z`=1593.3866 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5264.7056,-3713.448,1593.3866,NULL,0,0,0,100,0),
(@PATH,2,5273.546,-3718.1858,1593.3721,NULL,0,0,0,100,0),
(@PATH,3,5281.3184,-3718.923,1593.573,NULL,0,0,0,100,0),
(@PATH,4,5288.2305,-3718.5286,1593.373,NULL,0,0,0,100,0),
(@PATH,5,5297.058,-3716.3972,1593.3693,NULL,0,0,0,100,0),
(@PATH,6,5302.896,-3713.7456,1593.3308,NULL,0,0,0,100,0),
(@PATH,7,5311.189,-3713.6094,1593.3392,NULL,0,0,0,100,0),
(@PATH,8,5318.7437,-3718.1284,1593.2903,NULL,0,0,0,100,0),
(@PATH,9,5323.797,-3720.7058,1593.3455,NULL,0,0,0,100,0),
(@PATH,10,5334.475,-3724.4485,1593.352,NULL,0,0,0,100,0),
(@PATH,11,5344.2144,-3725.7153,1593.367,NULL,0,0,0,100,0),
(@PATH,12,5353.362,-3723.5166,1593.2617,NULL,0,0,0,100,0),
(@PATH,13,5362.4385,-3720.4392,1593.315,NULL,0,0,0,100,0),
(@PATH,14,5374.8345,-3721.4705,1593.3422,NULL,0,0,0,100,0),
(@PATH,15,5382.7188,-3728.1868,1593.2393,NULL,0,0,0,100,0),
(@PATH,16,5389.229,-3736.7844,1593.3204,NULL,0,0,0,100,0),
(@PATH,17,5397.1406,-3744.8074,1593.3749,NULL,0,0,0,100,0),
(@PATH,18,5405.1294,-3750.3025,1593.4207,NULL,0,0,0,100,0),
(@PATH,19,5414.4307,-3753.711,1593.3528,NULL,0,0,0,100,0),
(@PATH,20,5425.8125,-3756.4246,1593.3507,NULL,0,0,0,100,0),
(@PATH,21,5437.0376,-3758.744,1593.3192,NULL,0,0,0,100,0),
(@PATH,22,5448.9443,-3758.3538,1593.3413,NULL,0,0,0,100,0),
(@PATH,23,5437.0376,-3758.744,1593.3192,NULL,0,0,0,100,0),
(@PATH,24,5425.8125,-3756.4246,1593.3507,NULL,0,0,0,100,0),
(@PATH,25,5414.4307,-3753.711,1593.3528,NULL,0,0,0,100,0),
(@PATH,26,5405.1294,-3750.3025,1593.4207,NULL,0,0,0,100,0),
(@PATH,27,5397.1406,-3744.8074,1593.3749,NULL,0,0,0,100,0),
(@PATH,28,5389.229,-3736.7844,1593.3204,NULL,0,0,0,100,0),
(@PATH,29,5382.7188,-3728.1868,1593.2393,NULL,0,0,0,100,0),
(@PATH,30,5374.8345,-3721.4705,1593.3422,NULL,0,0,0,100,0),
(@PATH,31,5362.4385,-3720.4392,1593.315,NULL,0,0,0,100,0),
(@PATH,32,5353.362,-3723.5166,1593.2617,NULL,0,0,0,100,0),
(@PATH,33,5344.2144,-3725.7153,1593.367,NULL,0,0,0,100,0),
(@PATH,34,5334.475,-3724.4485,1593.352,NULL,0,0,0,100,0),
(@PATH,35,5323.797,-3720.7058,1593.3455,NULL,0,0,0,100,0),
(@PATH,36,5318.7437,-3718.1284,1593.2903,NULL,0,0,0,100,0),
(@PATH,37,5311.189,-3713.6094,1593.3392,NULL,0,0,0,100,0),
(@PATH,38,5302.896,-3713.7456,1593.3308,NULL,0,0,0,100,0),
(@PATH,39,5297.058,-3716.3972,1593.3693,NULL,0,0,0,100,0),
(@PATH,40,5288.2305,-3718.5286,1593.373,NULL,0,0,0,100,0),
(@PATH,41,5281.3184,-3718.923,1593.573,NULL,0,0,0,100,0),
(@PATH,42,5273.546,-3718.1858,1593.3721,NULL,0,0,0,100,0),
(@PATH,43,5264.7056,-3713.448,1593.3866,NULL,0,0,0,100,0),
(@PATH,44,5258.706,-3706.2612,1593.3306,NULL,0,0,0,100,0),
(@PATH,45,5254.9053,-3700.251,1593.6155,NULL,0,0,0,100,0),
(@PATH,46,5258.706,-3706.2612,1593.3306,NULL,0,0,0,100,0);
-- 0x20421042C01186000039370001C3C11A .go xyz 5264.7056 -3713.448 1593.3866

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+76;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+76, @CGUID+76, 0, 0, 515),
(@CGUID+76, @CGUID+78, 3, 90, 515);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 18502);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(18502, 0, 0, 1, 0, 0, 0, 0);

INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`, `CreateObject`) VALUES
(@CGUID+191, 18502, 534, 3606, 3708, 1, 1, 0, 5183.1640625, -3330.692138671875, 1658.9739990234375, 0.550150036811828613, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+192, 18502, 534, 3606, 3708, 1, 1, 0, 5448.1396484375, -3422.109375, 1614.663818359375, 5.158170223236083984, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+193, 18502, 534, 3606, 3708, 1, 1, 0, 5199.26416015625, -3449.848388671875, 1632.0843505859375, 5.524151802062988281, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+194, 18502, 534, 3606, 3708, 1, 1, 0, 5282.49609375, -3496.091796875, 1589.5469970703125, 3.148438692092895507, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+195, 18502, 534, 3606, 3708, 1, 1, 0, 5353.22802734375, -3524.94775390625, 1615.479736328125, 2.314115524291992187, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+196, 18502, 534, 3606, 0, 1, 1, 0, 5279.9814453125, -3577.314453125, 1602.425048828125, 6.231225013732910156, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+197, 18502, 534, 3606, 3709, 1, 1, 0, 5348.55078125, -3713.2197265625, 1631.9088134765625, 6.280591964721679687, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+198, 18502, 534, 3606, 3709, 1, 1, 0, 5332.248046875, -3738.275146484375, 1604.2158203125, 4.293509960174560546, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1),
(@CGUID+199, 18502, 534, 3606, 3709, 1, 1, 0, 5543.38427734375, -3678.641845703125, 1641.70166015625, 1.391820549964904785, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 53162, 1);

SET @NPC := @CGUID+191;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5175.17,-3335.6682,1702.594,NULL,0,2,0,100,0),
(@PATH,2,5179.8467,-3332.8003,1677.6858,NULL,0,2,0,100,0),
(@PATH,3,5184.5234,-3329.9324,1652.7776,NULL,0,2,0,100,0),
(@PATH,4,5186.5117,-3329.7183,1656.3245,NULL,0,2,0,100,0),
(@PATH,5,5186.4185,-3317.4497,1656.3245,NULL,0,2,0,100,0),
(@PATH,6,5174.828,-3320.402,1665.1858,NULL,0,2,0,100,0),
(@PATH,7,5179.8467,-3332.8003,1677.6858,NULL,0,2,0,100,0);
SET @NPC := @CGUID+192;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5453.93,-3445.0269,1661.5223,NULL,0,2,0,100,0),
(@PATH,2 ,5451.331,-3441.9954,1614.6638,NULL,0,2,0,100,0),
(@PATH,3 ,5448.732,-3438.9639,1567.8053,NULL,0,2,0,100,0),
(@PATH,4 ,5442.241,-3449.367,1567.8053,NULL,0,2,0,100,0),
(@PATH,5 ,5433.7734,-3441.0415,1575.7169,NULL,0,2,0,100,0),
(@PATH,6 ,5429.977,-3433.0925,1589.4136,NULL,0,2,0,100,0),
(@PATH,7 ,5437.532,-3425.6953,1605.3582,NULL,0,2,0,100,0),
(@PATH,8 ,5455.2017,-3428.909,1605.3582,NULL,0,2,0,100,0),
(@PATH,9 ,5447.9077,-3449.513,1605.3582,NULL,0,2,0,100,0),
(@PATH,10,5441.386,-3449.6074,1608.0803,NULL,0,2,0,100,0),
(@PATH,11,5428.7856,-3433.9016,1608.0803,NULL,0,2,0,100,0),
(@PATH,12,5433.687,-3415.9895,1614.6638,NULL,0,2,0,100,0),
(@PATH,13,5447.588,-3421.133,1614.6638,NULL,0,2,0,100,0),
(@PATH,14,5451.331,-3441.9954,1614.6638,NULL,0,2,0,100,0);
SET @NPC := @CGUID+193;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5223,-3449.5881,1664.8036,NULL,0,2,0,100,0),
(@PATH,2 ,5211.626,-3442.667,1646.275,NULL,0,2,0,100,0),
(@PATH,3 ,5200.252,-3435.7458,1627.7465,NULL,0,2,0,100,0),
(@PATH,4 ,5197.0576,-3441.895,1630.58,NULL,0,2,0,100,0),
(@PATH,5 ,5197.9707,-3448.4182,1630.58,NULL,0,2,0,100,0),
(@PATH,6 ,5204.7495,-3452.355,1638.1915,NULL,0,2,0,100,0),
(@PATH,7 ,5209.617,-3443.6575,1638.1915,NULL,0,2,0,100,0),
(@PATH,8 ,5202.3823,-3436.5696,1638.1915,NULL,0,2,0,100,0),
(@PATH,9 ,5194.8955,-3446.2964,1646.2749,NULL,0,2,0,100,0),
(@PATH,10,5200.3706,-3450.9705,1646.275,NULL,0,2,0,100,0),
(@PATH,11,5211.626,-3442.667,1646.275,NULL,0,2,0,100,0);
SET @NPC := @CGUID+194;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5277.312,-3488.295,1592.3969,NULL,0,2,0,100,0),
(@PATH,2 ,5272.53,-3496.9312,1590.8019,NULL,0,2,0,100,0),
(@PATH,3 ,5268.7866,-3503.691,1589.5535,NULL,0,2,0,100,0),
(@PATH,4 ,5268.4053,-3513.8447,1593.1161,NULL,0,2,0,100,0),
(@PATH,5 ,5280.1895,-3520.3958,1599.859,NULL,0,2,0,100,0),
(@PATH,6 ,5287.64,-3519.473,1599.776,NULL,0,2,0,100,0),
(@PATH,7 ,5293.863,-3510.8965,1603.4421,NULL,0,2,0,100,0),
(@PATH,8 ,5290.794,-3502.3347,1597.3589,NULL,0,2,0,100,0),
(@PATH,9 ,5280.21,-3496.0518,1598.4419,NULL,0,2,0,100,0),
(@PATH,10,5272.7603,-3500.0032,1597.1091,NULL,0,2,0,100,0),
(@PATH,11,5270.3945,-3511.9126,1596.4146,NULL,0,2,0,100,0),
(@PATH,12,5281.597,-3519.99,1592.0515,NULL,0,2,0,100,0),
(@PATH,13,5291.821,-3514.0513,1589.1349,NULL,0,2,0,100,0),
(@PATH,14,5291.9297,-3503.919,1589.1349,NULL,0,2,0,100,0),
(@PATH,15,5286.316,-3496.5337,1589.1349,NULL,0,2,0,100,0),
(@PATH,16,5272.53,-3496.9312,1590.8019,NULL,0,2,0,100,0);
SET @NPC := @CGUID+195;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5358.927,-3529.513,1675.0258,NULL,0,2,0,100,0),
(@PATH,2 ,5354.117,-3525.79,1625.6924,NULL,0,2,0,100,0),
(@PATH,3 ,5349.3076,-3522.0671,1576.359,NULL,0,2,0,100,0),
(@PATH,4 ,5342.557,-3527.316,1581.2201,NULL,0,2,0,100,0),
(@PATH,5 ,5342.6284,-3534.9758,1588.0253,NULL,0,2,0,100,0),
(@PATH,6 ,5345.241,-3539.3655,1588.0253,NULL,0,2,0,100,0),
(@PATH,7 ,5351.7173,-3541.48,1588.0253,NULL,0,2,0,100,0),
(@PATH,8 ,5360.744,-3542.3826,1593.0256,NULL,0,2,0,100,0),
(@PATH,9 ,5357.922,-3530.3625,1593.0256,NULL,0,2,0,100,0),
(@PATH,10,5343.929,-3537.143,1600.8035,NULL,0,2,0,100,0),
(@PATH,11,5348.7695,-3543.2688,1610.1091,NULL,0,2,0,100,0),
(@PATH,12,5360.525,-3541.8135,1625.6924,NULL,0,2,0,100,0),
(@PATH,13,5354.117,-3525.79,1625.6924,NULL,0,2,0,100,0);
SET @NPC := @CGUID+196;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5287.0786,-3583.8542,1640.0116,NULL,0,2,0,100,0),
(@PATH,2 ,5281.141,-3580.5986,1621.3223,NULL,0,2,0,100,0),
(@PATH,3 ,5275.2036,-3577.343,1602.6329,NULL,0,2,0,100,0),
(@PATH,4 ,5289.229,-3576.8425,1605.7164,NULL,0,2,0,100,0),
(@PATH,5 ,5293.1934,-3568.7683,1606.8829,NULL,0,2,0,100,0),
(@PATH,6 ,5287.012,-3557.8396,1609.9106,NULL,0,2,0,100,0),
(@PATH,7 ,5276.9805,-3560.5012,1608.9108,NULL,0,2,0,100,0),
(@PATH,8 ,5274.0166,-3568.3398,1606.914,NULL,0,2,0,100,0),
(@PATH,9 ,5275.465,-3576.3774,1603.9888,NULL,0,2,0,100,0),
(@PATH,10,5283.831,-3579.047,1603.9888,NULL,0,2,0,100,0),
(@PATH,11,5293.0728,-3571.5684,1603.9888,NULL,0,2,0,100,0),
(@PATH,12,5291.6626,-3559.1484,1603.9888,NULL,0,2,0,100,0),
(@PATH,13,5284.6743,-3556.134,1603.9888,NULL,0,2,0,100,0),
(@PATH,14,5269.0493,-3568.4536,1612.8778,NULL,0,2,0,100,0),
(@PATH,15,5275.8184,-3581.6826,1616.4054,NULL,0,2,0,100,0),
(@PATH,16,5290.163,-3580.2751,1621.3223,NULL,0,2,0,100,0),
(@PATH,17,5291.582,-3566.5696,1621.3223,NULL,0,2,0,100,0),
(@PATH,18,5269.6665,-3567.7278,1621.3223,NULL,0,2,0,100,0),
(@PATH,19,5281.141,-3580.5986,1621.3223,NULL,0,2,0,100,0);
SET @NPC := @CGUID+197;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5348.586,-3717.211,1662.6599,NULL,0,2,0,100,0),
(@PATH,2 ,5349.979,-3713.2673,1634.216,NULL,0,2,0,100,0),
(@PATH,3 ,5351.372,-3709.3237,1605.772,NULL,0,2,0,100,0),
(@PATH,4 ,5346.263,-3702.8516,1601.3828,NULL,0,2,0,100,0),
(@PATH,5 ,5340.142,-3705.64,1607.7719,NULL,0,2,0,100,0),
(@PATH,6 ,5339.936,-3712.9492,1611.772,NULL,0,2,0,100,0),
(@PATH,7 ,5348.981,-3715.8403,1613.0222,NULL,0,2,0,100,0),
(@PATH,8 ,5351.2256,-3708.5166,1617.1887,NULL,0,2,0,100,0),
(@PATH,9 ,5346.9766,-3701.4114,1619.494,NULL,0,2,0,100,0),
(@PATH,10,5344.5024,-3705.3906,1622.0775,NULL,0,2,0,100,0),
(@PATH,11,5343.121,-3712.2415,1622.7996,NULL,0,2,0,100,0),
(@PATH,12,5349.979,-3713.2673,1634.216,NULL,0,2,0,100,0);
SET @NPC := @CGUID+199;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,5552.369,-3677.1848,1669.385,NULL,0,2,0,100,0),
(@PATH,2 ,5544.649,-3671.1028,1641.7015,NULL,0,2,0,100,0),
(@PATH,3 ,5536.9287,-3665.0208,1614.0181,NULL,0,2,0,100,0),
(@PATH,4 ,5529.6323,-3666.2817,1610.6621,NULL,0,2,0,100,0),
(@PATH,5 ,5530.9736,-3682.5574,1610.6621,NULL,0,2,0,100,0),
(@PATH,6 ,5529.621,-3684.5105,1615.3289,NULL,0,2,0,100,0),
(@PATH,7 ,5536.771,-3690.3376,1620.0514,NULL,0,2,0,100,0),
(@PATH,8 ,5547.222,-3690.615,1622.5626,NULL,0,2,0,100,0),
(@PATH,9 ,5552.064,-3672.5815,1641.7015,NULL,0,2,0,100,0),
(@PATH,10,5538.0063,-3673.0051,1641.7015,NULL,0,2,0,100,0),
(@PATH,11,5530.4404,-3677.5027,1641.7015,NULL,0,2,0,100,0),
(@PATH,12,5535.0376,-3687.274,1641.7015,NULL,0,2,0,100,0),
(@PATH,13,5541.433,-3685.7432,1641.7015,NULL,0,2,0,100,0),
(@PATH,14,5544.649,-3671.1028,1641.7015,NULL,0,2,0,100,0);

INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`, `CreateObject`) VALUES
(@CGUID+200, 23381, 534, 3606, 3606, 1, 1, 0, 4207.2490234375, -4170.94775390625, 870.29791259765625, 4.6190032958984375, 7200, 0, 0, 2854, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+201, 23437, 534, 3606, 3606, 1, 1, 0, 4207.0302734375, -4174.95166015625, 870.20172119140625, 1.01229095458984375, 7200, 0, 0, 2854, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+203, 17895, 534, 3606, 3707, 1, 1, 0, 5074.56298828125, -1399.97607421875, 1347.513427734375, 0.701761364936828613, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+204, 17895, 534, 3606, 3707, 1, 1, 0, 5021.6494140625, -1407.258056640625, 1341.207763671875, 2.423222064971923828, 7200, 5, 0, 28490, 0, 1, 0, 0, 0, 53441, 1),
(@CGUID+205, 17898, 534, 3606, 3707, 1, 1, 0, 4991.2314453125, -1499.123291015625, 1328.668701171875, 2.199114799499511718, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+206, 17895, 534, 3606, 3707, 1, 1, 0, 5075.04345703125, -1394.339599609375, 1347.9810791015625, 0.7014390230178833, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+207, 17899, 534, 3606, 3707, 1, 1, 0, 5133.38916015625, -1507.2886962890625, 1343.748291015625, 0.593411922454833984, 7200, 0, 0, 31339, 31550, 0, 0, 0, 0, 53441, 1),
(@CGUID+208, 17895, 534, 3606, 3707, 1, 1, 0, 5096.24072265625, -1410.71533203125, 1345.6279296875, 2.085644721984863281, 7200, 5, 0, 28490, 0, 1, 0, 0, 0, 53441, 1),
(@CGUID+209, 17899, 534, 3606, 3707, 1, 1, 0, 5065.6533203125, -1489.5419921875, 1339.8717041015625, 2.687807083129882812, 7200, 0, 0, 31339, 31550, 0, 0, 0, 0, 53441, 1),
(@CGUID+210, 17895, 534, 3606, 3707, 1, 1, 0, 5175.7314453125, -1412.775390625, 1357.9713134765625, 2.130637168884277343, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+211, 17898, 534, 3606, 3707, 1, 1, 0, 5226.07275390625, -1497.2896728515625, 1357.368896484375, 2.635447263717651367, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+212, 17895, 534, 3606, 3707, 1, 1, 0, 5069.40673828125, -1393.859130859375, 1346.6536865234375, 0.701439082622528076, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+213, 17895, 534, 3606, 3707, 1, 1, 0, 5041.36474609375, -1404.6981201171875, 1340.38623046875, 2.942538022994995117, 7200, 5, 0, 28490, 0, 1, 0, 0, 0, 53441, 1),
(@CGUID+214, 17898, 534, 3606, 3707, 1, 1, 0, 4958.056640625, -1512.07177734375, 1328.5419921875, 2.268928050994873046, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+215, 17895, 534, 3606, 3707, 1, 1, 0, 5103.375, -1421.326171875, 1344.05712890625, 2.160853147506713867, 7200, 5, 0, 28490, 0, 1, 0, 0, 0, 53441, 1),
(@CGUID+216, 17895, 534, 3606, 3707, 1, 1, 0, 5181.30078125, -1413.2357177734375, 1357.980224609375, 2.109403371810913085, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+217, 17899, 534, 3606, 3707, 1, 1, 0, 5128.91259765625, -1498.0618896484375, 1343.5498046875, 0.296705961227416992, 7200, 0, 0, 31339, 31550, 0, 0, 0, 0, 53441, 1),
(@CGUID+218, 17895, 534, 3606, 3707, 1, 1, 0, 5032.779296875, -1412.4598388671875, 1338.6812744140625, 1.059731483459472656, 7200, 5, 0, 28490, 0, 1, 0, 0, 0, 53441, 1),
(@CGUID+219, 17898, 534, 3606, 3707, 1, 1, 0, 4982.5537109375, -1480.29736328125, 1334.1748046875, 4.956735134124755859, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+220, 17898, 534, 3606, 3707, 1, 1, 0, 5213.392578125, -1514.15283203125, 1356.3935546875, 2.321287870407104492, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+221, 17895, 534, 3606, 3707, 1, 1, 0, 5068.92626953125, -1399.49560546875, 1346.1173095703125, 0.700876593589782714, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+222, 17899, 534, 3606, 3707, 1, 1, 0, 5059.646484375, -1498.7052001953125, 1339.72314453125, 2.443460941314697265, 7200, 0, 0, 31339, 31550, 0, 0, 0, 0, 53441, 1),
(@CGUID+223, 17895, 534, 3606, 3707, 1, 1, 0, 5100.9423828125, -1402.6151123046875, 1347.002685546875, 5.370904922485351562, 7200, 5, 0, 28490, 0, 1, 0, 0, 0, 53441, 1),
(@CGUID+224, 17898, 534, 3606, 3707, 1, 1, 0, 4949.74658203125, -1495.2032470703125, 1329.9912109375, 5.113814830780029296, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+225, 17895, 534, 3606, 3707, 1, 1, 0, 5077.1962890625, -1393.1485595703125, 1348.568115234375, 3.920779943466186523, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+226, 17899, 534, 3606, 3707, 1, 1, 0, 5080.59375, -1382.0968017578125, 1350.7303466796875, 2.426007747650146484, 7200, 0, 0, 31339, 31550, 0, 0, 0, 0, 53441, 1),
(@CGUID+227, 17895, 534, 3606, 3707, 1, 1, 0, 5148.35009765625, -1381.5263671875, 1359.44873046875, 5.425849437713623046, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+228, 17895, 534, 3606, 3707, 1, 1, 0, 5151.234375, -1383.8292236328125, 1359.478271484375, 5.072760581970214843, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+229, 17899, 534, 3606, 3707, 1, 1, 0, 5085.501953125, -1378.0906982421875, 1352.6923828125, 1.745329260826110839, 7200, 0, 0, 31339, 31550, 0, 0, 0, 0, 53441, 1),
(@CGUID+230, 17895, 534, 3606, 3707, 1, 1, 0, 5152.77197265625, -1381.805419921875, 1360.1126708984375, 3.629253387451171875, 7200, 0, 0, 28490, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+231, 17898, 534, 3606, 3707, 1, 1, 0, 5151.00634765625, -1363.4737548828125, 1362.3115234375, 4.433136463165283203, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1),
(@CGUID+232, 17898, 534, 3606, 3707, 1, 1, 0, 5174.26416015625, -1376.85205078125, 1362.4879150390625, 4.188790321350097656, 7200, 0, 0, 36838, 0, 0, 0, 0, 0, 53441, 1);

-- Pathing for Tydormu Entry: 23381
SET @NPC := @CGUID+200;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=4208.146,`position_y`=-4161.3047,`position_z`=871.5502 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4208.146,-4161.3047,871.5502,NULL,0,0,0,100,0),
(@PATH,2,4207.5547,-4152.5645,873.2675,NULL,0,0,0,100,0),
(@PATH,3,4217.3516,-4145.958,874.3431,NULL,0,0,0,100,0),
(@PATH,4,4217.3413,-4139.6655,875.0955,NULL,0,0,0,100,0),
(@PATH,5,4210.1665,-4132.9946,876.0334,NULL,0,0,0,100,0),
(@PATH,6,4211.619,-4126.547,876.44293,NULL,0,0,0,100,0),
(@PATH,7,4209.6978,-4118.6157,877.18414,NULL,150000,0,0,100,0),
(@PATH,8,4213.8022,-4127.348,876.4273,NULL,0,0,0,100,0),
(@PATH,9,4211.368,-4133.0728,875.8512,NULL,0,0,0,100,0),
(@PATH,10,4212.566,-4136.404,875.5329,NULL,0,0,0,100,0),
(@PATH,11,4218.2603,-4146.1943,874.22833,NULL,0,0,0,100,0),
(@PATH,12,4211.281,-4152.491,873.2412,NULL,0,0,0,100,0),
(@PATH,13,4208.703,-4155.4263,872.7387,NULL,0,0,0,100,0),
(@PATH,14,4207.249,-4170.9478,870.2979,NULL,150000,0,0,100,0);
-- 0x20420442C016D540006F40000063A1F4 .go xyz 4208.146 -4161.3047 871.5502

DELETE FROM `creature_text` WHERE `CreatureID` IN (23437, 23381);
INSERT INTO `creature_text` (`CreatureID`, `Text`, `Type`, `Probability`, `Emote`, `BroadcastTextId`, `comment`) VALUES
(23437, 'Do you think the rumors about the Infinite Dragonflight are true?  I\'ve sensed it... the familiarity.', 12, 100, 1, 21646, 'Indormi'),
(23381, 'That is a dangerous train of thought.  If something was truly amiss, Soridormi would be the first to know.', 12, 100, 274, 21645, 'Indormi');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23381;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23381);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23381, 0, 0, 0, 34, 0, 100, 0, 2, 13, 0, 0, 0, 0, 80, 2338100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tydormu - On Reached Point 14 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2338100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2338100, 9, 0, 0, 0, 0, 100, 0, 0, 150000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, @CGUID+201, 0, 0, 0, 0, 0, 0, 0, 'Tydormu - Actionlist - Say Line Indormi'),
(2338100, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tydormu - Actionlist - Say Line Me');

-- Pathing for Ghoul Entry: 17895
SET @NPC := @CGUID+206;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=5045.213,`position_y`=-1424.5989,`position_z`=1338.5521 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '8278');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5045.213,-1424.5989,1338.5521,NULL,0,0,0,100,0),
(@PATH,2,5041.382,-1445.8447,1337.0543,NULL,0,0,0,100,0),
(@PATH,3,5059.2803,-1453.4364,1338.3757,NULL,0,0,0,100,0),
(@PATH,4,5088.3643,-1445.386,1341.4679,NULL,0,0,0,100,0),
(@PATH,5,5109.8687,-1461.8468,1343.547,NULL,0,0,0,100,0),
(@PATH,6,5132.5156,-1473.7787,1346.8394,NULL,0,0,0,100,0),
(@PATH,7,5145.405,-1489.5441,1346.6038,NULL,0,0,0,100,0),
(@PATH,8,5125.4575,-1483.8262,1344.9581,NULL,0,0,0,100,0),
(@PATH,9,5100.58,-1475.0762,1342.8356,NULL,0,0,0,100,0),
(@PATH,10,5077.2407,-1472.9622,1341.8923,NULL,0,0,0,100,0),
(@PATH,11,5055.6504,-1481.5358,1336.4326,NULL,0,0,0,100,0),
(@PATH,12,5040.8843,-1495.7177,1334.0103,NULL,0,0,0,100,0),
(@PATH,13,5012.168,-1481.6132,1330.3761,NULL,0,0,0,100,0),
(@PATH,14,5020.8813,-1464.9039,1333.0469,NULL,0,0,0,100,0),
(@PATH,15,5028.0454,-1449.2146,1335.1632,NULL,0,0,0,100,0),
(@PATH,16,5042.798,-1421.6515,1338.514,NULL,0,0,0,100,0),
(@PATH,17,5060.235,-1406.8214,1343.3564,NULL,0,0,0,100,0),
(@PATH,18,5081.393,-1389.0035,1349.9054,NULL,0,0,0,100,0),
(@PATH,19,5064.051,-1406.1183,1344.3596,NULL,0,0,0,100,0);
-- 0x20420442C01179C0006F40000063A1F4 .go xyz 5045.213 -1424.5989 1338.5521

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+206;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+206, @CGUID+206, 0, 0, 515),
(@CGUID+206, @CGUID+212, 3, 90, 515),
(@CGUID+206, @CGUID+221, 3, 180, 515),
(@CGUID+206, @CGUID+203, 3, 270, 515),
(@CGUID+206, @CGUID+225, 3, 360, 515);

-- Pathing for Ghoul Entry: 17895
SET @NPC := @CGUID+228;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=5174.2876,`position_y`=-1421.7716,`position_z`=1356.1212 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '8278');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5174.2876,-1421.7716,1356.1212,NULL,0,0,0,100,0),
(@PATH,2,5136.5547,-1427.7441,1349.4026,NULL,0,0,0,100,0),
(@PATH,3,5138.226,-1439.8142,1350.0007,NULL,0,0,0,100,0),
(@PATH,4,5178.2573,-1430.1982,1355.8934,NULL,0,0,0,100,0),
(@PATH,5,5196.151,-1441.7623,1356.8679,NULL,0,0,0,100,0),
(@PATH,6,5197.1797,-1457.3593,1356.2646,NULL,0,0,0,100,0),
(@PATH,7,5175.2544,-1467.7914,1352.3032,NULL,0,0,0,100,0),
(@PATH,8,5158.6465,-1476.2866,1348.4136,NULL,0,0,0,100,0),
(@PATH,9,5177.061,-1472.3872,1352.2786,NULL,0,0,0,100,0),
(@PATH,10,5196.2954,-1471.1919,1355.5061,NULL,0,0,0,100,0),
(@PATH,11,5199.8267,-1500.7716,1352.5355,NULL,0,0,0,100,0),
(@PATH,12,5213.6943,-1495.6226,1354.7474,NULL,0,0,0,100,0),
(@PATH,13,5217.239,-1475.2815,1356.7562,NULL,0,0,0,100,0),
(@PATH,14,5197.961,-1441.2156,1357.0381,NULL,0,0,0,100,0),
(@PATH,15,5181.914,-1413.9789,1357.8496,NULL,0,0,0,100,0),
(@PATH,16,5158.718,-1385.8767,1360.0275,NULL,0,0,0,100,0),
(@PATH,17,5147.666,-1380.7362,1359.3472,NULL,0,0,0,100,0),
(@PATH,18,5173.4326,-1410.497,1358.3572,NULL,0,0,0,100,0);
-- 0x20420442C01179C0006F40000463A1F4 .go xyz 5174.2876 -1421.7716 1356.1212

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+228;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+228, @CGUID+228, 0, 0, 515),
(@CGUID+228, @CGUID+230, 3, 90, 515),
(@CGUID+228, @CGUID+227, 3, 180, 515),
(@CGUID+228, @CGUID+216, 3, 270, 515),
(@CGUID+228, @CGUID+210, 3, 360, 515);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21075;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21075);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21075, 0, 0, 0, 38, 0, 100, 0, 21, 1, 0, 0, 0, 0, 88, 2107500, 2107505, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - On Data Set 21 Single - Run Random Script'),
(21075, 0, 1, 0, 38, 0, 100, 0, 21, 2, 0, 0, 0, 0, 88, 2107506, 2107511, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - On Data Set 21 Double - Run Random Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2107500 AND 2107511);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2107500, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+117, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107501, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+147, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107502, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+159, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107503, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+163, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107504, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+184, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107505, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+190, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),

(2107506, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+117, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107506, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+117, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107507, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+147, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107507, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+147, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107508, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+159, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107508, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+159, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107509, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+163, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107509, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+163, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107510, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+184, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107510, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+184, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107511, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+190, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\''),
(2107511, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 32148, 2, 10, @CGUID+190, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - Actionlist - Cross Cast \'Infernal\'');

UPDATE `creature_template_movement` SET `Ground` = 1, `Flight` = 0 WHERE (`CreatureId` = 21075); -- Prevent Infernals from floating

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 17908);
UPDATE `creature_template_addon` SET `auras` = '22707 31722' WHERE (`entry` = 17908);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17908);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17908, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Giant Infernal - On Respawn - Start Random Movement 10y');

-- Doors
UPDATE `gameobject_template_addon` SET `flags` = 34 WHERE (`entry` = 182060);
UPDATE `gameobject_template_addon` SET `flags` = 34 WHERE (`entry` = 182061);

-- From CMangos
DELETE FROM `areatrigger_teleport` WHERE `id` IN (4311, 4312, 4313);
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(4311, 'Battle Of Mount Hyjal, Alliance Base (Entrance)', 534, 5066.79, -1791.9, 1321.65, 2.35619),
(4312, 'Battle Of Mount Hyjal, Horde Base (Entrance)', 534, 5499.96, -2756.8, 1488.96, 1.39626),
(4313, 'Battle Of Mount Hyjal, Night Elf Base (Entrance)', 534, 5163.02, -3428.31, 1627.61, 0.785398);

DELETE FROM `creature_addon` WHERE `guid` IN (6747, 51475, 52070, 52074);
DELETE FROM `waypoint_data` WHERE `id` IN (67470, 514750, 520700, 520740);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 17864);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17864);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17864, 0, 0, 0, 0, 0, 100, 0, 0, 8000, 8000, 10000, 0, 0, 11, 31406, 0, 0, 0, 0, 0, 5, 45, 0, 0, 31406, 0, 0, 0, 0, 'Lesser Doomguard - In Combat - Cast \'Cripple\''),
(17864, 0, 1, 0, 106, 0, 100, 0, 7000, 11000, 11000, 18000, 0, 10, 11, 31408, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lesser Doomguard - On Hostile in Range - Cast \'War Stomp\''),
(17864, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lesser Doomguard - On Just Summoned - Set In Combat With Zone');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 17921);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17921);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17921, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 5000, 8000, 0, 0, 11, 7896, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Rifleman - In Combat - Cast \'Exploding Shot\''),
(17921, 0, 1, 0, 9, 0, 100, 0, 0, 2100, 2100, 3200, 8, 40, 11, 32103, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Rifleman - Within 8-40 Range - Cast \'Shoot\'');

-- Fix Archimonde
UPDATE `creature_template` SET `speed_walk` = 3.2, `speed_run` = 2.285714, `scale` = 1, `BaseAttackTime` = 1500 WHERE (`entry` = 17968);
UPDATE `creature_model_info` SET `BoundingRadius` = 9.894683837890625, `CombatReach` = 12 WHERE  `DisplayID`=20939;

DELETE FROM `creature_template_addon` WHERE (`entry` = 17937);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17937, 0, 0, 0, 1, 234, 0, '');

-- Hide Building from players
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|130 WHERE (`entry` = 18304);
