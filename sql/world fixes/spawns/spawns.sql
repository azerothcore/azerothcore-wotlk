-- ------------------------------------------
-- POOLS
-- ------------------------------------------

-- pussywizard: pool_pool has pools from different maps! this may lead to crashes
-- select pp.mother_pool as mp, group_concat(distinct pp.pool_id) as pools, group_concat(distinct c.map) as maps, sum(if(c.map=0,1,0)) as m0, sum(if(c.map=1,1,0)) as m1 from pool_pool pp join pool_gameobject p on pp.pool_id = p.pool_entry join gameobject c on p.guid = c.guid group by pp.mother_pool having count(distinct c.map) > 1;
-- select pp.mother_pool as mp, group_concat(distinct pp.pool_id) as pools, group_concat(distinct c.map) as maps, sum(if(c.map=0,1,0)) as m0, sum(if(c.map=1,1,0)) as m1 from pool_pool pp join pool_creature p on pp.pool_id = p.pool_entry join creature c on p.guid = c.guid group by pp.mother_pool having count(distinct c.map) > 1;
DELETE FROM pool_pool WHERE pool_id=3155 AND mother_pool=2001;
DELETE FROM pool_pool WHERE pool_id=4414 AND mother_pool=2009;
DELETE gameobject FROM pool_gameobject JOIN gameobject ON pool_gameobject.guid=gameobject.guid WHERE pool_gameobject.pool_entry IN(3155, 4414);
DELETE FROM pool_gameobject WHERE pool_entry IN(3155, 4414);
DELETE FROM pool_template WHERE entry IN(3155, 4414);


-- ------------------------------------------
-- DELETE WRONG SPAWNS
-- ------------------------------------------
-- Drelik Blastpipe <Arena Vendor> (27721)
-- Drolig Blastpipe <Arena Vendor> (27722)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(27721, 27722));
DELETE FROM creature WHERE id IN(27721, 27722);


-- ------------------------------------------
-- DATA CORRECTION
-- ------------------------------------------
-- Fix orientation
UPDATE creature SET orientation = 0 WHERE orientation > 6.29;
UPDATE gameobject SET orientation = 0 WHERE orientation > 6.29;

-- Ozzie Togglevolt (1268)
UPDATE creature SET modelid=3441 WHERE id=1268;
REPLACE INTO smart_scripts VALUES(1268, 0, 6, 0, 60, 0, 100, 0, 5000, 5000, 30000, 30000, 3, 0, 3441, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Morph to model");

-- Faldorf Bitterchill <Flight Master> (29750)
UPDATE creature SET position_x=6665.59, position_y=-261.258, position_z=961.82, orientation=0.962 WHERE id=29750;

-- Lich-Lord Chillwinter (25682)
UPDATE creature SET position_z=111.6, spawndist=0, MovementType=0 WHERE id=25682;

-- Aspatha the Broodmother (25498)
UPDATE creature SET position_z=99, spawndist=0, MovementType=0 WHERE id=25498;

-- npc Bhag'thera (728) respawn time reduced to 5min
UPDATE creature SET spawntimesecs=300 WHERE id=728;

-- Tethis (730)
UPDATE creature SET spawntimesecs=480 WHERE id=730;

-- King Jokkum (30105)
UPDATE creature SET phasemask=5 WHERE id=30105;

-- Northrend Daily Dungeon Image Bunny(32265)
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=32265;

-- Scarshield Quartermaster <Scarshield Legion> (9046)
UPDATE creature SET spawntimesecs=120 WHERE id=9046;

-- Preserved Threshadon Carcass (169216)
-- Wrathscale Fountain (202275)
-- TEMP Scarlet Crusade Forward Camp (300029)
UPDATE gameobject SET spawntimesecs=180 WHERE id IN(169216, 202275, 300029);

-- Waterlogged Footlocker (179487)
UPDATE gameobject SET spawntimesecs=30 WHERE id=179487;

-- Netherwing Egg (185915)
UPDATE gameobject SET animprogress=100, state=1 WHERE id=185915;

-- Shrine of Remulus (15885)
UPDATE gameobject SET orientation=3.14, rotation0=0 WHERE id=15885;

-- Chronalis (8197)
UPDATE creature SET position_z=-0.26068 WHERE id=8197;

-- Bash'ir Crystalforge (185921)
UPDATE gameobject SET position_x=4019.9636, position_y=5894.8032, position_z=267.8731 WHERE id=185921;


-- ------------------------------------------
-- MISSING CREATURE SPAWNS
-- ------------------------------------------
-- Time-Lost Proto Drake (32491)
-- Vyrygosa (32630)
DELETE FROM pool_creature WHERE pool_entry=60002;
DELETE FROM pool_template WHERE entry=60002;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32630, 32491));
DELETE FROM creature WHERE id IN(32630, 32491);
UPDATE creature_template SET speed_run=3, InhabitType=4, HoverHeight=1, AIName='', ScriptName='npc_time_lost_proto_drake' WHERE entry IN(32630, 32491);
UPDATE creature_model_info SET combat_reach=8 WHERE modelid IN(28110, 26711);
REPLACE INTO creature_template_addon VALUES(32491, 0, 0, 50331648, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(32630, 0, 0, 50331648, 0, 0, '');
INSERT INTO creature VALUES (NULL, 32491, 571, 1, 1, 0, 0, 7095.35, -287.507, 929.642, 1.25586, 3600*4, 0, 0, 18900, 0, 0, 0, 0, 0);
DELETE FROM script_waypoint WHERE entry=32491;
INSERT INTO script_waypoint VALUES (32491, 1, 7075.1, -244.398, 807.095, 0, 'Time-Lost Proto Drake'),(32491, 2, 7058.68, -229.769, 799.321, 0, 'Time-Lost Proto Drake'),(32491, 3, 7015.86, -208.601, 789.023, 0, 'Time-Lost Proto Drake'),(32491, 4, 6983.18, -196.699, 785.172, 0, 'Time-Lost Proto Drake'),(32491, 5, 6918.72, -174.838, 769.05, 0, 'Time-Lost Proto Drake'),(32491, 6, 6886.89, -163.886, 759.534, 0, 'Time-Lost Proto Drake'),(32491, 7, 6842.48, -141.862, 752.487, 0, 'Time-Lost Proto Drake'),(32491, 8, 6813.63, -120.149, 750.958, 0, 'Time-Lost Proto Drake'),(32491, 9, 6769.42, -65.9483, 752.738, 0, 'Time-Lost Proto Drake'),(32491, 10, 6747.93, -38.3491, 753.504, 0, 'Time-Lost Proto Drake'),(32491, 11, 6711.18, -0.905537, 753, 0, 'Time-Lost Proto Drake'),(32491, 12, 6674.33, 17.9824, 749.735, 0, 'Time-Lost Proto Drake'),(32491, 13, 6641.14, 23.042, 747.662, 0, 'Time-Lost Proto Drake'),(32491, 14, 6605.94, 15.8523, 745.188, 0, 'Time-Lost Proto Drake'),(32491, 15, 6544.4, -16.3795, 736.919, 0, 'Time-Lost Proto Drake'),(32491, 16, 6509.91, -41.7824, 726.561, 0, 'Time-Lost Proto Drake'),(32491, 17, 6487.8, -67.0193, 716.598, 0, 'Time-Lost Proto Drake'),(32491, 18, 6460.02, -104.545, 706.726, 0, 'Time-Lost Proto Drake'),(32491, 19, 6426.82, -165.979, 702.346, 0, 'Time-Lost Proto Drake'),(32491, 20, 6411.3, -197.238, 700.276, 0, 'Time-Lost Proto Drake'),(32491, 21, 6393.1, -245.425, 690.299, 0, 'Time-Lost Proto Drake'),(32491, 22, 6379.5, -288.252, 674.026, 0, 'Time-Lost Proto Drake'),(32491, 23, 6362.43, -325.35, 649.373, 0, 'Time-Lost Proto Drake'),(32491, 24, 6349.75, -348.877, 626.786, 0, 'Time-Lost Proto Drake'),(32491, 25, 6338.78, -371.539, 602.488, 0, 'Time-Lost Proto Drake'),(32491, 26, 6321.89, -409.023, 564.587, 0, 'Time-Lost Proto Drake'),(32491, 27, 6306.89, -450.056, 535.427, 0, 'Time-Lost Proto Drake'),(32491, 28, 6295.58, -479.237, 519.789, 0, 'Time-Lost Proto Drake'),(32491, 29, 6275.4, -531.626, 497.103, 0, 'Time-Lost Proto Drake'),(32491, 30, 6262, -575.154, 468.779, 0, 'Time-Lost Proto Drake'),(32491, 31, 6243.06, -607.821, 447.979, 0, 'Time-Lost Proto Drake'),(32491, 32, 6204.34, -649.963, 428.429, 0, 'Time-Lost Proto Drake'),(32491, 33, 6157.96, -679.508, 418.208, 0, 'Time-Lost Proto Drake'),(32491, 34, 6116.93, -715.809, 413.25, 0, 'Time-Lost Proto Drake'),(32491, 35, 6101.08, -754.939, 408.596, 0, 'Time-Lost Proto Drake'),(32491, 36, 6100.15, -789.918, 408.566, 0, 'Time-Lost Proto Drake'),
(32491, 37, 6097.92, -859.818, 411.412, 0, 'Time-Lost Proto Drake'),(32491, 38, 6097.33, -891.273, 413.89, 0, 'Time-Lost Proto Drake'),(32491, 39, 6103.5, -938.345, 419.064, 0, 'Time-Lost Proto Drake'),(32491, 40, 6126.89, -1004.07, 423.88, 0, 'Time-Lost Proto Drake'),(32491, 41, 6140.69, -1031, 425.452, 0, 'Time-Lost Proto Drake'),(32491, 42, 6174.43, -1081.3, 428.453, 0, 'Time-Lost Proto Drake'),(32491, 43, 6220.59, -1126.96, 433.835, 0, 'Time-Lost Proto Drake'),(32491, 44, 6248.67, -1147.08, 439.383, 0, 'Time-Lost Proto Drake'),(32491, 45, 6277.74, -1165.61, 445.361, 0, 'Time-Lost Proto Drake'),(32491, 46, 6329.04, -1194.79, 452.343, 0, 'Time-Lost Proto Drake'),(32491, 47, 6383.55, -1223.81, 453.9, 0, 'Time-Lost Proto Drake'),(32491, 48, 6425.34, -1245.53, 465.955, 0, 'Time-Lost Proto Drake'),(32491, 49, 6454.6, -1260.45, 490.074, 0, 'Time-Lost Proto Drake'),(32491, 50, 6497.36, -1263.91, 528.572, 0, 'Time-Lost Proto Drake'),(32491, 51, 6513.02, -1262.49, 542.487, 0, 'Time-Lost Proto Drake'),(32491, 52, 6564.84, -1243.36, 592.473, 0, 'Time-Lost Proto Drake'),(32491, 53, 6580.48, -1235.79, 608.01, 0, 'Time-Lost Proto Drake'),(32491, 54, 6624.6, -1214.44, 690.166, 0, 'Time-Lost Proto Drake'),(32491, 55, 6637.92, -1207.87, 740.015, 0, 'Time-Lost Proto Drake'),(32491, 56, 6651.86, -1200.79, 759.156, 0, 'Time-Lost Proto Drake'),(32491, 57, 6691.1, -1181.43, 802.911, 0, 'Time-Lost Proto Drake'),(32491, 58, 6722.14, -1167.74, 811.505, 0, 'Time-Lost Proto Drake'),(32491, 59, 6753.37, -1154.48, 820.091, 0, 'Time-Lost Proto Drake'),(32491, 60, 6818.83, -1134.05, 834.004, 0, 'Time-Lost Proto Drake'),(32491, 61, 6851.54, -1124.01, 847.969, 0, 'Time-Lost Proto Drake'),(32491, 62, 6893.41, -1109.47, 862.142, 0, 'Time-Lost Proto Drake'),(32491, 63, 6957.6, -1096.39, 900.375, 0, 'Time-Lost Proto Drake'),(32491, 64, 6989.05, -1089.06, 913.865, 0, 'Time-Lost Proto Drake'),(32491, 65, 7053.54, -1074.56, 936.887, 0, 'Time-Lost Proto Drake'),(32491, 66, 7099.48, -1066.68, 951.718, 0, 'Time-Lost Proto Drake'),(32491, 67, 7154.79, -1069.21, 957.22, 0, 'Time-Lost Proto Drake'),(32491, 68, 7165.23, -1070.09, 957.559, 0, 'Time-Lost Proto Drake'),(32491, 69, 7200.19, -1071.31, 958.613, 0, 'Time-Lost Proto Drake'),(32491, 70, 7268.91, -1082.33, 960.48, 0, 'Time-Lost Proto Drake'),(32491, 71, 7295.74, -1106.03, 960.943, 0, 'Time-Lost Proto Drake'),(32491, 72, 7324.25, -1142.94, 962.878, 0, 'Time-Lost Proto Drake'),
(32491, 73, 7354.7, -1204.13, 968.725, 0, 'Time-Lost Proto Drake'),(32491, 74, 7366.07, -1236.71, 974.457, 0, 'Time-Lost Proto Drake'),(32491, 75, 7386.64, -1273.81, 982.442, 0, 'Time-Lost Proto Drake'),(32491, 76, 7407.8, -1301.28, 992.554, 0, 'Time-Lost Proto Drake'),(32491, 77, 7447.9, -1354.87, 1012.99, 0, 'Time-Lost Proto Drake'),(32491, 78, 7468.28, -1381.03, 1024.16, 0, 'Time-Lost Proto Drake'),(32491, 79, 7509.35, -1431.2, 1050.55, 0, 'Time-Lost Proto Drake'),(32491, 80, 7530.09, -1455.15, 1065.37, 0, 'Time-Lost Proto Drake'),(32491, 81, 7550.81, -1477.1, 1083.09, 0, 'Time-Lost Proto Drake'),(32491, 82, 7587.11, -1515.16, 1115.62, 0, 'Time-Lost Proto Drake'),(32491, 83, 7619.98, -1547.88, 1158.15, 0, 'Time-Lost Proto Drake'),(32491, 84, 7637.2, -1565.58, 1182.96, 0, 'Time-Lost Proto Drake'),(32491, 85, 7668.3, -1601.09, 1231.33, 0, 'Time-Lost Proto Drake'),(32491, 86, 7684.51, -1623.2, 1253.07, 0, 'Time-Lost Proto Drake'),(32491, 87, 7717.26, -1672.47, 1288.12, 0, 'Time-Lost Proto Drake'),(32491, 88, 7717.26, -1672.47, 1288.12, 0, 'Time-Lost Proto Drake'),(32491, 89, 7763.04, -1693.93, 1304.13, 0, 'Time-Lost Proto Drake'),(32491, 90, 7781.53, -1695.46, 1306.18, 0, 'Time-Lost Proto Drake'),(32491, 91, 7846.44, -1692.33, 1305.35, 0, 'Time-Lost Proto Drake'),(32491, 92, 7877.58, -1683.96, 1300.57, 0, 'Time-Lost Proto Drake'),(32491, 93, 7898.07, -1675.74, 1293.12, 0, 'Time-Lost Proto Drake'),(32491, 94, 7956.83, -1649.3, 1265.91, 0, 'Time-Lost Proto Drake'),(32491, 95, 7984.1, -1634.5, 1249.7, 0, 'Time-Lost Proto Drake'),(32491, 96, 8040.35, -1606.79, 1218.68, 0, 'Time-Lost Proto Drake'),(32491, 97, 8069.13, -1592.03, 1205.37, 0, 'Time-Lost Proto Drake'),(32491, 98, 8096.88, -1575.05, 1192.46, 0, 'Time-Lost Proto Drake'),(32491, 99, 8149.59, -1538.56, 1164.41, 0, 'Time-Lost Proto Drake'),(32491, 100, 8175.64, -1520.51, 1149.55, 0, 'Time-Lost Proto Drake'),(32491, 101, 8228.32, -1484.3, 1121.05, 0, 'Time-Lost Proto Drake'),(32491, 102, 8274.75, -1451.98, 1096.24, 0, 'Time-Lost Proto Drake'),(32491, 103, 8291.93, -1410.78, 1085.82, 0, 'Time-Lost Proto Drake'),(32491, 104, 8338.53, -1381.17, 1074.43, 0, 'Time-Lost Proto Drake'),(32491, 105, 8357.98, -1378.58, 1071.42, 0, 'Time-Lost Proto Drake'),(32491, 106, 8406.78, -1427.2, 1059.02, 0, 'Time-Lost Proto Drake'),(32491, 107, 8431.29, -1451.03, 1051.53, 0, 'Time-Lost Proto Drake'),(32491, 108, 8455.86, -1474.61, 1043.48, 0, 'Time-Lost Proto Drake'),
(32491, 109, 8477.97, -1500.25, 1034.6, 0, 'Time-Lost Proto Drake'),(32491, 110, 8522.47, -1551.4, 1013.16, 0, 'Time-Lost Proto Drake'),(32491, 111, 8545, -1567.2, 1008.45, 0, 'Time-Lost Proto Drake'),(32491, 112, 8577.06, -1600.74, 1004.32, 0, 'Time-Lost Proto Drake'),(32491, 113, 8603.9, -1623.21, 1003.84, 0, 'Time-Lost Proto Drake'),(32491, 114, 8655.25, -1663.61, 1003.85, 0, 'Time-Lost Proto Drake'),(32491, 115, 8685.18, -1681.71, 1002.99, 0, 'Time-Lost Proto Drake'),(32491, 116, 8738.88, -1704.03, 1000.54, 0, 'Time-Lost Proto Drake'),(32491, 117, 8772.4, -1714.07, 999.761, 0, 'Time-Lost Proto Drake'),(32491, 118, 8806.42, -1722.27, 1000.34, 0, 'Time-Lost Proto Drake'),(32491, 119, 8879.98, -1731.72, 1005.71, 0, 'Time-Lost Proto Drake'),(32491, 120, 8917.96, -1732.64, 1023.34, 0, 'Time-Lost Proto Drake'),(32491, 121, 8950.7, -1730.39, 1056.4, 0, 'Time-Lost Proto Drake'),(32491, 122, 8999.59, -1714.7, 1094.37, 0, 'Time-Lost Proto Drake'),(32491, 123, 9024.74, -1704.68, 1121.59, 0, 'Time-Lost Proto Drake'),(32491, 124, 9048.7, -1682.13, 1154.6, 0, 'Time-Lost Proto Drake'),(32491, 125, 9067.47, -1659.22, 1184.3, 0, 'Time-Lost Proto Drake'),(32491, 126, 9075.25, -1637.6, 1207.37, 0, 'Time-Lost Proto Drake'),(32491, 127, 9076.85, -1622.84, 1222.22, 0, 'Time-Lost Proto Drake'),(32491, 128, 9078.82, -1581.17, 1218.45, 0, 'Time-Lost Proto Drake'),(32491, 129, 9072.33, -1532.85, 1202.52, 0, 'Time-Lost Proto Drake'),(32491, 130, 9062.77, -1499.62, 1183.33, 0, 'Time-Lost Proto Drake'),(32491, 131, 9053.39, -1476.67, 1167.93, 0, 'Time-Lost Proto Drake'),(32491, 132, 9028.34, -1429.55, 1141.71, 0, 'Time-Lost Proto Drake'),(32491, 133, 9011.75, -1401.13, 1129.83, 0, 'Time-Lost Proto Drake'),(32491, 134, 8994.85, -1372.5, 1118.88, 0, 'Time-Lost Proto Drake'),(32491, 135, 8962.01, -1313.04, 1102.53, 0, 'Time-Lost Proto Drake'),(32491, 136, 8948.24, -1281.31, 1097.32, 0, 'Time-Lost Proto Drake'),(32491, 137, 8936.49, -1248.62, 1093.09, 0, 'Time-Lost Proto Drake'),(32491, 138, 8913.79, -1182.92, 1084.87, 0, 'Time-Lost Proto Drake'),(32491, 139, 8902.18, -1150.22, 1080.41, 0, 'Time-Lost Proto Drake'),(32491, 140, 8889.3, -1118.25, 1074.38, 0, 'Time-Lost Proto Drake'),(32491, 141, 8862.23, -1056.13, 1056.99, 0, 'Time-Lost Proto Drake'),(32491, 142, 8846.6, -1025.66, 1049.8, 0, 'Time-Lost Proto Drake'),(32491, 143, 8832.04, -994.597, 1042.85, 0, 'Time-Lost Proto Drake'),(32491, 144, 8808.22, -929.769, 1031.76, 0, 'Time-Lost Proto Drake'),(32491, 145, 8799.17, -896.237, 1027.53, 0, 'Time-Lost Proto Drake'),
(32491, 146, 8795.93, -869.827, 1024.97, 0, 'Time-Lost Proto Drake'),(32491, 147, 8793.27, -810.831, 1018.03, 0, 'Time-Lost Proto Drake'),(32491, 148, 8792.2, -785.868, 1012.41, 0, 'Time-Lost Proto Drake'),(32491, 149, 8782.54, -753.128, 1004.89, 0, 'Time-Lost Proto Drake'),(32491, 150, 8767.08, -722.565, 997.761, 0, 'Time-Lost Proto Drake'),(32491, 151, 8743.71, -658.167, 983.47, 0, 'Time-Lost Proto Drake'),(32491, 152, 8733.54, -625.462, 976.253, 0, 'Time-Lost Proto Drake'),(32491, 153, 8723.05, -592.93, 968.746, 0, 'Time-Lost Proto Drake'),(32491, 154, 8697.28, -529.857, 952.84, 0, 'Time-Lost Proto Drake'),(32491, 155, 8682.73, -499.347, 943.767, 0, 'Time-Lost Proto Drake'),(32491, 156, 8653.6, -439.174, 923.017, 0, 'Time-Lost Proto Drake'),(32491, 157, 8639.05, -409.12, 912.521, 0, 'Time-Lost Proto Drake'),(32491, 158, 8624.51, -379.066, 902.025, 0, 'Time-Lost Proto Drake'),(32491, 159, 8608.5, -349.7, 891.822, 0, 'Time-Lost Proto Drake'),(32491, 160, 8572.81, -292.825, 872.099, 0, 'Time-Lost Proto Drake'),(32491, 161, 8554.54, -268.499, 863.999, 0, 'Time-Lost Proto Drake'),(32491, 162, 8531.45, -244.556, 858.056, 0, 'Time-Lost Proto Drake'),(32491, 163, 8477.71, -199.896, 855.64, 0, 'Time-Lost Proto Drake'),(32491, 164, 8449.4, -179.482, 857.801, 0, 'Time-Lost Proto Drake'),(32491, 165, 8427.67, -165.955, 859.929, 0, 'Time-Lost Proto Drake'),(32491, 166, 8369.57, -142.067, 865.151, 0, 'Time-Lost Proto Drake'),(32491, 167, 8348.22, -136.499, 866.709, 0, 'Time-Lost Proto Drake'),(32491, 168, 8313.35, -135.584, 869.417, 0, 'Time-Lost Proto Drake'),(32491, 169, 8278.73, -134.74, 874.497, 0, 'Time-Lost Proto Drake'),(32491, 170, 8209.42, -132.09, 883.875, 0, 'Time-Lost Proto Drake'),(32491, 171, 8174.65, -130.431, 887.523, 0, 'Time-Lost Proto Drake'),(32491, 172, 8104.91, -131.052, 892.869, 0, 'Time-Lost Proto Drake'),(32491, 173, 8070.09, -133.489, 895.493, 0, 'Time-Lost Proto Drake'),(32491, 174, 8035.28, -135.939, 898.111, 0, 'Time-Lost Proto Drake'),(32491, 175, 7965.84, -143.094, 902.994, 0, 'Time-Lost Proto Drake'),(32491, 176, 7931.29, -147.699, 905.219, 0, 'Time-Lost Proto Drake'),(32491, 177, 7896.3, -147.547, 904.642, 0, 'Time-Lost Proto Drake'),(32491, 178, 7826.39, -146.512, 907.85, 0, 'Time-Lost Proto Drake'),(32491, 179, 7772.03, -139.953, 909.213, 0, 'Time-Lost Proto Drake'),(32491, 180, 7772.03, -139.953, 909.213, 0, 'Time-Lost Proto Drake'),(32491, 181, 7728.76, -130.667, 908.239, 0, 'Time-Lost Proto Drake'),(32491, 182, 7695.23, -122.319, 902.674, 0, 'Time-Lost Proto Drake'),(32491, 183, 7629.16, -105.502, 886.836, 0, 'Time-Lost Proto Drake'),
(32491, 184, 7596.14, -96.7168, 879.261, 0, 'Time-Lost Proto Drake'),(32491, 185, 7529.33, -82.0064, 864.78, 0, 'Time-Lost Proto Drake'),(32491, 186, 7494.9, -80.22, 858.805, 0, 'Time-Lost Proto Drake'),(32491, 187, 7425.43, -77.6433, 850.66, 0, 'Time-Lost Proto Drake'),(32491, 188, 7390.73, -78.7655, 846.404, 0, 'Time-Lost Proto Drake'),(32491, 189, 7342.27, -83.238, 840.942, 0, 'Time-Lost Proto Drake'),(32491, 190, 7308.4, -90.8958, 836.61, 0, 'Time-Lost Proto Drake'),(32491, 191, 7253.25, -107.745, 828.38, 0, 'Time-Lost Proto Drake'),(32491, 192, 7232.12, -117.173, 825.155, 0, 'Time-Lost Proto Drake'),(32491, 193, 7176.59, -153.975, 814.159, 0, 'Time-Lost Proto Drake'),(32491, 194, 7150.97, -177.367, 810.07, 0, 'Time-Lost Proto Drake'),(32491, 195, 7123.4, -216.146, 805.89, 0, 'Time-Lost Proto Drake'),(32491, 196, 7101.72, -259.97, 803.219, 0, 'Time-Lost Proto Drake'),(32491, 197, 7082.95, -317.595, 800.905, 0, 'Time-Lost Proto Drake'),(32491, 198, 7075.51, -351.755, 799.406, 0, 'Time-Lost Proto Drake'),(32491, 199, 7069.6, -413.003, 793.554, 0, 'Time-Lost Proto Drake'),(32491, 200, 7068.98, -447.804, 789.901, 0, 'Time-Lost Proto Drake'),(32491, 201, 7068.57, -494.162, 785.175, 0, 'Time-Lost Proto Drake'),(32491, 202, 7068.36, -563.799, 791.483, 0, 'Time-Lost Proto Drake'),(32491, 203, 7068.01, -617.454, 808.734, 0, 'Time-Lost Proto Drake'),(32491, 204, 7067.76, -637.643, 814.463, 0, 'Time-Lost Proto Drake'),(32491, 205, 7069.87, -673.033, 849.952, 0, 'Time-Lost Proto Drake'),(32491, 206, 7081.9, -709.672, 888.708, 0, 'Time-Lost Proto Drake'),(32491, 207, 7097.87, -727.207, 912.664, 0, 'Time-Lost Proto Drake'),(32491, 208, 7145.52, -761.609, 931.197, 0, 'Time-Lost Proto Drake'),(32491, 209, 7206.59, -787.404, 953.443, 0, 'Time-Lost Proto Drake'),(32491, 210, 7252.08, -808.621, 963.589, 0, 'Time-Lost Proto Drake'),(32491, 211, 7306.65, -820.093, 967.219, 0, 'Time-Lost Proto Drake'),(32491, 212, 7341.28, -824.97, 968.431, 0, 'Time-Lost Proto Drake'),(32491, 213, 7365.61, -827.774, 969.115, 0, 'Time-Lost Proto Drake'),(32491, 214, 7432.66, -847.542, 971.844, 0, 'Time-Lost Proto Drake'),(32491, 215, 7483.96, -862.629, 971.884, 0, 'Time-Lost Proto Drake'),(32491, 216, 7546.67, -893.277, 966.946, 0, 'Time-Lost Proto Drake'),(32491, 217, 7579.26, -913.575, 966.051, 0, 'Time-Lost Proto Drake'),(32491, 218, 7624.09, -966.939, 964.482, 0, 'Time-Lost Proto Drake'),(32491, 219, 7644.32, -1008.79, 962.966, 0, 'Time-Lost Proto Drake'),(32491, 220, 7650.79, -1051.31, 962.587, 0, 'Time-Lost Proto Drake'),
(32491, 221, 7640.22, -1109.61, 962.742, 0, 'Time-Lost Proto Drake'),(32491, 222, 7620.77, -1142.49, 960.763, 0, 'Time-Lost Proto Drake'),(32491, 223, 7592.68, -1169.73, 955.48, 0, 'Time-Lost Proto Drake'),(32491, 224, 7533.76, -1196.64, 948.685, 0, 'Time-Lost Proto Drake'),(32491, 225, 7488.92, -1202.66, 946.976, 0, 'Time-Lost Proto Drake'),(32491, 226, 7436.2, -1189.74, 946.755, 0, 'Time-Lost Proto Drake'),(32491, 227, 7395.15, -1161.05, 949.099, 0, 'Time-Lost Proto Drake'),(32491, 228, 7345, -1132.69, 954.872, 0, 'Time-Lost Proto Drake'),(32491, 229, 7345, -1132.69, 954.872, 0, 'Time-Lost Proto Drake'),(32491, 230, 7312.13, -1121.95, 960.181, 0, 'Time-Lost Proto Drake'),(32491, 231, 7253.76, -1103.48, 968.416, 0, 'Time-Lost Proto Drake'),(32491, 232, 7220.32, -1093.17, 968.69, 0, 'Time-Lost Proto Drake'),(32491, 233, 7186.87, -1082.86, 968.922, 0, 'Time-Lost Proto Drake'),(32491, 234, 7129.22, -1069.26, 964.391, 0, 'Time-Lost Proto Drake'),(32491, 235, 7090.34, -1063.23, 953.779, 0, 'Time-Lost Proto Drake'),(32491, 236, 7039.43, -1056.37, 928.862, 0, 'Time-Lost Proto Drake'),(32491, 237, 6999.57, -1035.32, 914.206, 0, 'Time-Lost Proto Drake'),(32491, 238, 6975.34, -1012.23, 909.603, 0, 'Time-Lost Proto Drake'),(32491, 239, 6940.44, -973.208, 911.185, 0, 'Time-Lost Proto Drake'),(32491, 240, 6922.11, -949.331, 915.136, 0, 'Time-Lost Proto Drake'),(32491, 241, 6904.15, -915.959, 921.478, 0, 'Time-Lost Proto Drake'),(32491, 242, 6893.51, -878.273, 927.01, 0, 'Time-Lost Proto Drake'),(32491, 243, 6895.81, -846.935, 911.615, 0, 'Time-Lost Proto Drake'),(32491, 244, 6902.51, -824.385, 890.863, 0, 'Time-Lost Proto Drake'),(32491, 245, 6913.04, -807.751, 872.785, 0, 'Time-Lost Proto Drake'),(32491, 246, 6951.24, -775.899, 840.297, 0, 'Time-Lost Proto Drake'),(32491, 247, 6975.51, -757.919, 822.626, 0, 'Time-Lost Proto Drake'),(32491, 248, 7018.21, -726.356, 801.611, 0, 'Time-Lost Proto Drake'),(32491, 249, 7054.51, -685.125, 787.627, 0, 'Time-Lost Proto Drake'),(32491, 250, 7071.25, -634.145, 778.284, 0, 'Time-Lost Proto Drake'),(32491, 251, 7072.41, -586.475, 775.93, 0, 'Time-Lost Proto Drake'),(32491, 252, 7071.22, -546.849, 774.473, 0, 'Time-Lost Proto Drake'),(32491, 253, 7070.4, -531.264, 769.844, 0, 'Time-Lost Proto Drake'),(32491, 254, 7067.16, -492.006, 755.897, 0, 'Time-Lost Proto Drake'),(32491, 255, 7064.75, -471.435, 758.728, 0, 'Time-Lost Proto Drake'),(32491, 256, 7063.02, -453.184, 766.105, 0, 'Time-Lost Proto Drake'),(32491, 257, 7062.67, -447.275, 769.832, 0, 'Time-Lost Proto Drake'),(32491, 258, 7062.24, -433.591, 780.834, 0, 'Time-Lost Proto Drake'),
(32491, 259, 7062.15, -425.009, 788.667, 0, 'Time-Lost Proto Drake'),(32491, 260, 7062.15, -425.009, 788.667, 0, 'Time-Lost Proto Drake'),(32491, 261, 7074.06, -366.064, 795.88, 0, 'Time-Lost Proto Drake'),(32491, 262, 7080.88, -322.35, 794.68, 0, 'Time-Lost Proto Drake');
DELETE FROM smart_scripts WHERE entryorguid IN(32630, 32491) AND source_type=0;

-- Azshir the Sleepless (6490)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=6490);
DELETE FROM creature WHERE id=6490;
INSERT INTO creature VALUES (NULL, 6490, 189, 1, 1, 0, 0, 1850.97, 1392.82, 20.4821, 3.13054, 300, 0, 0, 2664, 1870, 0, 0, 0, 0);

-- Silithid Invader (4131)
DELETE FROM creature WHERE id=4131;
INSERT INTO creature VALUES (21301, 4131, 1, 1, 1, 11143, 0, -6494.24, -3378.72, -85.3411, 1.39626, 300, 0, 0, 1279, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 4131, 1, 1, 1, 0, 0, -6514.4, -3304.3, -93.0929, 5.40444, 300, 0, 0, 1279, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 4131, 1, 1, 1, 0, 0, -6468.12, -3310.14, -102.609, 1.18685, 300, 0, 0, 1342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 4131, 1, 1, 1, 0, 0, -6483.64, -3273.42, -112.418, 1.84658, 300, 0, 0, 1279, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 4131, 1, 1, 1, 0, 0, -6450.52, -3290.35, -105.497, 3.6255, 300, 0, 0, 1342, 0, 0, 0, 0, 0);

-- Cult Researcher <Cult of the Damned> (32297)
-- Shadow Channeler <Cult of the Damned> (32262)
DELETE FROM creature WHERE id=32297 AND guid>121543;
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8152.03, 2127.42, 499.737, 1.55043, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8162.77, 2127.31, 499.737, 1.58577, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8174.66, 2127.65, 499.737, 1.57399, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8197.88, 2100.58, 499.737, 4.78627, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8188.31, 2100.54, 499.738, 4.7902, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8168.86, 2101.34, 499.738, 4.61741, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8158.42, 2102.61, 499.738, 3.2037, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8145.35, 2101, 499.738, 4.59385, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8132.95, 2101.11, 499.738, 4.67239, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8129.67, 2101.13, 499.738, 4.50745, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8199.02, 2154.63, 499.738, 3.82416, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8191.2, 2154.79, 499.738, 5.81122, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8194.62, 2148.53, 499.738, 1.40907, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8135.23, 2149.99, 499.738, 0.910338, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8138.53, 2157.42, 499.738, 5.13971, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8143.35, 2151.07, 499.738, 2.75603, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32297, 571, 1, 1, 26446, 1, 8162.91, 2134.36, 499.738, 4.74702, 300, 0, 0, 9740, 8636, 0, 0, 0, 0);
UPDATE creature SET spawntimesecs=80 WHERE id=32297;
UPDATE creature SET spawntimesecs=80 WHERE id=32262;

-- npc Earthcaller Halmgar (4842)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=4842);
DELETE FROM creature WHERE id=4842;
INSERT INTO creature VALUES(NULL, 4842, 47, 1, 1, 0, 0, 2118.58, 1695.32, 80.3316, 1.46786, 43200, 5, 0, 2200, 732, 1, 0, 0, 0);

-- npc Corpulent Horror (30696)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=30696 );
DELETE FROM creature WHERE id=30696;
INSERT INTO creature VALUES
(NULL,30696,571,1,1,0,0,6941.89,3507.54,705.745,4.29929,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6902,3452.85,702.71,1.70198,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6889.6,3485.44,697.351,5.78076,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6862.65,3508.82,696.041,4.56022,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6826.18,3506.14,690.275,4.65024,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6873.44,3447.73,700.427,0.301035,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6736.37,3426.33,683.014,1.2982,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6702.33,3423.9,680.377,3.80441,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6587.32,3313.74,668.99,2.523,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6548.17,3347.47,665.252,1.82478,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6508.72,3323.12,665.426,2.60939,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6509.06,3271.28,664.675,3.28798,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6531.15,3237.26,666.749,3.86525,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6557.18,3301.06,668.428,2.90548,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6546.37,3290.01,668.806,2.44839,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6480.82,3201.6,649.883,1.70282,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6411.71,3252.44,638.859,6.0469,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6406.84,3209.69,640.051,0.642571,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6443.02,3270.34,638.257,0.255374,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6498.82,3406.61,597.708,2.17723,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6537.2,3441.85,598.084,1.65494,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6515.74,3430.04,598.145,2.4741,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6691.52,3575.93,670.436,4.83501,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6478.42,3074.87,657.48,1.68791,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6434.69,3136.69,657.481,0.849888,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6445,3112.87,657.481,0.857745,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6468.84,3162.9,657.482,1.43658,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6439.89,3170.92,657.482,0.505101,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6656.16,3443.1,632.358,1.37264,300,0,0,1,0,0,0,0,0),
(NULL,30696,571,1,1,0,0,6686.38,3536.7,669.495,0.533053,300,0,0,1,0,0,0,0,0);

-- Kibli Killohertz
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=32444 );
DELETE FROM creature WHERE id=32444;
INSERT INTO creature VALUES(NULL, 32444, 571, 1, 1, 0, 0, 7623.05, 2060.18, 600.258, 0.010155, 300, 0, 0, 12600, 3994, 0, 0, 0, 0);

-- Fringe Engineer Tezzla (32430)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=32430);
DELETE FROM creature WHERE id=32430;
INSERT INTO creature VALUES(NULL, 32430, 571, 1, 1, 0, 0, 7897.96, 2057.59, 600.259, 3.10624, 300, 0, 0, 12600, 3994, 0, 0, 0, 0);

-- Wyrmcaller Vile (24029)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24029);
DELETE FROM creature WHERE id=24029;
INSERT INTO creature VALUES (NULL, 24029, 571, 1, 1, 0, 1, 2823.65, -3603.02, 245.679, 3.55425, 600, 0, 0, 9291, 3231, 0, 0, 0, 0);

-- Lightningcaller Soo-met (28107)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=28107);
DELETE FROM creature WHERE id=28107;
INSERT INTO creature VALUES (NULL, 28107, 571, 1, 1, 0, 0, 5040.47, 5502.82, -88.4046, 1.53287, 600, 0, 0, 117700, 3809, 0, 0, 0, 0);

-- Shaman Jakjek (28106)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=28106);
DELETE FROM creature WHERE id=28106;
INSERT INTO creature VALUES (NULL, 28106, 571, 1, 1, 0, 0, 4891.31, 5905.05, -40.6086, 3.66024, 300, 0, 0, 117700, 3809, 0, 0, 0, 0);

-- Captain Ellis (24910)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24910);
DELETE FROM creature WHERE id=24910;
INSERT INTO creature VALUES (142799, 24910, 594, 1, 1, 0, 1, 34.6962, -0.27625, 20.9157, 3.44936, 120, 0, 0, 1, 0, 0, 0, 0, 0);

-- Sergeant Kregga (31440)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=31440);
DELETE FROM creature WHERE id=31440;
INSERT INTO creature VALUES (NULL, 31440, 571, 1, 8, 0, 0, 5874.2, 1948.5, 516.1, 2.8, 300, 0, 0, 32000, 0, 0, 0, 0, 0);

-- Image of Commander Ameer <The Protectorate> (22919)
UPDATE creature_template SET npcflag=2, unit_flags=0 WHERE entry=22919;
DELETE FROM creature_queststarter WHERE id=22919;
INSERT INTO creature_queststarter VALUES(22919, 10981), (22919, 10975), (22919, 10977), (22919, 10976);
DELETE FROM creature_questender WHERE id=22919;
INSERT INTO creature_questender VALUES(22919, 10981), (22919, 10975), (22919, 10977), (22919, 10976), (22919, 10974), (22919, 10982);

-- Stoic Mammoth (30260)
-- Roaming Jormungar (30422)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30422, 30260));
DELETE FROM creature WHERE id IN(30422, 30260);
INSERT INTO creature VALUES (NULL, 30260, 571, 1, 4, 0, 0, 7143.71, -2251.43, 760.439, 1.29097, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7172.8, -2257.74, 759.628, 1.11662, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7218.29, -2214.53, 759.112, 3.43747, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7164.95, -2214.65, 758.563, 4.15611, 300, 0, 0, 11379, 0, 0, 0, 0, 0),
(NULL, 30260, 571, 1, 4, 0, 0, 7105.5, -2211.86, 759.098, 0.688573, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7110.67, -2133.14, 758.775, 5.04282, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7071.03, -2168.81, 760.815, 0.91791, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7028.51, -2077.67, 753.23, 5.25331, 300, 0, 0, 11379, 0, 0, 0, 0, 0),
(NULL, 30260, 571, 1, 4, 0, 0, 7106.01, -1988.13, 771.455, 4.35011, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7041.36, -1981.59, 776.354, 0.266033, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7133.88, -2039.53, 771.902, 3.57334, 300, 0, 0, 11379, 0, 0, 0, 0, 0),(NULL, 30260, 571, 1, 4, 0, 0, 7077.88, -2078.98, 759.218, 1.99469, 300, 0, 0, 11379, 0, 0, 0, 0, 0),
(NULL, 30422, 571, 1, 4, 0, 0, 7188.82, -2320.21, 757.813, -1.87154, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7082.68, -2112.98, 758.537, 3.60123, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7138.08, -2036.25, 771.858, 2.03839, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7065.27, -2070.9, 759.016, 0.790229, 300, 0, 0, 12175, 0, 0, 0, 0, 0),
(NULL, 30422, 571, 1, 4, 0, 0, 7142.27, -2214.55, 758.268, 5.21568, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7093.6, -2159.45, 758.662, 5.46951, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7050.49, -2148.12, 755.994, 5.28631, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7117.06, -2117.56, 760.043, 4.86823, 300, 0, 0, 12175, 0, 0, 0, 0, 0),
(NULL, 30422, 571, 1, 4, 0, 0, 7134.93, -2112.19, 761.723, 0.788161, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7123.43, -2085.57, 764.362, 5.11831, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7252.51, -2230.52, 760.183, 3.20023, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7157.35, -2262.32, 761.623, 0.494206, 300, 0, 0, 12175, 0, 0, 0, 0, 0),
(NULL, 30422, 571, 1, 4, 0, 0, 7194.98, -2195.57, 761.949, -0.387345, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7149.57, -2163.88, 761.147, 2.97457, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30422, 571, 1, 4, 0, 0, 7250.3, -2342.8, 751.68, 0.851782, 300, 0, 0, 12175, 0, 0, 0, 0, 0);

-- Dr. Whitherlimb (22062)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(22062));
DELETE FROM creature WHERE id IN(22062);
INSERT INTO creature VALUES(NULL, 22062, 530, 1, 1, 0, 0, 7188.17, -6417.2, 59.1657, 3.23113, 28800, 5, 0, 626, 0, 1, 0, 0, 0);

-- Stormforged Loreseeker (29843)
-- Stormforged Monitor (29862)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(29843, 29862));
DELETE FROM creature WHERE id IN(29843, 29862);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 6944.65, -23.6701, 806.669, 3.83558, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 6955.95, -3.21644, 808.618, 2.15984, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 6984.83, -0.527235, 810.066, 0.0349066, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 7007.96, -3.75587, 809.461, 1.40307, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 6896.48, 14.3666, 797.861, 0.575959, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 6880.27, 36.8712, 794.944, 0.374706, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 6990.75, 68.8908, 812.952, 0.396717, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29843, 571, 1, 1, 0, 1, 7010.22, 61.934, 812.907, 1.53589, 300, 0, 0, 11770, 3809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 29862, 571, 1, 1, 0, 0, 6903.44, 70.1409, 805.823, 4.82919, 600, 0, 0, 11770, 0, 0, 0, 0, 0);

-- Ethereum Jailor (23008)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(23008));
DELETE FROM creature WHERE id IN(23008);
INSERT INTO creature VALUES (NULL, 23008, 530, 1, 1, 0, 0, 3647.45, 1918.92, 118.17, 3.80525, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3600.99, 1898.07, 111.36, 4.56316, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3573.03, 1861.43, 108.895, 2.74103, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3669.82, 1815.83, 126.059, 6.17322, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3685.04, 1772.15, 130.008, 5.97294, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3718.62, 1728.71, 138.644, 5.75303, 600, 0, 0, 13285, 0, 0, 0, 0, 0),
(NULL, 23008, 530, 1, 1, 0, 0, 3770.45, 1704.41, 149.751, 4.0016, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3793.48, 1638.27, 135.625, 0.0691063, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3805.98, 1573.23, 118.196, 1.39643, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3835.62, 1614.66, 127.926, 1.56529, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 3894.74, 1649.2, 127.552, 4.65976, 600, 0, 0, 13285, 0, 0, 0, 0, 0),
(NULL, 23008, 530, 1, 1, 0, 0, 3930.28, 1647.93, 126.538, 0.685644, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4057.55, 1698.7, 136.879, 4.81684, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4097.41, 1710.19, 137.963, 0.756329, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4123.97, 1661.08, 126.587, 0.316505, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4162.44, 1671.21, 116.169, 1.18437, 600, 0, 0, 13285, 0, 0, 0, 0, 0),
(NULL, 23008, 530, 1, 1, 0, 0, 4196.29, 1697.37, 118.356, 1.66346, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4227.59, 1710.46, 121.084, 2.26429, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4221.32, 1766.66, 130.509, 2.1779, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4252.49, 1835.95, 143.106, 2.0758, 600, 0, 0, 13285, 0, 0, 0, 0, 0),(NULL, 23008, 530, 1, 1, 0, 0, 4285.64, 1900.79, 134.852, 2.0758, 600, 0, 0, 13285, 0, 0, 0, 0, 0);

-- High Admiral "Shelly" Jorrik (26081) with 2 Booty Bay Bruiser (4624)
DELETE FROM creature WHERE id=26081;
DELETE FROM creature WHERE id=4624 AND map=0 AND position_x > -7000;
INSERT INTO creature VALUES (NULL, 4624, 0, 1, 1, 0, 1, -6368.27, 1271.09, 7.18784, 3.75056, 300, 0, 0, 16960, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 4624, 0, 1, 1, 0, 1, -6369.53, 1272.53, 7.18784, 3.97047, 300, 0, 0, 16960, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 26081, 0, 1, 1, 0, 1, -6377.96, 1268.65, 7.1874, 5.39597, 300, 0, 0, 3073, 0, 0, 0, 0, 0);



-- ---------------------------------
-- MISSING GAMEOBJECT SPAWNS
-- ---------------------------------
-- shit fix shit shit, DK CHAIN - New Avalon Registry, Empty Cauldron
DELETE FROM gameobject WHERE id=190947 and guid<>66384;
INSERT INTO gameobject VALUES(NULL, 190947, 609, 1, 4, 1590.48, -5706.93, 124.193, 0.418879, 0, 0, 0, 1, 180, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190947, 609, 1, 4, 1590.48, -5706.93, 124.193, 0.418879, 0, 0, 0, 1, 180, 0, 1, 0);
DELETE FROM gameobject WHERE id=190937 and guid<>66377;
INSERT INTO gameobject VALUES(NULL, 190937, 609, 1, 4, 1783.84, -5877.65, 109.496, -2.58308, 0, 0, 0, 1, 180, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190937, 609, 1, 4, 1783.84, -5877.65, 109.496, -2.58308, 0, 0, 0, 1, 180, 0, 1, 0);

-- Horn Fragment (192081)
DELETE FROM gameobject WHERE id=192081;
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7935.95, -3236.77, 857.424, 0.958063, 0, 0, 0.46092, 0.887442, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7923.83, -3211.46, 857.913, 2.46603, 0, 0, 0.943492, 0.331395, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7886.72, -3194.93, 857.323, 2.74092, 0, 0, 0.98, 0.198999, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7859.57, -3192.8, 857.114, 3.05508, 0, 0, 0.999065, 0.0432429, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7834.13, -3203.41, 857.778, 3.67947, 0, 0, 0.964053, -0.265708, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7810.85, -3225.37, 858.131, 3.96614, 0, 0, 0.916212, -0.400694, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7801.85, -3253.95, 858.841, 4.75546, 0, 0, 0.691716, -0.722169, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7812.31, -3286.12, 860.228, 4.85364, 0, 0, 0.655446, -0.755242, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7831.15, -3305.42, 860.812, 5.48981, 0, 0, 0.386365, -0.922346, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7850.69, -3319.63, 859.898, 5.76863, 0, 0, 0.254449, -0.967086, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7876.24, -3325.45, 857.828, 6.25557, 0, 0, 0.0138072, -0.999905, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7905.56, -3320.09, 857.02, 0.427919, 0, 0, 0.212331, 0.977198, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7923.6, -3307.25, 857.07, 0.812764, 0, 0, 0.395289, 0.918557, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7939.08, -3282.58, 857.487, 1.38611, 0, 0, 0.63889, 0.769298, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7904.75, -3264.32, 851.442, 1.73168, 0, 0, 0.76164, 0.648001, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7852.99, -3255.5, 851.472, 3.00795, 0, 0, 0.997768, 0.0667716, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7873.97, -3230.72, 849.804, 0.286546, 0, 0, 0.142783, 0.989754, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 192081, 571, 1, 4, 7883.11, -3288.4, 853.77, 2.46995, 0, 0, 0.94414, 0.329545, 120, 100, 1, 0);

-- Draconic for Dummies (180665)
-- Draconic for Dummies (180666)
-- Draconic for Dummies (180667)
DELETE FROM gameobject WHERE id IN(180665, 180666, 180667);
INSERT INTO gameobject VALUES (NULL, 180665, 0, 1, 1, -8358.35, 383.357, 124.479, 6.16137, 0, 0, 0.0608701, -0.998146, 600, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 180666, 0, 1, 1, 1628.82, 130.74, -60.9707, 0.120107, 0, 0, 0.0600174, 0.998197, 600, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 180667, 469, 1, 1, -7526.18, -924.875, 458.823, 0.444532, 0, 0, 0.22044, 0.9754, 600, 100, 1, 0);

-- Darnassus, missing anvil
DELETE FROM gameobject WHERE id IN(178685) AND (position_x BETWEEN 9904 AND 9906) AND (position_y BETWEEN 2309 AND 2311);
INSERT INTO gameobject VALUES (NULL, 178685, 1, 1, 1, 9905.612, 2310.472, 1330.7891, 1.5705, 0, 0, 0, 0, 900, 100, 1, 0);

-- The Alliance of Lordaeron (175746), missing spawn in silvermoon
DELETE FROM gameobject WHERE id=175746 AND map=530;
INSERT INTO gameobject VALUES (NULL, 175746, 530, 1, 1, 9556.93, -7210.03, 27.1505, 5.37153, 0, 0, 0.440206, -0.897897, 300, 0, 1, 0);

-- Everfrost Shard (192187)
DELETE FROM gameobject WHERE id=192187;
INSERT INTO gameobject VALUES (NULL, 192187, 571, 1, 65535, 7307.46, -2072.95, 762.321, 2.53279, 0, 0, 0.954027, 0.299722, 120, 100, 1, 0),(NULL, 192187, 571, 1, 65535, 7288.73, -2071.07, 761.679, 0.451481, 0, 0, 0.223828, 0.974629, 120, 100, 1, 0),(NULL, 192187, 571, 1, 65535, 7287.05, -2045.9, 761.81, 6.21238, 0, 0, 0.0353953, -0.999373, 120, 100, 1, 0),
(NULL, 192187, 571, 1, 65535, 7310.52, -2022.37, 763.365, 4.95181, 0, 0, 0.6176, -0.786492, 120, 100, 1, 0),(NULL, 192187, 571, 1, 65535, 7337.8, -2029.78, 763.321, 3.91509, 0, 0, 0.92614, -0.377179, 120, 100, 1, 0),(NULL, 192187, 571, 1, 65535, 7344.77, -2048.75, 764.329, 3.22001, 0, 0, 0.999231, -0.0391986, 120, 100, 1, 0);

-- Harvested Blight Crystal (190720)
DELETE FROM gameobject WHERE id=190720;
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6261.99, -1975.28, 417.612, 0.703654, 0, 0, 0.344613, 0.938745, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6239.11, -2082.16, 417.515, 5.56134, 0, 0, 0.353138, -0.935571, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6097.63, -2086.47, 417.622, 3.75493, 0, 0, 0.953345, -0.301884, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6137.17, -1932.44, 417.639, 1.9328, 0, 0, 0.822845, 0.568265, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6207.94, -2097.64, 417.594, 5.28645, 0, 0, 0.477992, -0.878364, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6181.22, -2073.81, 417.548, 0.000716925, 0, 0, 0.000358463, 1, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6088.22, -2108, 422.876, 5.32964, 0, 0, 0.458914, -0.888481, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190720, 571, 1, 1, 6166.79, -1946.3, 417.548, 3.26012, 0, 0, 0.998244, -0.0592289, 120, 100, 1, 0);

-- Splintered Bone Chunk (188441)
DELETE FROM gameobject WHERE id=188441;
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4574.53, 737.473, 93.1492, 4.11647, 0, 0, 0.883535, -0.468364, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4592.46, 751.803, 95.5605, 0.432947, 0, 0, 0.214787, 0.976661, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4614.43, 661.181, 99.1374, 4.82726, 0, 0, 0.66535, -0.746531, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4594.89, 660.31, 97.3038, 4.53666, 0, 0, 0.766429, -0.642329, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4581.01, 646.25, 96.2041, 0.1777, 0, 0, 0.0887331, 0.996055, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4619.31, 647.6, 100.316, 0.240532, 0, 0, 0.119976, 0.992777, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4644.63, 641.427, 107.293, 1.12018, 0, 0, 0.531262, 0.847207, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4580.6, 269.071, 94.0463, 4.8461, 0, 0, 0.658288, -0.752766, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4563.57, 256.655, 90.39, 4.81076, 0, 0, 0.671486, -0.741017, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4531.09, 227.589, 91.8334, 4.38665, 0, 0, 0.812407, -0.583091, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4524.34, 212.839, 91.674, 0.919109, 0, 0, 0.443549, 0.89625, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4487.72, 113.749, 88.7867, 4.46518, 0, 0, 0.788891, -0.614533, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4502.46, 95.6058, 89.268, 3.14179, 0, 0, 1, -9.86298E-5, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4509.16, 62.8467, 86.6415, 3.51486, 0, 0, 0.982634, -0.185552, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4491.48, 82.59, 89.7548, 0.153351, 0, 0, 0.0766004, 0.997062, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4469.81, 128.57, 88.9256, 1.13903, 0, 0, 0.539224, 0.842163, 120, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 188441, 571, 1, 1, 4602.43, 751.855, 95.8966, 1.41784, 0, 0, 0.651014, 0.759065, 120, 100, 1, 0);

-- Meeting Stone Vault of Archavon (195013)
UPDATE gameobject_template SET data2=4603 WHERE entry=195013;
DELETE FROM gameobject WHERE id=195013;
INSERT INTO gameobject VALUES(NULL, 195013, 571, 1, 1, 5476.24, 2858.14, 418.67, 3.14, 0, 0, 0.00391458, 0.999992, 300, 0, 1, 0);

-- Undercity mailboxes (177044)
DELETE FROM gameobject WHERE id=177044;
INSERT INTO gameobject VALUES(NULL, 177044, 0, 1, 1, 1633.03, 219.279, -43, 1.082, 0, 0, 0.514993, 0.857194, 600, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 177044, 0, 1, 1, 1554.85, 235.406, -43.1025, 3.3789, 0, 0, 0.992969, -0.118375, 300, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 177044, 0, 1, 1, 1559.05, 191.55, -62.1819, 1.13266, 0, 0, 0.536539, 0.843876, 300, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 177044, 0, 1, 1, 1631.2, 191.274, -62.1815, 2.06727, 0, 0, 0.859165, 0.511699, 300, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 177044, 0, 1, 1, 1631.97, 288.06, -62.1824, 4.14857, 0, 0, 0.875905, -0.482484, 300, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 177044, 0, 1, 1, 1560.58, 289.393, -62.1814, 5.07141, 0, 0, 0.569492, -0.821997, 300, 0, 1, 0);

-- Scarab Coffer (180691)
-- Large Scarab Coffer (180690)
DELETE FROM gameobject WHERE guid IN (243000, 243000+1, 243000+2, 243000+3, 243000+4, 243000+5, 243000+6, 243000+7, 243000+8, 243000+9, 243000+10, 243000+11);
INSERT INTO gameobject (guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES 
(243000, 180690, 531, 1, 1, -8130.227, 1136.687, -88.93, 0.857524, 0, 0, 0, 0, 10800, 100, 1),
(243000+1, 180690, 531, 1, 1, -8588.386, 1300.252, -68.730408, 2.097758, 0, 0, 0, 0, 10800, 100, 1),
(243000+2, 180690, 531, 1, 1, -8685.795, 1598.988, -87.498146, 4.515244, 0, 0, 0, 0, 10800, 100, 1),
(243000+3, 180690, 531, 1, 1, -8878.372, 1366.834, -98.920456, 1.169440, 0, 0, 0, 0, 10800, 100, 1),
(243000+4, 180690, 531, 1, 1, -9094.497, 1515.304, -98.369436, 5.289001, 0, 0, 0, 0, 10800, 100, 1),
(243000+5, 180690, 531, 1, 1, -9205.269, 1489.207, -94.166359, 0.800427, 0, 0, 0, 0, 10800, 100, 1),
(243000+6, 180690, 531, 1, 1, -9239.013, 1569.972, -77.098450, 5.92124, 0, 0, 0, 0, 10800, 100, 1),
(243000+7, 180690, 531, 1, 1, -9162.003, 1584.0142, -79.262154, 2.819869, 0, 0, 0, 0, 10800, 100, 1),
(243000+8, 180690, 531, 1, 1, -9203.490, 1967.797, -51.939789, 1.508256, 0, 0, 0, 0, 10800, 100, 1),
(243000+9, 180690, 531, 1, 1, -8923.832, 1826.973, -20.905273, 1.040937, 0, 0, 0, 0, 10800, 100, 1),
(243000+10, 180690, 531, 1, 1, -8561.847, 1988.220, -3.113131, 4.493683, 0, 0, 0, 0, 10800, 100, 1),
(243000+11, 180690, 531, 1, 1, -8507.548, 2018.031, 104.526520, 3.540616, 0, 0, 0, 0, 10800, 100, 1);
DELETE FROM gameobject WHERE guid IN (243050, 243050+1, 243050+2, 243050+3, 243050+4, 243050+5, 243050+6, 243050+7, 243050+8);
INSERT INTO gameobject (guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES 
(243050, 180691, 509, 1, 1, -8698.908, 1560.894, 32.013947, 2.385138, 0, 0, 0, 0, 10800, 100, 1),
(243050+1, 180691, 509, 1, 1, -9117.897, 1511.653, 21.414448, 1.780370, 0, 0, 0, 0, 10800, 100, 1),
(243050+2, 180691, 509, 1, 1, -8775.216, 2003.485, 21.403147, 3.060552, 0, 0, 0, 0, 10800, 100, 1),
(243050+3, 180691, 509, 1, 1, -9009.267, 1989.094, 33.044173, 0.115302, 0, 0, 0, 0, 10800, 100, 1),
(243050+4, 180691, 509, 1, 1, -9130.286, 2188.145, 25.825098, 0.872438, 0, 0, 0, 0, 10800, 100, 1),
(243050+5, 180691, 509, 1, 1, -9544.468, 2010.560, 105.250053, 0.864585, 0, 0, 0, 0, 10800, 100, 1),
(243050+6, 180691, 509, 1, 1, -9701.868, 1619.060, 27.191568, 0.042328, 0, 0, 0, 0, 10800, 100, 1),
(243050+7, 180691, 509, 1, 1, -9552.093, 1567.647, 23.153004, 2.197394, 0, 0, 0, 0, 10800, 100, 1),
(243050+8, 180691, 509, 1, 1, -9335.515, 1214.496, 21.385408, 0.709061, 0, 0, 0, 0, 10800, 100, 1);
-- Pool template for Large Scarab Coffers and Scarab Coffers
DELETE FROM pool_template WHERE entry IN (1161, 1162);
INSERT INTO pool_template (entry, max_limit, description) VALUES
(1161, 5, 'Large Scarab Coffers'),
(1162, 7, 'Scarab Coffers');
-- Pool_gameobject pool for Large Scarab Coffers
DELETE FROM pool_gameobject WHERE guid IN (243000, 243000+1, 243000+2, 243000+3, 243000+4, 243000+5, 243000+6, 243000+7, 243000+8, 243000+9, 243000+10, 243000+11);
INSERT INTO pool_gameobject (guid, pool_entry, chance, description) VALUES
(243000, 1161, 0, 'Large Scarab Coffers - Spawn 1'),
(243000+1, 1161, 0, 'Large Scarab Coffers - Spawn 2'),
(243000+2, 1161, 0, 'Large Scarab Coffers - Spawn 3'),
(243000+3, 1161, 0, 'Large Scarab Coffers - Spawn 4'),
(243000+4, 1161, 0, 'Large Scarab Coffers - Spawn 5'),
(243000+5, 1161, 0, 'Large Scarab Coffers - Spawn 6'),
(243000+6, 1161, 0, 'Large Scarab Coffers - Spawn 7'),
(243000+7, 1161, 0, 'Large Scarab Coffers - Spawn 8'),
(243000+8, 1161, 0, 'Large Scarab Coffers - Spawn 9'),
(243000+9, 1161, 0, 'Large Scarab Coffers - Spawn 10'),
(243000+10, 1161, 0, 'Large Scarab Coffers - Spawn 11'),
(243000+11, 1161, 0, 'Large Scarab Coffers - Spawn 12');
-- Pool_gameobject pool for Large Scarab Coffers
DELETE FROM pool_gameobject WHERE guid IN (243050, 243050+1, 243050+2, 243050+3, 243050+4, 243050+5, 243050+6, 243050+7, 243050+8, 243050+9, 243050+10, 243050+11);
INSERT INTO pool_gameobject (guid, pool_entry, chance, description) VALUES
(243050, 1162, 0, 'Scarab Coffers - Spawn 1'),
(243050+1, 1162, 0, 'Scarab Coffers - Spawn 2'),
(243050+2, 1162, 0, 'Scarab Coffers - Spawn 3'),
(243050+3, 1162, 0, 'Scarab Coffers - Spawn 4'),
(243050+4, 1162, 0, 'Scarab Coffers - Spawn 5'),
(243050+5, 1162, 0, 'Scarab Coffers - Spawn 6'),
(243050+6, 1162, 0, 'Scarab Coffers - Spawn 7'),
(243050+7, 1162, 0, 'Scarab Coffers - Spawn 8'),
(243050+8, 1162, 0, 'Scarab Coffers - Spawn 9');


-- ---------------------------------------
-- Icecrown Alliance / Horde platforms
-- ---------------------------------------
-- Karen No <Bombadier> (31648)
-- Johnny Yes (32523)
-- Willy Maybe (32524)
DELETE FROM creature WHERE id IN(31648, 32523, 32524);
INSERT INTO creature VALUES (NULL, 31648, 571, 1, 1, 0, 0, 7628.78, 2056.04, 600.261, 4.82234, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32523, 571, 1, 1, 0, 1, 7615.79, 2055.69, 600.261, 0.549766, 300, 0, 0, 16026, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32524, 571, 1, 1, 0, 1, 7618.79, 2051.76, 600.261, 0.820729, 300, 0, 0, 16026, 0, 0, 0, 0, 0);

DELETE FROM gameobject WHERE id IN(193579,193582,193696,193697,193698,193699,193700,193701,193702,193703,193704,193705,193706,193707,193708,193709,193710,193711,193712,193713,193714,
193715,193716,193717,193718,193719,193720,193721,193722,193723,193724,193725,193726,193727,193728,193729,193730,193731,193732,193733,193734,193735,193736,193737,193607,
193738,193739,193740,193741,193742,193743,193744,193745,193746,193747,193748,193749,193750,193751,193752,193753,193754,193755,193756,193757,193758,193759,193760,193761,193762,193677,
193763,193764,193765,193766,193796,193982,193984,193691,193693);
INSERT INTO gameobject VALUES(NULL, 193984, 571, 1, 1, 7647.47, 2055.55, 599.399, -0.279252, 0, 0, -0.139173, 0.990268, 300, 0, 1, 0),(NULL, 193984, 571, 1, 1, 7647.42, 2065.23, 599.308, 0.279252, 0, 0, 0.139173, 0.990268, 300, 0, 1, 0),(NULL, 193984, 571, 1, 1, 7609.86, 2055.53, 599.494, -2.86234, 0, 0, -0.990268, 0.139173, 300, 0, 1, 0),(NULL, 193984, 571, 1, 1, 7610.18, 2065.31, 599.426, 2.87979, 0, 0, 0.991445, 0.130528, 300, 0, 1, 0),(NULL, 193579, 571, 1, 1, 7629.04, 2060.18, 599.815, -0.698131, 0, 0, -0.34202, 0.939693, 300, 0, 1, 0),(NULL, 193982, 571, 1, 1, 7628.73, 2060.22, 599.815, 0, 0, 0, 0, 1, 300, 0, 1, 0),(NULL, 193582, 571, 1, 1, 7628.51, 2059.91, 600.259, -1.41372, 0, 0, -0.649449, 0.760405, 300, 100, 1, 0),(NULL, 193796, 571, 1, 1, 7628.96, 2060.49, 586.427, -2.57972, 0, 0, -0.960796, 0.277255, 180, 255, 1, 0),(NULL, 193766, 571, 1, 1, 7637.41, 2072.36, 600.272, 1.24824, 0, 0, 0.584383, 0.811478, 180, 255, 1, 0),
(NULL, 193765, 571, 1, 1, 7635.56, 2046.72, 601.668, 1.26947, 0, 0, 0.592964, 0.805229, 180, 255, 1, 0),(NULL, 193764, 571, 1, 1, 7625.87, 2060.05, 604.27, 0.07854, 0, 0, 0.0392599, 0.999229, 180, 255, 1, 0),(NULL, 193763, 571, 1, 1, 7625.77, 2060.06, 600.887, 0.063894, 0, 0, 0.0319416, 0.99949, 180, 255, 1, 0),(NULL, 193762, 571, 1, 1, 7625.66, 2060.04, 604.195, -3.05428, 0, 0, -0.999047, 0.0436424, 180, 255, 1, 0),(NULL, 193761, 571, 1, 1, 7629.73, 2062.71, 600.258, 2.95833, 0, 0, 0.995805, 0.0915032, 180, 255, 1, 0),(NULL, 193760, 571, 1, 1, 7630.54, 2062.55, 600.248, -2.0333, 0, 0, -0.85035, 0.526218, 180, 255, 1, 0),(NULL, 193759, 571, 1, 1, 7629.98, 2061.77, 600.244, -2.93214, 0, 0, -0.994521, 0.104535, 180, 255, 1, 0),(NULL, 193758, 571, 1, 1, 7628.88, 2060.11, 600.495, -1.56207, 0, 0, -0.704015, 0.710185, 180, 255, 1, 0),(NULL, 193757, 571, 1, 1, 7628.6, 2060.2, 599.632, -1.66679, 0, 0, -0.740218, 0.672367, 180, 255, 1, 0),(NULL, 193756, 571, 1, 1, 7628.6, 2060.2, 598.534, -0.139624, 0, 0, -0.0697553, 0.997564, 180, 255, 1, 0),(NULL, 193755, 571, 1, 1, 7617.74, 2050.14, 600.669, -0.802851, 0, 0, -0.390731, 0.920505, 180, 255, 1, 0),(NULL, 193754, 571, 1, 1, 7630.59, 2060.2, 600.165, 0.017454, 0, 0, 0.00872689, 0.999962, 180, 255, 1, 0),(NULL, 193753, 571, 1, 1, 7615, 2053.27, 601.319, -1.44862, 0, 0, -0.662619, 0.748957, 180, 255, 1, 0),(NULL, 193752, 571, 1, 1, 7614.64, 2053.23, 601.321, -2.1293, 0, 0, -0.874619, 0.48481, 180, 255, 1, 0),(NULL, 193751, 571, 1, 1, 7614.74, 2052.61, 601.349, -0.759215, 0, 0, -0.370556, 0.92881, 180, 255, 1, 0),(NULL, 193750, 571, 1, 1, 7614.78, 2052.48, 600.129, 0.759219, 0, 0, 0.370558, 0.928809, 180, 255, 1, 0),(NULL, 193749, 571, 1, 1, 7621.34, 2045.82, 600.008, -0.418879, 0, 0, -0.207912, 0.978148, 180, 255, 1, 0),(NULL, 193748, 571, 1, 1, 7621.17, 2048.11, 600.035, -3.08918, 0, 0, -0.999657, 0.0262033, 180, 255, 1, 0),
(NULL, 193747, 571, 1, 1, 7619.74, 2047, 600.14, -2.15548, 0, 0, -0.88089, 0.47332, 180, 255, 1, 0),(NULL, 193746, 571, 1, 1, 7611.34, 2059.42, 600.23, 0.680679, 0, 0, 0.333807, 0.942641, 180, 255, 1, 0),(NULL, 193745, 571, 1, 1, 7611.44, 2061.46, 600.23, 2.07694, 0, 0, 0.861629, 0.507539, 180, 255, 1, 0),(NULL, 193744, 571, 1, 1, 7611.47, 2060.24, 601.099, 1.47483, 0, 0, 0.672377, 0.740209, 180, 255, 1, 0),(NULL, 193743, 571, 1, 1, 7629.51, 2043.4, 600.216, 2.30383, 0, 0, 0.913544, 0.406739, 180, 255, 1, 0),(NULL, 193742, 571, 1, 1, 7627.47, 2043.4, 600.216, -2.58308, 0, 0, -0.961261, 0.275641, 180, 255, 1, 0),(NULL, 193741, 571, 1, 1, 7628.47, 2043.35, 601.082, 3.09799, 0, 0, 0.999762, 0.0217996, 180, 255, 1, 0),(NULL, 193740, 571, 1, 1, 7620.1, 2074.38, 601.421, -0.270523, 0, 0, -0.134849, 0.990866, 180, 255, 1, 0),(NULL, 193739, 571, 1, 1, 7621.29, 2074.29, 601.419, 0.157079, 0, 0, 0.0784588, 0.996917, 180, 255, 1, 0),(NULL, 193738, 571, 1, 1, 7621.41, 2072.64, 601.433, 1.95477, 0, 0, 0.829038, 0.559192, 180, 255, 1, 0),(NULL, 193737, 571, 1, 1, 7620.95, 2073.95, 600.217, -1.02974, 0, 0, -0.492422, 0.870357, 180, 255, 1, 0),(NULL, 193736, 571, 1, 1, 7618.23, 2070.37, 600.557, -2.3911, 0, 0, -0.930417, 0.366502, 180, 255, 1, 0),(NULL, 193735, 571, 1, 1, 7613.96, 2068.4, 600.263, -0.872663, 0, 0, -0.422618, 0.906308, 180, 255, 1, 0),(NULL, 193734, 571, 1, 1, 7614.18, 2069.15, 600.269, 2.27762, 0, 0, 0.908136, 0.418675, 180, 255, 1, 0),(NULL, 193733, 571, 1, 1, 7614.12, 2068.63, 600.244, 2.86233, 0, 0, 0.990267, 0.139178, 180, 255, 1, 0),(NULL, 193732, 571, 1, 1, 7613.58, 2067.85, 600.361, 0.759044, 0, 0, 0.370477, 0.928842, 180, 255, 1, 0),(NULL, 193731, 571, 1, 1, 7613.7, 2066.87, 600.339, -0.549681, 0, 0, -0.271393, 0.962469, 180, 255, 1, 0),
(NULL, 193730, 571, 1, 1, 7613.63, 2067.52, 600.23, 2.80997, 0, 0, 0.986285, 0.165053, 180, 255, 1, 0),(NULL, 193729, 571, 1, 1, 7627.84, 2076.87, 600.247, -0.811576, 0, 0, -0.394743, 0.918792, 180, 255, 1, 0),(NULL, 193728, 571, 1, 1, 7628.88, 2076.95, 601.116, -0.017419, 0, 0, -0.00870939, 0.999962, 180, 255, 1, 0),(NULL, 193727, 571, 1, 1, 7629.88, 2076.93, 600.247, 0.584686, 0, 0, 0.288197, 0.957571, 180, 255, 1, 0),(NULL, 193726, 571, 1, 1, 7644.18, 2052.06, 600.239, 2.08567, 0, 0, 0.863836, 0.503773, 180, 255, 1, 0),(NULL, 193725, 571, 1, 1, 7644.38, 2052.46, 600.238, -1.68424, 0, 0, -0.746056, 0.665883, 180, 255, 1, 0),(NULL, 193724, 571, 1, 1, 7644.04, 2052.39, 600.233, 0.706858, 0, 0, 0.346117, 0.938191, 180, 255, 1, 0),(NULL, 193723, 571, 1, 1, 7636.35, 2046.3, 601.35, 0.575958, 0, 0, 0.284015, 0.95882, 180, 255, 1, 0),(NULL, 193722, 571, 1, 1, 7636.71, 2047.29, 601.309, 3.01067, 0, 0, 0.997858, 0.0654146, 180, 255, 1, 0),(NULL, 193721, 571, 1, 1, 7636.48, 2046.31, 600.13, 2.09439, 0, 0, 0.866024, 0.500002, 180, 255, 1, 0),(NULL, 193720, 571, 1, 1, 7639.41, 2049.98, 600.681, 0.750491, 0, 0, 0.366501, 0.930418, 180, 255, 1, 0),(NULL, 193719, 571, 1, 1, 7642.19, 2066.25, 601.511, -1.96349, 0, 0, -0.831468, 0.555572, 180, 255, 1, 0),(NULL, 193718, 571, 1, 1, 7641.95, 2051.51, 600.24, 2.92342, 0, 0, 0.994056, 0.10887, 180, 255, 1, 0),(NULL, 193717, 571, 1, 1, 7642.18, 2051.6, 600.461, -1.10828, 0, 0, -0.526212, 0.850353, 180, 255, 1, 0),(NULL, 193716, 571, 1, 1, 7642.39, 2051.59, 600.24, -2.64417, 0, 0, -0.96923, 0.246155, 180, 255, 1, 0),(NULL, 193715, 571, 1, 1, 7642.14, 2051.82, 600.262, -0.93375, 0, 0, -0.450098, 0.892979, 180, 255, 1, 0),(NULL, 193714, 571, 1, 1, 7642.29, 2051.72, 600.264, -1.42244, 0, 0, -0.652758, 0.757566, 180, 255, 1, 0),(NULL, 193713, 571, 1, 1, 7642.54, 2051.88, 600.25, 1.84476, 0, 0, 0.797041, 0.603925, 180, 255, 1, 0),
(NULL, 193712, 571, 1, 1, 7642.72, 2051.59, 600.261, 1.71042, 0, 0, 0.754709, 0.65606, 180, 255, 1, 0),(NULL, 193711, 571, 1, 1, 7645.84, 2061.11, 600.253, -2.43473, 0, 0, -0.938191, 0.346119, 180, 255, 1, 0),(NULL, 193710, 571, 1, 1, 7645.79, 2059.07, 600.253, -1.03847, 0, 0, -0.496216, 0.868199, 180, 255, 1, 0),(NULL, 193709, 571, 1, 1, 7645.86, 2060.06, 601.122, -1.64058, 0, 0, -0.731344, 0.682009, 180, 255, 1, 0),(NULL, 193708, 571, 1, 1, 7636.18, 2073.49, 601.443, -2.86232, 0, 0, -0.990267, 0.139183, 180, 255, 1, 0),(NULL, 193707, 571, 1, 1, 7639.48, 2069.83, 600.657, 2.34747, 0, 0, 0.922201, 0.38671, 180, 255, 1, 0),(NULL, 193706, 571, 1, 1, 7642.22, 2066.7, 601.473, -0.56723, 0, 0, -0.279828, 0.96005, 180, 255, 1, 0),(NULL, 193705, 571, 1, 1, 7641.54, 2066.84, 601.473, 0.401427, 0, 0, 0.199369, 0.979925, 180, 255, 1, 0),(NULL, 193704, 571, 1, 1, 7642.36, 2067.46, 601.459, -2.8873, 0, 0, -0.991928, 0.126804, 180, 255, 1, 0),(NULL, 193703, 571, 1, 1, 7642.85, 2067.18, 601.479, 2.18166, 0, 0, 0.88701, 0.461749, 180, 255, 1, 0),(NULL, 193702, 571, 1, 1, 7643.08, 2067.65, 601.462, -2.97579, 0, 0, -0.996566, 0.0828064, 180, 255, 1, 0),(NULL, 193701, 571, 1, 1, 7642.83, 2067.32, 600.257, -2.58308, 0, 0, -0.961261, 0.275641, 180, 255, 1, 0),(NULL, 193700, 571, 1, 1, 7638.75, 2073.49, 600.251, 1.24791, 0, 0, 0.584249, 0.811574, 180, 255, 1, 0),(NULL, 193699, 571, 1, 1, 7637.21, 2073.31, 601.419, -1.93571, 0, 0, -0.823671, 0.567068, 180, 255, 1, 0),(NULL, 193698, 571, 1, 1, 7636.03, 2073.45, 600.233, -1.92896, 0, 0, -0.821753, 0.569844, 180, 255, 1, 0),(NULL, 193697, 571, 1, 1, 7635.76, 2074.88, 600.27, -2.94959, 0, 0, -0.995395, 0.0958539, 180, 255, 1, 0),
(NULL, 193696, 571, 1, 1, 7637.64, 2074.04, 600.272, 2.60926, 0, 0, 0.964786, 0.263035, 180, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 193579, 571, 1, 1, 7889.04, 2057.88, 599.815, -0.698131, 0, 0, -0.34202, 0.939693, 300, 0, 1, 0),(NULL, 193982, 571, 1, 1, 7888.73, 2057.92, 599.815, 0, 0, 0, 0, 1, 300, 0, 1, 0),(NULL, 193607, 571, 1, 1, 7888.51, 2057.61, 600.259, -1.41372, 0, 0, -0.649449, 0.760405, 300, 100, 1, 0),(NULL, 193796, 571, 1, 1, 7888.96, 2058.19, 586.427, -2.57972, 0, 0, -0.960796, 0.277255, 180, 255, 1, 0),(NULL, 193692, 571, 1, 1, 7897.41, 2070.06, 600.272, 1.24824, 0, 0, 0.584383, 0.811478, 180, 255, 1, 0),
(NULL, 193693, 571, 1, 1, 7895.56, 2044.42, 601.668, 1.26947, 0, 0, 0.592964, 0.805229, 180, 255, 1, 0),(NULL, 193691, 571, 1, 1, 7885.87, 2057.75, 604.27, 0.07854, 0, 0, 0.0392599, 0.999229, 180, 255, 1, 0),(NULL, 193763, 571, 1, 1, 7885.77, 2057.76, 600.887, 0.063894, 0, 0, 0.0319416, 0.99949, 180, 255, 1, 0),(NULL, 193677, 571, 1, 1, 7885.66, 2057.74, 604.195, -3.05428, 0, 0, -0.999047, 0.0436424, 180, 255, 1, 0),(NULL, 193761, 571, 1, 1, 7889.73, 2060.41, 600.258, 2.95833, 0, 0, 0.995805, 0.0915032, 180, 255, 1, 0),(NULL, 193760, 571, 1, 1, 7890.54, 2060.25, 600.248, -2.0333, 0, 0, -0.85035, 0.526218, 180, 255, 1, 0),(NULL, 193759, 571, 1, 1, 7889.98, 2059.47, 600.244, -2.93214, 0, 0, -0.994521, 0.104535, 180, 255, 1, 0),(NULL, 193758, 571, 1, 1, 7888.88, 2057.81, 600.495, -1.56207, 0, 0, -0.704015, 0.710185, 180, 255, 1, 0),(NULL, 193756, 571, 1, 1, 7888.6, 2057.9, 598.534, -0.139624, 0, 0, -0.0697553, 0.997564, 180, 255, 1, 0),(NULL, 193755, 571, 1, 1, 7877.74, 2047.84, 600.669, -0.802851, 0, 0, -0.390731, 0.920505, 180, 255, 1, 0),(NULL, 193754, 571, 1, 1, 7890.59, 2057.9, 600.165, 0.017454, 0, 0, 0.00872689, 0.999962, 180, 255, 1, 0),(NULL, 193753, 571, 1, 1, 7875, 2050.97, 601.319, -1.44862, 0, 0, -0.662619, 0.748957, 180, 255, 1, 0),(NULL, 193752, 571, 1, 1, 7874.64, 2050.93, 601.321, -2.1293, 0, 0, -0.874619, 0.48481, 180, 255, 1, 0),(NULL, 193751, 571, 1, 1, 7874.74, 2050.31, 601.349, -0.759215, 0, 0, -0.370556, 0.92881, 180, 255, 1, 0),(NULL, 193750, 571, 1, 1, 7874.78, 2050.18, 600.129, 0.759219, 0, 0, 0.370558, 0.928809, 180, 255, 1, 0),(NULL, 193749, 571, 1, 1, 7881.34, 2043.52, 600.008, -0.418879, 0, 0, -0.207912, 0.978148, 180, 255, 1, 0),(NULL, 193748, 571, 1, 1, 7881.17, 2045.81, 600.035, -3.08918, 0, 0, -0.999657, 0.0262033, 180, 255, 1, 0),
(NULL, 193747, 571, 1, 1, 7879.74, 2044.7, 600.14, -2.15548, 0, 0, -0.88089, 0.47332, 180, 255, 1, 0),(NULL, 193746, 571, 1, 1, 7871.34, 2057.12, 600.23, 0.680679, 0, 0, 0.333807, 0.942641, 180, 255, 1, 0),(NULL, 193745, 571, 1, 1, 7871.44, 2059.16, 600.23, 2.07694, 0, 0, 0.861629, 0.507539, 180, 255, 1, 0),(NULL, 193744, 571, 1, 1, 7871.47, 2057.94, 601.099, 1.47483, 0, 0, 0.672377, 0.740209, 180, 255, 1, 0),(NULL, 193743, 571, 1, 1, 7889.51, 2041.1, 600.216, 2.30383, 0, 0, 0.913544, 0.406739, 180, 255, 1, 0),(NULL, 193742, 571, 1, 1, 7887.47, 2041.1, 600.216, -2.58308, 0, 0, -0.961261, 0.275641, 180, 255, 1, 0),(NULL, 193741, 571, 1, 1, 7888.47, 2041.05, 601.082, 3.09799, 0, 0, 0.999762, 0.0217996, 180, 255, 1, 0),(NULL, 193740, 571, 1, 1, 7880.1, 2072.08, 601.421, -0.270523, 0, 0, -0.134849, 0.990866, 180, 255, 1, 0),(NULL, 193739, 571, 1, 1, 7881.29, 2071.99, 601.419, 0.157079, 0, 0, 0.0784588, 0.996917, 180, 255, 1, 0),(NULL, 193738, 571, 1, 1, 7881.41, 2070.34, 601.433, 1.95477, 0, 0, 0.829038, 0.559192, 180, 255, 1, 0),(NULL, 193737, 571, 1, 1, 7880.95, 2071.65, 600.217, -1.02974, 0, 0, -0.492422, 0.870357, 180, 255, 1, 0),(NULL, 193736, 571, 1, 1, 7878.23, 2068.07, 600.557, -2.3911, 0, 0, -0.930417, 0.366502, 180, 255, 1, 0),(NULL, 193735, 571, 1, 1, 7873.96, 2066.1, 600.263, -0.872663, 0, 0, -0.422618, 0.906308, 180, 255, 1, 0),(NULL, 193734, 571, 1, 1, 7874.18, 2066.85, 600.269, 2.27762, 0, 0, 0.908136, 0.418675, 180, 255, 1, 0),(NULL, 193733, 571, 1, 1, 7874.12, 2066.33, 600.244, 2.86233, 0, 0, 0.990267, 0.139178, 180, 255, 1, 0),(NULL, 193732, 571, 1, 1, 7873.58, 2065.55, 600.361, 0.759044, 0, 0, 0.370477, 0.928842, 180, 255, 1, 0),(NULL, 193731, 571, 1, 1, 7873.7, 2064.57, 600.339, -0.549681, 0, 0, -0.271393, 0.962469, 180, 255, 1, 0),
(NULL, 193730, 571, 1, 1, 7873.63, 2065.22, 600.23, 2.80997, 0, 0, 0.986285, 0.165053, 180, 255, 1, 0),(NULL, 193729, 571, 1, 1, 7887.84, 2074.57, 600.247, -0.811576, 0, 0, -0.394743, 0.918792, 180, 255, 1, 0),(NULL, 193728, 571, 1, 1, 7888.88, 2074.65, 601.116, -0.017419, 0, 0, -0.00870939, 0.999962, 180, 255, 1, 0),(NULL, 193727, 571, 1, 1, 7889.88, 2074.63, 600.247, 0.584686, 0, 0, 0.288197, 0.957571, 180, 255, 1, 0),(NULL, 193726, 571, 1, 1, 7904.18, 2049.76, 600.239, 2.08567, 0, 0, 0.863836, 0.503773, 180, 255, 1, 0),(NULL, 193725, 571, 1, 1, 7904.38, 2050.16, 600.238, -1.68424, 0, 0, -0.746056, 0.665883, 180, 255, 1, 0),(NULL, 193724, 571, 1, 1, 7904.04, 2050.09, 600.233, 0.706858, 0, 0, 0.346117, 0.938191, 180, 255, 1, 0),(NULL, 193723, 571, 1, 1, 7896.35, 2044.0, 601.35, 0.575958, 0, 0, 0.284015, 0.95882, 180, 255, 1, 0),(NULL, 193722, 571, 1, 1, 7894.41, 2047.29, 601.309, 3.01067, 0, 0, 0.997858, 0.0654146, 180, 255, 1, 0),(NULL, 193721, 571, 1, 1, 7896.48, 2044.01, 600.13, 2.09439, 0, 0, 0.866024, 0.500002, 180, 255, 1, 0),(NULL, 193720, 571, 1, 1, 7899.41, 2047.68, 600.681, 0.750491, 0, 0, 0.366501, 0.930418, 180, 255, 1, 0),(NULL, 193719, 571, 1, 1, 7902.19, 2063.95, 601.511, -1.96349, 0, 0, -0.831468, 0.555572, 180, 255, 1, 0),(NULL, 193718, 571, 1, 1, 7901.95, 2049.21, 600.24, 2.92342, 0, 0, 0.994056, 0.10887, 180, 255, 1, 0),(NULL, 193717, 571, 1, 1, 7902.18, 2049.3, 600.461, -1.10828, 0, 0, -0.526212, 0.850353, 180, 255, 1, 0),(NULL, 193716, 571, 1, 1, 7902.39, 2049.29, 600.24, -2.64417, 0, 0, -0.96923, 0.246155, 180, 255, 1, 0),(NULL, 193715, 571, 1, 1, 7902.14, 2049.52, 600.262, -0.93375, 0, 0, -0.450098, 0.892979, 180, 255, 1, 0),(NULL, 193714, 571, 1, 1, 7902.29, 2049.42, 600.264, -1.42244, 0, 0, -0.652758, 0.757566, 180, 255, 1, 0),(NULL, 193713, 571, 1, 1, 7902.54, 2049.58, 600.25, 1.84476, 0, 0, 0.797041, 0.603925, 180, 255, 1, 0),
(NULL, 193712, 571, 1, 1, 7902.72, 2049.29, 600.261, 1.71042, 0, 0, 0.754709, 0.65606, 180, 255, 1, 0),(NULL, 193711, 571, 1, 1, 7905.84, 2058.81, 600.253, -2.43473, 0, 0, -0.938191, 0.346119, 180, 255, 1, 0),(NULL, 193710, 571, 1, 1, 7905.79, 2056.77, 600.253, -1.03847, 0, 0, -0.496216, 0.868199, 180, 255, 1, 0),(NULL, 193709, 571, 1, 1, 7905.86, 2057.76, 601.122, -1.64058, 0, 0, -0.731344, 0.682009, 180, 255, 1, 0),(NULL, 193708, 571, 1, 1, 7896.18, 2071.19, 601.443, -2.86232, 0, 0, -0.990267, 0.139183, 180, 255, 1, 0),(NULL, 193707, 571, 1, 1, 7899.48, 2067.53, 600.657, 2.34747, 0, 0, 0.922201, 0.38671, 180, 255, 1, 0),(NULL, 193706, 571, 1, 1, 7902.22, 2064.3, 601.473, -0.56723, 0, 0, -0.279828, 0.96005, 180, 255, 1, 0),(NULL, 193705, 571, 1, 1, 7901.54, 2064.54, 601.473, 0.401427, 0, 0, 0.199369, 0.979925, 180, 255, 1, 0),(NULL, 193704, 571, 1, 1, 7902.36, 2065.16, 601.459, -2.8873, 0, 0, -0.991928, 0.126804, 180, 255, 1, 0),(NULL, 193703, 571, 1, 1, 7902.85, 2064.88, 601.479, 2.18166, 0, 0, 0.88701, 0.461749, 180, 255, 1, 0),(NULL, 193702, 571, 1, 1, 7903.08, 2065.35, 601.462, -2.97579, 0, 0, -0.996566, 0.0828064, 180, 255, 1, 0),(NULL, 193701, 571, 1, 1, 7902.83, 2065.02, 600.257, -2.58308, 0, 0, -0.961261, 0.275641, 180, 255, 1, 0),(NULL, 193700, 571, 1, 1, 7898.75, 2071.19, 600.251, 1.24791, 0, 0, 0.584249, 0.811574, 180, 255, 1, 0),(NULL, 193699, 571, 1, 1, 7897.21, 2071.01, 601.419, -1.93571, 0, 0, -0.823671, 0.567068, 180, 255, 1, 0),(NULL, 193698, 571, 1, 1, 7896.03, 2071.15, 600.233, -1.92896, 0, 0, -0.821753, 0.569844, 180, 255, 1, 0),(NULL, 193697, 571, 1, 1, 7895.76, 2072.58, 600.27, -2.94959, 0, 0, -0.995395, 0.0958539, 180, 255, 1, 0),
(NULL, 193696, 571, 1, 1, 7897.64, 2071.74, 600.272, 2.60926, 0, 0, 0.964786, 0.263035, 180, 255, 1, 0);



-- ------------------------------------------
-- PHASED SPAWNS
-- ------------------------------------------
-- ------------------------------------------
-- SONS OF HODIR
-- ------------------------------------------
-- Storm peaks, sons of hodir phasing fixes
-- Halvdan <Flight Master>, Sons of Hodir chain
DELETE FROM spell_area WHERE area IN(4438, 4440) AND spell=55858;
INSERT INTO spell_area VALUES(55858, 4438, 12956, 0, 0, 0, 2, 1, 64, 11);
INSERT INTO spell_area VALUES(55858, 4440, 12956, 0, 0, 0, 2, 1, 64, 11);
-- Fjorn's Anvil zone
DELETE FROM spell_area WHERE area=4495;
REPLACE INTO spell_area VALUES(55858, 4495, 12956, 12967, 0, 0, 2, 1, 64, 11);
REPLACE INTO spell_area VALUES(55952, 4495, 12967, 0, 0, 0, 2, 1, 64, 11);
REPLACE INTO spell_area VALUES(61209, 4495, 12966, 12924, 0, 0, 2, 1, 74, 11);
-- Frostfield Lake
DELETE FROM spell_area WHERE area=4439 AND spell IN(55858, 56780);
REPLACE INTO spell_area VALUES(55858, 4439, 12956, 0, 0, 0, 2, 1, 64, 11);
REPLACE INTO spell_area VALUES(56780, 4439, 12956, 12987, 0, 0, 2, 1, 64, 11);
-- Valley of Ancient Winters, Hibernal Cavern
DELETE FROM spell_area WHERE area IN(4437, 4455) AND spell=55858;
REPLACE INTO spell_area VALUES(55858, 4455, 12956, 0, 0, 0, 2, 1, 64, 11);
REPLACE INTO spell_area VALUES(55858, 4437, 12956, 0, 0, 0, 2, 1, 64, 11);
-- Dun Niffelem
DELETE FROM spell_area WHERE area IN(4438) AND spell=55952; -- hackfix
REPLACE INTO spell_area VALUES(55952, 4438, 12967, 0, 0, 0, 2, 1, 64, 11);
-- Smoldering Scrap Bunny (30169)
-- Seething Revenant (30387)
-- Seething Revenant(30120)
-- Frost Giant Stormherald (30121)
-- Snorri (30123)
-- Dead Iron Giant (30163)
-- Brittle Revenant (30160)
-- Storm Peaks Anvil Bunny (30122)
-- Njormeld (30099)
-- Njormeld (30127)
UPDATE creature SET phasemask=8 WHERE id=30127; -- hackfix
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30169, 30163, 30160, 30123, 30121, 30120, 30387, 30122, 30099));
DELETE FROM creature WHERE id IN(30169, 30163, 30160, 30123, 30121, 30120, 30387, 30122, 30099);
INSERT INTO creature VALUES(NULL, 30099, 571, 1, 4, 0, 0, 7199.92, -3530.57, 826.845, 1.59574, 300, 0, 0, 48700, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30169, 571, 1, 8, 0, 0, 7181.41, -3533.11, 826.956, 3.21141, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7219.12, -3607.77, 822.712, 1.65806, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7216.24, -3582.57, 824.501, 0.837758, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7207.47, -3438.53, 838.874, 2.89725, 300, 0, 0, 1, 0, 0, 0, 0, 0),
(NULL, 30169, 571, 1, 8, 0, 0, 7222.42, -3441.84, 837.193, 2.14675, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7227.85, -3415.96, 840.174, 1.55334, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7217.79, -3378.62, 846.734, 5.41052, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7206.48, -3460.64, 835.851, 3.90954, 300, 0, 0, 1, 0, 0, 0, 0, 0),
(NULL, 30169, 571, 1, 8, 0, 0, 7192, -3386.61, 846.416, 2.11185, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7206.62, -3482, 833.563, 3.28122, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7232.06, -3474.28, 850.768, 3.92699, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30169, 571, 1, 8, 0, 0, 7178.47, -3558.92, 827.034, 3.35103, 300, 0, 0, 1, 0, 0, 0, 0, 0),
(NULL, 30169, 571, 1, 8, 0, 0, 7138.42, -3553.75, 832.279, 4.69494, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7181.85, -3561.65, 827.102, 1.34394, 600, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7171.87, -3564.23, 826.705, 1.05727, 600, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7235.26, -3480.56, 850.328, 4.32905, 600, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, 30387, 571, 1, 8, 0, 0, 7190.62, -3549.54, 827.918, 1.28897, 600, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7146.46, -3553.65, 830.519, 0.613523, 600, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7231.77, -3648.91, 823.616, 5.67933, 600, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7209.96, -3426.8, 839.399, 1.92906, 600, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, 30387, 571, 1, 8, 0, 0, 7191.38, -3364.16, 846.246, 1.41463, 600, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30387, 571, 1, 8, 0, 0, 7224.41, -3496.64, 840.3, 3.8813, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 30120, 571, 1, 4, 0, 0, 7268.63, -3640.36, 825.267, 2.37365, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30120, 571, 1, 4, 0, 0, 7192.8, -3665, 824.727, 6.05783, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30120, 571, 1, 4, 0, 0, 7250.05, -3636.57, 825.872, -1.4385, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30120, 571, 1, 4, 0, 0, 7201.55, -3622.78, 823.52, 5.55015, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, 30120, 571, 1, 4, 0, 0, 7223.84, -3676.14, 828.727, 2.17625, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30121, 571, 1, 4, 0, 0, 7138.25, -3547.1, 832.591, 5.20108, 300, 0, 0, 48700, 0, 0, 0, 0, 0),(NULL, 30121, 571, 1, 4, 0, 0, 7201.98, -3624.42, 823.542, 5.13733, 300, 0, 0, 48700, 0, 0, 0, 0, 0),(NULL, 30121, 571, 1, 4, 0, 0, 7251.04, -3644, 823.097, 3.15905, 300, 0, 0, 48700, 0, 0, 0, 0, 0),
(NULL, 30121, 571, 1, 4, 0, 0, 7220.33, -3671.06, 823.633, 1.67552, 300, 0, 0, 48700, 0, 0, 0, 0, 0),(NULL, 30122, 571, 1, 4, 0, 0, 7219.52, -3645.4, 824.558, 2.61799, 300, 0, 0, 1, 0, 0, 0, 0, 0),(NULL, 30123, 571, 1, 4, 0, 0, 7167.38, -3543.06, 827.746, 6.05629, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30163, 571, 1, 4, 0, 0, 7345.66, -3051.66, 840.411, 1.90241, 300, 0, 0, 50400, 0, 0, 0, 0, 0),
(NULL, 30163, 571, 1, 4, 0, 0, 7421.35, -3151.34, 837.535, 0.296706, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30163, 571, 1, 4, 0, 0, 7242.4, -3325.25, 851.185, 6.00393, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30163, 571, 1, 4, 0, 0, 7197.12, -3030.61, 854.046, 4.04916, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30163, 571, 1, 4, 0, 0, 7405.24, -3112.27, 837.535, 4.24115, 300, 0, 0, 50400, 0, 0, 0, 0, 0),
(NULL, 30163, 571, 1, 4, 0, 0, 7244.75, -3157.34, 837.535, 3.59538, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30163, 571, 1, 4, 0, 0, 7286.04, -3116.05, 837.535, 0.663225, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30163, 571, 1, 4, 0, 0, 7224.37, -3266.17, 837.535, 3.33358, 300, 0, 0, 50400, 0, 0, 0, 0, 0),
(NULL, 30160, 571, 1, 4, 0, 1, 7419.28, -3141.33, 837.577, 1.34635, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30160, 571, 1, 4, 0, 1, 7359.13, -3103.31, 837.534, 4.17214, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30160, 571, 1, 4, 0, 1, 7376.07, -3153.04, 837.577, 1.80255, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30160, 571, 1, 4, 0, 1, 7315.46, -3179.34, 837.617, 1.60589, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, 30160, 571, 1, 4, 0, 1, 7255.27, -3083.26, 837.577, -2.07948, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30160, 571, 1, 4, 0, 1, 7405.8, -3082.12, 837.57, -0.036917, 300, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 30160, 571, 1, 4, 0, 1, 7300.77, -3084.76, 837.577, 3.23101, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
-- Snowdrift (192075)
DELETE FROM gameobject WHERE id=192075;
INSERT INTO gameobject VALUES (NULL, 192075, 571, 1, 4, 7218.64, -3529.71, 828.539, -1.93732, 0, 0, -0.824127, 0.566404, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7201.17, -3556.13, 828.03, 2.18166, 0, 0, 0.88701, 0.461749, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7230.44, -3555.63, 841.772, 1.85005, 0, 0, 0.798636, 0.601815, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7169.6, -3615.71, 830.249, -2.89724, 0, 0, -0.992546, 0.121873, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7121.83, -3542.56, 835.008, -0.750491, 0, 0, -0.366501, 0.930418, 300, 100, 1, 0),
(NULL, 192075, 571, 1, 4, 7131.5, -3584.22, 840.195, -1.91986, 0, 0, -0.819151, 0.573577, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7162.55, -3582.66, 830.36, 1.11701, 0, 0, 0.529919, 0.848048, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7176.21, -3511.2, 833.381, 1.93731, 0, 0, 0.824125, 0.566409, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7148.73, -3559.17, 830.36, -2.72271, 0, 0, -0.978147, 0.207914, 300, 100, 1, 0),(NULL, 192075, 571, 1, 4, 7165.47, -3639.53, 832.157, 0.890117, 0, 0, 0.430511, 0.902586, 300, 100, 1, 0);
-- Smoldering Scrap (192124)
DELETE FROM gameobject WHERE id=192124;
-- Fjorn's Anvil (192071)
DELETE FROM gameobject WHERE id=192071;
INSERT INTO gameobject VALUES(NULL, 192071, 571, 1, 8, 7213.2, -2649.97, 810.6, 3.09472, 0, 0, 0.999725, 0.0234342, 360, 0, 1, 0); -- hackfix
-- Fjorn's Anvil (192060)
DELETE FROM gameobject WHERE id=192060;
INSERT INTO gameobject VALUES(NULL, 192060, 571, 1, 5, 7217.07, -3645.75, 819.406, 1.79769, 0, 0, 0, 1, 180, 255, 1, 0);
-- Hodir's Spear (192079)
DELETE FROM gameobject WHERE id=192079;
INSERT INTO gameobject VALUES(NULL, 192079, 571, 1, 4, 7309.3, -2782.45, 869.824, -0.610864, 0, 0, -0.300705, 0.953717, 180, 255, 1, 0);
-- Hodir's Horn (192078)
DELETE FROM gameobject WHERE id=192078;
INSERT INTO gameobject VALUES(NULL, 192078, 571, 1, 4, 7142.23, -2723.25, 787.769, -2.63544, 0, 0, -0.968147, 0.250383, 180, 255, 1, 0);
-- Arngrim the Insatiable (192524)
DELETE FROM gameobject WHERE id=192524;
INSERT INTO gameobject VALUES(NULL, 192524, 571, 1, 4, 7355.87, -2962.37, 912.502, 1.74533, 0, 0, 0.766045, 0.642787, 180, 255, 1, 0);



-- ------------------------------------------
-- ORGRIMMAR, WRATHGATE
-- ------------------------------------------
DELETE FROM creature WHERE id IN(31564,31416,31420,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31437,31467);
INSERT INTO creature VALUES (NULL, 31564, 1, 1, 128, 0, 0, 1429.89, -4393.2, 25.2354, 4.92588, 300, 0, 0, 31905, 0, 0, 0, 0, 0),(NULL, 31564, 1, 1, 128, 0, 0, 1356.18, -4361.85, 26.7058, 0.346665, 300, 0, 0, 31905, 0, 0, 0, 0, 0),(NULL, 31564, 1, 1, 128, 0, 0, 1297.45, -4493.71, 23.5998, 1.54834, 300, 5, 0, 31905, 0, 1, 0, 0, 0),(NULL, 31564, 1, 1, 128, 0, 0, 1331.19, -4388.35, 26.2572, 0.382886, 300, 0, 0, 31905, 0, 0, 0, 0, 0),(NULL, 31564, 1, 1, 128, 0, 0, 1491.73, -4411.57, 23.5107, 3.15863, 300, 0, 0, 31905, 0, 0, 0, 0, 0),(NULL, 31564, 1, 1, 128, 0, 0, 1517.45, -4419.16, 17.3082, 6.26724, 300, 0, 0, 31905, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1620.45, -4252.84, 47.5273, 3.7001, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1552.41, -4324.75, 21.8029, 5.51524, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1628.89, -4274.76, 24.0855, 5.13127, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1889.53, -4485.08, 21.3103, 1.44862, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1952.53, -4368.57, 22.659, 3.68265, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1817.08, -4357.14, -9.81641, 2.30383, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1921.7, -4375.67, 22.5724, 5.84685, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1741.42, -4217.94, 44.3144, 3.38795, 300, 5, 0, 16050, 0, 1, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1845.49, -4395.95, 5.19264, 3.80482, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1672.28, -4473.2, 20.1537, 1.44862, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1953.01, -4431.15, 25.1469, 3.31613, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1523.92, -4429.44, 16.7349, 0.506145, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1688.53, -4474.58, 20.1537, 1.95477, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1896.44, -4603.17, 33.8937, 3.75642, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1751.45, -4208.82, 42.7326, 5.34071, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1906.25, -4564.21, 33.9758, 0.628319, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 2015.69, -4719.41, 24.5092, 2.53025, 300, 5, 0, 16050, 0, 1, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1629.47, -4400.14, 13.8212, 0.107557, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 2126.41, -4738.09, 50.4491, 2.74017, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1416.9, -4365.66, 25.2354, 3.25185, 300, 5, 0, 16050, 0, 1, 0, 0, 0),
(NULL, 31416, 1, 1, 128, 0, 1, 1518.15, -4425.35, 18.7986, 1.27409, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1950.89, -4374.69, 22.043, 2.70526, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1929.52, -4300.46, 24.1794, 4.6942, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1596.65, -4388.67, 9.98323, 5.98648, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1668.56, -4323.66, 61.3295, 5.96903, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1690.52, -4262.62, 53.7757, 2.61799, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1775.07, -4319.91, -7.87855, 5.60251, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1759.03, -4301.89, 7.01614, 5.46288, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1603.48, -4449.95, 8.1165, 2.3911, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1902.63, -4628.79, 33.9763, 0.593412, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1615.63, -4376.11, 12.4018, 4.24115, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1479.39, -4406.25, 25.3187, 0.017453, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1387.28, -4379.89, 27.0983, 3.29867, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1886.46, -4415.86, 11.7157, 3.76991, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1673.2, -4250, 51.8765, 5.044, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1623.15, -4279.64, 22.5694, 6.16101, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1537.41, -4380.75, 16.7599, 3.42085, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1923.98, -4447.8, 44.9684, 0.715585, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 2079.58, -4710.36, 38.8957, 6.0586, 300, 5, 0, 16050, 0, 1, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1481.77, -4427.79, 25.3187, 0.191986, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1689.99, -4279.85, 32.1304, 4.11898, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1557.74, -4364.25, 1.07971, 0.226893, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1900.53, -4481.11, 20.727, 3.35369, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1561.79, -4360.5, 1.19455, 4.85202, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 2096.59, -4668.5, 44.7122, 4.66795, 300, 5, 0, 16050, 0, 1, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1696.02, -4463.71, 20.1522, 2.3911, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1572.83, -4318.32, 21.7125, 0.590477, 300, 5, 0, 16050, 0, 1, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1384.62, -4358.56, 27.0983, 3.38594, 300, 0, 0, 16050, 0, 0, 0, 0, 0),
(NULL, 31416, 1, 1, 128, 0, 1, 2131.15, -4729.88, 50.4302, 2.60054, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1748.53, -4260.13, 27.0722, 2.33874, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1928.32, -4424.41, 23.7505, 0.558505, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1920.62, -4365.93, 22.804, 0.296706, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1566.22, -4194.07, 42.6709, 0.15708, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1576.2, -4394.43, 6.55505, 4.57276, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1902.14, -4275.21, 31.7987, 4.17134, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1879.63, -4526.83, 26.4142, 3.65011, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1762.71, -4496.99, 44.6195, 2.13173, 300, 5, 0, 16050, 0, 1, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1913.71, -4559.36, 33.9759, 3.71755, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1882.15, -4483.99, 20.6388, 2.09439, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1910.24, -4623.92, 33.9762, 3.735, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1963.01, -4730.91, 48.9608, 2.49582, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 2004.18, -4719.8, 26.2996, 0.959931, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1886.2, -4546.68, 28.5148, 1.09956, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31416, 1, 1, 128, 0, 1, 1829.26, -4507.27, 21.4564, 4.95674, 300, 0, 0, 16050, 0, 0, 0, 0, 0),(NULL, 31420, 1, 1, 128, 0, 0, 1627.42, -4376.04, 11.8113, 3.68265, 300, 0, 0, 5544, 0, 0, 0, 0, 0),(NULL, 31421, 1, 1, 128, 0, 0, 1632.61, -4381.89, 11.7685, 3.59538, 300, 0, 0, 5544, 0, 0, 0, 0, 0),(NULL, 31422, 1, 1, 128, 0, 0, 1623.04, -4368.92, 11.7852, 3.92699, 300, 0, 0, 5544, 0, 0, 0, 0, 0),(NULL, 31423, 1, 1, 128, 0, 0, 1593.1, -4401.22, 6.26454, 0.628319, 300, 0, 0, 1003, 0, 0, 0, 0, 0),(NULL, 31424, 1, 1, 128, 0, 0, 1592.48, -4399.12, 6.52479, 0.488692, 300, 0, 0, 247, 0, 0, 0, 0, 0),(NULL, 31425, 1, 1, 128, 0, 0, 1594.78, -4401.08, 6.66987, 0.628319, 300, 0, 0, 2769, 0, 0, 0, 0, 0),(NULL, 31426, 1, 1, 128, 0, 0, 1675.79, -4311.64, 61.6865, 4.46804, 300, 0, 0, 10572, 0, 0, 0, 0, 0),(NULL, 31427, 1, 1, 128, 0, 0, 1596.3, -4402.08, 7.03335, 0.645772, 300, 0, 0, 1003, 0, 0, 0, 0, 0),(NULL, 31429, 1, 1, 128, 0, 0, 1595.3, -4399.25, 6.85403, 0.523599, 300, 0, 0, 1003, 0, 0, 0, 0, 0),(NULL, 31430, 1, 1, 128, 0, 0, 1592.8, -4397.05, 7.21839, 0.139626, 300, 0, 0, 6645, 0, 0, 0, 0, 0),(NULL, 31431, 1, 1, 128, 0, 0, 1600.79, -4395.93, 8.79711, 5.84332, 300, 0, 0, 48832, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1430.77, -4422.73, 25.3187, 3.80482, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(NULL, 31437, 1, 1, 128, 0, 0, 1501.08, -4399.95, 22.6577, 0.610865, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1346.63, -4348.61, 27.2941, 5.89921, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1511.79, -4433.06, 21.1091, 4.2586, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1438.44, -4432.79, 25.3187, 1.6057, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1492.76, -4396.73, 24.7758, 0.506145, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1439.46, -4430.56, 25.3187, 0.087266, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1510.11, -4399.52, 20.1228, 0.959931, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1370.87, -4415.52, 29.7207, 3.21141, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1341.92, -4340.45, 27.4999, 4.85202, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1437.46, -4430.24, 25.3187, 1.64061, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1373.46, -4354.62, 26.4516, 0.680678, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1429.84, -4355.29, 25.3187, 4.50295, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1422.9, -4403.13, 28.0279, 1.37881, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1418.51, -4354.17, 27.9913, 4.74729, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1444.13, -4431.9, 25.3187, 1.71042, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1429.54, -4420.9, 25.3187, 5.70723, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1507.59, -4433.21, 22.5193, 0.733038, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1434.89, -4359.25, 25.3187, 3.48839, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1509.96, -4429.22, 21.4358, 1.8326, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1588.52, -4423.32, 8.55745, 4.60385, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1293, -4425.1, 26.7719, 2.32129, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1438.97, -4368.84, 25.3187, 6.05629, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1421.35, -4385.14, 27.9797, 0.034907, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1506.25, -4390.73, 21.2549, 0.383972, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1590.13, -4427.63, 8.5698, 4.08407, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1501.9, -4437.72, 24.7493, 0.069813, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1329.38, -4358.21, 28.4718, 1.37259, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1341.65, -4420.3, 27.241, 2.15036, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1439.33, -4364.56, 25.3187, 0.20944, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1501.53, -4395.09, 22.5012, 0.139626, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(NULL, 31437, 1, 1, 128, 0, 0, 1525.64, -4435.69, 16.5148, 0.872665, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1522.16, -4437.87, 18.1303, 0.523599, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1348.6, -4427.49, 27.5116, 4.18879, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1508.82, -4393.75, 20.5281, 4.20624, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1515.62, -4424.49, 19.6616, 3.64774, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1430.16, -4376.73, 25.2354, 4.83093, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1429.35, -4374.5, 25.2354, 4.82928, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1353.47, -4401.82, 29.0612, 5.72889, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1360.78, -4373.65, 26.1952, 0.305098, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1313.04, -4393.01, 26.2498, 1.65851, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1326.28, -4436.94, 26.3456, 0.590713, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1314.29, -4548.93, 22.5108, 1.77181, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1317.3, -4569.04, 23.2873, 1.75938, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1313.05, -4558.77, 22.4257, 1.78925, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1315.31, -4561.24, 22.8135, 1.76455, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1380.18, -4367.96, 26.0744, 6.03816, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31437, 1, 1, 128, 0, 0, 1377.94, -4368.01, 26.0744, 0.245054, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1513.18, -4439.38, 21.1171, 4.59022, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1427.52, -4357.11, 25.3187, 5.91667, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1507.22, -4401.21, 20.9239, 1.98968, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1434.66, -4426.87, 25.3187, 1.16687, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1342.5, -4416.78, 27.4217, 6.00393, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1421.8, -4387.9, 27.9717, 0.087266, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1326.16, -4358.72, 28.2629, 3.71755, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1348, -4422.53, 27.5683, 2.67035, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1338.15, -4424.22, 26.8887, 1.69297, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1406.44, -4378.1, 25.3187, 1.62316, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1289.4, -4421.72, 26.6863, 3.61283, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1451.82, -4410.37, 25.3187, 4.99164, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1428.1, -4425.13, 25.3187, 0.017453, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(NULL, 31467, 1, 1, 128, 0, 0, 1503.74, -4385.62, 21.9836, 0.366519, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1349.98, -4347.57, 27.2651, 0.408181, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1290.51, -4427.42, 26.8743, 1.65806, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1591.92, -4421.75, 9.19134, 4.27606, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1327.41, -4355.25, 28.5793, 2.26893, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1348.2, -4342.35, 27.3154, 3.50811, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1370.66, -4405.43, 29.8003, 5.70723, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1442.68, -4382.87, 27.9692, 2.6529, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1514.34, -4393.1, 19.2682, 5.02655, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1372.42, -4417.69, 29.946, 4.7822, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1424.73, -4402.81, 27.8919, 1.51844, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1506.26, -4397.44, 21.1897, 4.49761, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1514.01, -4428.42, 20.2095, 0.091911, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1343.96, -4346.27, 27.32, 4.36332, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1449.22, -4431.79, 27.9594, 0.698132, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1446.99, -4432.07, 27.9606, 1.8326, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1286.08, -4424.82, 26.7458, 4.60767, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1425.41, -4355.51, 25.3187, 4.74729, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1374.79, -4356.54, 26.3583, 4.01426, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1438.46, -4362.51, 25.3187, 4.29351, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1337.31, -4418.02, 27.0777, 3.9619, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1445.43, -4401.04, 28.0069, 3.1765, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1370.44, -4407.64, 29.7393, 2.70993, 300, 0, 0, 42, 0, 0, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1561.95, -4431.2, 7.35178, 5.87336, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1498.22, -4401.02, 23.5843, 0.881843, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1511.44, -4414.09, 18.6863, 6.14799, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1450.26, -4420.44, 25.2354, 6.18302, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1433.52, -4400.56, 25.2354, 4.86987, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1432.46, -4389.99, 25.2354, 4.87346, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1315.09, -4454.26, 24.8666, 1.62166, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1314.06, -4473.25, 24.0767, 1.44838, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1313.39, -4473.52, 24.0781, 1.51996, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1312.37, -4543.88, 22.4689, 1.64263, 300, 5, 0, 42, 0, 1, 0, 0, 0),(NULL, 31467, 1, 1, 128, 0, 0, 1316.82, -4578.19, 23.3084, 1.94786, 300, 5, 0, 42, 0, 1, 0, 0, 0);
UPDATE creature_template SET unit_flags=33536, minlevel=75, maxlevel=75, exp=2 WHERE entry=31416;
UPDATE creature_template SET unit_flags=33536, faction=1980, mindmg=500, maxdmg=600, minlevel=75, maxlevel=75, exp=2 WHERE entry=31564;
UPDATE creature_template SET minlevel=45, maxlevel=45, exp=2 WHERE entry IN(31420, 31421, 31422);
UPDATE creature_template SET minlevel=30, maxlevel=30, exp=2 WHERE entry IN(31423, 31427, 31429);
UPDATE creature_template SET minlevel=12, maxlevel=12, exp=2 WHERE entry IN(31424);
UPDATE creature_template SET minlevel=50, maxlevel=50, exp=2 WHERE entry IN(31425, 31430);
UPDATE creature_template SET minlevel=65, maxlevel=65, exp=2 WHERE entry IN(31426, 31431);
DELETE FROM gameobject WHERE id IN(193215, 193216, 193217, 193218, 193219);
INSERT INTO gameobject VALUES (NULL, 193215, 1, 1, 128, 1342.05, -4422.28, 27.1199, 2.89724, 0, 0, 0.992546, 0.121873, 300, 255, 1, 0),(NULL, 193215, 1, 1, 128, 1510.65, -4434.43, 19.5072, 0.279252, 0, 0, 0.139173, 0.990268, 300, 255, 1, 0),(NULL, 193216, 1, 1, 128, 1505.29, -4396.68, 21.197, -0.244346, 0, 0, -0.121869, 0.992546, 300, 255, 1, 0),(NULL, 193216, 1, 1, 128, 1347.04, -4345.92, 27.2229, -0.418879, 0, 0, -0.207912, 0.978148, 300, 255, 1, 0),(NULL, 193216, 1, 1, 128, 1289.21, -4424.8, 26.6752, -1.02974, 0, 0, -0.492422, 0.870357, 300, 255, 1, 0),(NULL, 193217, 1, 1, 128, 1427.4, -4355.75, 25.0687, -1.41372, 0, 0, -0.649449, 0.760405, 300, 255, 1, 0),(NULL, 193217, 1, 1, 128, 1428.25, -4422.29, 25.1243, -2.9845, 0, 0, -0.996917, 0.0784656, 300, 255, 1, 0),
(NULL, 193217, 1, 1, 128, 1327.95, -4357.13, 27.4334, -1.39626, 0, 0, -0.642786, 0.766046, 300, 255, 1, 0),(NULL, 193218, 1, 1, 128, 1438.4, -4363.5, 25.8465, -1.46608, 0, 0, -0.669132, 0.743144, 300, 255, 1, 0),(NULL, 193218, 1, 1, 128, 1374.88, -4354.89, 26.2083, 2.60053, 0, 0, 0.963629, 0.267244, 300, 255, 1, 0),(NULL, 193218, 1, 1, 128, 1438.47, -4431.58, 25.2354, 0.034906, 0, 0, 0.0174521, 0.999848, 300, 255, 1, 0),(NULL, 193219, 1, 1, 128, 1589.77, -4423.56, 8.23726, 1.93731, 0, 0, 0.824125, 0.566409, 300, 255, 1, 0),(NULL, 193219, 1, 1, 128, 1371.21, -4416.96, 29.6913, 3.14159, 0, 0, 1, 1, 300, 255, 1, 0),(NULL, 193219, 1, 1, 128, 1370.57, -4405.97, 29.6971, 3.05433, 0, 0, 0.999048, 0.0436174, 300, 255, 1, 0);
