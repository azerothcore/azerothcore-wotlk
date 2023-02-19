-- DB update 2023_02_19_00 -> 2023_02_19_01
-- Add Burning Spikes to Domesticated Helboar
UPDATE `creature_template_addon` SET `bytes2` = 0, `auras` = '33908' WHERE (`entry` = 21195);

-- Water Bubble to Captured Water Spirit
DELETE FROM `creature_template_addon` WHERE (`entry` = 21029);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(21029, 0, 0, 0, 0, 0, 0, '35929');

-- Delete ALL Creatures exclusive to Coilskar Cistern
DELETE FROM `creature` WHERE `map`=530 AND `id1` IN (
19765, -- Coilskar Myrmidon
19767, -- Coilskar Sorceress
19788, -- Coilskar Muckwatcher
21029, -- Captured Water Spirit
21041, -- Earthmender Wilda Trigger
21027, -- Earthmender Wilda
21044, -- Coilskar Assassin (Spawned from Escort Quest)
20795  -- Keeper of the Cistern
);

-- Delete Coilskar Cobra in Coilskar Cistern
DELETE FROM `creature` WHERE `id1`=19784 AND `guid` BETWEEN 70801 AND 70807;

DELETE FROM `creature` WHERE `id1` IN (19765,19767,19784,19788,21029,21041,21027,20795) AND `map`=530 AND `ZoneId`=3520 AND `guid` IN (23745,24189,24190,24191,24777,24788,24868,24869,24870,24915,24931,24944,24945,24946,24947,24948,24974,24975,24977,24978,24979,24980,24981,24982,24983,25010,25065,25094,25095,25096,25097,25098,25099,25111,25112,25113,25114,25115,25116,25117,25118,25119,25120,25121,25122,25123,25124,25125,25126,25127,25128,25129,25130,25713,25714,25715,25716,25717,25718,25719,25720,25721,25722,25723,25724,25725,25726,25727,25738,25739,25740,25741,25742,25743,25744);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(23745, 19765, 530, 3520, 3749, 1, 1, 1, -2898.98, 1382.11, 6.15595, 1.85005, 300, 0, 0, 48069),
(24189, 19765, 530, 3520, 3749, 1, 1, 1, -2913.56, 1391.4, 7.13094, 1.0472, 300, 0, 0, 48069),
(24190, 19765, 530, 3520, 3749, 1, 1, 1, -2937.48, 1354.87, 6.92214, 4.7822, 300, 0, 0, 48069),
(24191, 19765, 530, 3520, 3749, 1, 1, 1, -2902.86, 1303.16, 7.15851, 2.37365, 300, 0, 0, 48069),
(24777, 19765, 530, 3520, 3749, 1, 1, 1, -2889.05, 1314.18, 6.65059, 3.40339, 300, 0, 0, 48069),
(24788, 19765, 530, 3520, 3749, 1, 1, 1, -2902.24, 1330.04, 6.77553, 2.79253, 300, 0, 0, 48069),
(24868, 19765, 530, 3520, 3749, 1, 1, 1, -2983.65, 1309.24, 8.58929, 3.71475, 300, 8, 1, 48069),
(24869, 19765, 530, 3520, 3749, 1, 1, 1, -2942.56, 1284.57, 8.16425, 1.88496, 300, 0, 0, 48069),
(24870, 19765, 530, 3520, 3749, 1, 1, 1, -2779.55, 1304.42, 33.4497, 5.93412, 300, 0, 0, 48069),
(24915, 19765, 530, 3520, 3749, 1, 1, 1, -2817.55, 1224.34, 6.25537, 5.38328, 300, 0, 0, 48069),
(24931, 19765, 530, 3520, 3749, 1, 1, 1, -2768.09, 1273.42, 33.7681, 1.5708, 300, 0, 0, 48069),
(24944, 19765, 530, 3520, 3749, 1, 1, 1, -2764.94, 1317.1, 33.5025, 4.85202, 300, 0, 0, 48069),
(24945, 19765, 530, 3520, 3749, 1, 1, 1, -2749.51, 1247.11, 33.245, 1.84797, 300, 0, 0, 48069),
(24946, 19765, 530, 3520, 3749, 1, 1, 2, -2798.67, 1160.3, 6.693, 4.86947, 300, 0, 0, 48069),
(24947, 19765, 530, 3520, 3749, 1, 1, 1, -2787.35, 1148.32, 7.55367, 1.06465, 300, 0, 0, 48069),
(24948, 19765, 530, 3520, 3749, 1, 1, 1, -2628.65, 1223.29, 14.6047, 4.37468, 300, 0, 0, 48069),
(24974, 19765, 530, 3520, 3749, 1, 1, 2, -2725.46, 1268.64, 33.3154, 1.15192, 300, 0, 0, 48069),
(24975, 19765, 530, 3520, 3749, 1, 1, 1, -2641.38, 1229.79, 10.9875, 0.170716, 300, 3, 1, 48069),
(24977, 19765, 530, 3520, 3749, 1, 1, 1, -2677.05, 1381.3, 38.0509, 5.044, 300, 0, 0, 48069),
(24978, 19765, 530, 3520, 3749, 1, 1, 1, -2703.08, 1375.09, 38.6636, 5.88176, 300, 0, 0, 48069),
(24979, 19767, 530, 3520, 3749, 1, 1, 1, -2976.08, 1333.87, 8.76729, 2.2356, 300, 4, 1, 48069),
(24980, 19767, 530, 3520, 3749, 1, 1, 1, -2905.72, 1359.48, 6.14664, 4.48575, 300, 10, 1, 48069),
(24981, 19767, 530, 3520, 3749, 1, 1, 1, -2934.01, 1326.69, 8.1525, 2.81793, 300, 6, 1, 48069),
(24982, 19767, 530, 3520, 3749, 1, 1, 1, -2773.13, 1157.78, 7.20267, 1.13446, 300, 0, 0, 48069),
(24983, 19767, 530, 3520, 3749, 1, 1, 1, -2731.41, 1259.01, 33.7358, 2.93215, 300, 0, 0, 48069),
(25010, 19767, 530, 3520, 3749, 1, 1, 1, -2736.81, 1278.36, 33.3747, 3.22886, 300, 0, 0, 48069),
(25065, 19767, 530, 3520, 3749, 1, 1, 1, -2690.81, 1366.14, 37.1067, 3.80006, 300, 0, 0, 48069),
(25094, 19767, 530, 3520, 3749, 1, 1, 1, -2671.05, 1273.61, 27.3407, 2.36121, 300, 4, 1, 48069),
(25095, 19767, 530, 3520, 3749, 1, 1, 1, -2650.98, 1287.83, 27.5096, 1.27681, 300, 4, 1, 48069),
(25096, 19767, 530, 3520, 3749, 1, 1, 1, -2691.4, 1388.28, 38.6635, 6.05283, 300, 4, 1, 48069),
(25097, 19767, 530, 3520, 3749, 1, 1, 1, -2655.43, 1354.2, 34.7295, 1.23625, 300, 8, 1, 48069),
(25098, 19788, 530, 3520, 3749, 1, 1, 1, -2886.79, 1306.95, 5.7373, 2.81133, 300, 0, 0, 48069),
(25099, 19788, 530, 3520, 3749, 1, 1, 1, -2805.56, 1369.56, 37.8528, 4.43144, 300, 0, 0, 48069),
(25111, 19788, 530, 3520, 3749, 1, 1, 1, -2753.25, 1307.42, 33.4562, 3.61969, 300, 0, 0, 48069),
(25112, 19788, 530, 3520, 3749, 1, 1, 1, -2729.97, 1141.34, 1.72704, 2.91288, 300, 0, 0, 48069),
(25113, 19788, 530, 3520, 3749, 1, 1, 1, -2691.24, 1173.31, 5.5279, 3.77395, 300, 0, 0, 48069),
(25114, 19788, 530, 3520, 3749, 1, 1, 1, -2670.11, 1283.01, 28.1491, 2.8624, 300, 0, 0, 48069),
(25115, 19788, 530, 3520, 3749, 1, 1, 1, -2620.26, 1353.72, 37.1255, 3.66914, 300, 0, 0, 48069),
(25116, 19788, 530, 3520, 3749, 1, 1, 1, -2636.63, 1372.52, 36.0204, 3.98698, 300, 0, 0, 48069),
(25117, 19788, 530, 3520, 3749, 1, 1, 1, -2641.96, 1270.84, 24.3307, 2.474, 300, 0, 0, 48069),
(25118, 20795, 530, 3520, 3749, 1, 1, 1, -2594.66, 1384.33, 44.3154, 6.12077, 300, 5, 1, 48069),
(25119, 21027, 530, 3520, 3749, 1, 1, 0, -2616.36, 1372.07, 46.0286, 3.85718, 300, 0, 0, 48069),
(25120, 21029, 530, 3520, 3749, 1, 1, 0, -2729.85, 1215.23, 48.2141, 1.5708, 300, 0, 0, 48069),
(25121, 21029, 530, 3520, 3749, 1, 1, 0, -2721.25, 1216.49, 41.7782, 1.79769, 300, 0, 0, 48069),
(25122, 21029, 530, 3520, 3749, 1, 1, 0, -2713.19, 1221.69, 38.1432, 2.0944, 300, 0, 0, 48069),
(25123, 21029, 530, 3520, 3749, 1, 1, 0, -2711.53, 1230.92, 37.3221, 2.54818, 300, 0, 0, 48069),
(25124, 21029, 530, 3520, 3749, 1, 1, 0, -2708.88, 1239.1, 38.1921, 3.08923, 300, 0, 0, 48069),
(25125, 21041, 530, 3520, 3749, 1, 1, 0, -2638.89, 1358.96, 36.0438, 3.90954, 300, 0, 0, 48069),
(25126, 21041, 530, 3520, 3749, 1, 1, 0, -2605.25, 1369.39, 49.1248, 4.03171, 300, 0, 0, 48069),
(25127, 21041, 530, 3520, 3749, 1, 1, 0, -2605.53, 1374.24, 45.3846, 5.55015, 300, 0, 0, 48069),
(25128, 21041, 530, 3520, 3749, 1, 1, 0, -2614.51, 1381.27, 51.6831, 5.55015, 300, 0, 0, 48069),
(25129, 21041, 530, 3520, 3749, 1, 1, 0, -2610.76, 1377.7, 41.1437, 3.50811, 300, 0, 0, 48069),
(25130, 21041, 530, 3520, 3749, 1, 1, 0, -2590.76, 1387.65, 55.0794, 4.10152, 300, 0, 0, 48069),
(25713, 19784, 530, 3520, 3749, 1, 1, 0, -2924.55, 1371.39, 9.52825, 5.55015, 300, 0, 0, 48069),
(25714, 19784, 530, 3520, 3749, 1, 1, 0, -2919.43, 1372.64, 8.37301, 6.12611, 300, 0, 0, 48069),
(25715, 19784, 530, 3520, 3749, 1, 1, 0, -2960.01, 1304.2, 7.36165, 0.226893, 300, 0, 0, 48069),
(25716, 19784, 530, 3520, 3749, 1, 1, 0, -2964.3, 1312.32, 7.70759, 0.890118, 300, 0, 0, 48069),
(25717, 19784, 530, 3520, 3749, 1, 1, 0, -2851.26, 1239.81, 6.79606, 3.09596, 300, 5, 1, 48069),
(25718, 19784, 530, 3520, 3749, 1, 1, 0, -2809.98, 1254.89, 26.471, 6.0912, 300, 0, 0, 48069),
(25719, 19784, 530, 3520, 3749, 1, 1, 0, -2842.61, 1249.25, 6.79606, 1.18107, 300, 5, 1, 48069),
(25720, 19784, 530, 3520, 3749, 1, 1, 0, -2810.6, 1257.84, 26.8763, 6.23417, 300, 0, 0, 48069),
(25721, 19784, 530, 3520, 3749, 1, 1, 0, -2738.38, 1148.7, 3.50024, 3.33358, 300, 0, 0, 48069),
(25722, 19784, 530, 3520, 3749, 1, 1, 0, -2741.38, 1138.88, 4.15881, 2.46091, 300, 0, 0, 48069),
(25723, 19784, 530, 3520, 3749, 1, 1, 0, -2639.01, 1256.11, 21.8693, 5.35816, 300, 0, 0, 48069),
(25724, 19784, 530, 3520, 3749, 1, 1, 0, -2628.61, 1256.51, 19.4139, 4.7473, 300, 0, 0, 48069),
(25725, 19784, 530, 3520, 3749, 1, 1, 0, -2702.76, 1318.11, 34.033, 4.45059, 300, 0, 0, 48069),
(25726, 19784, 530, 3520, 3749, 1, 1, 0, -2714.62, 1310.4, 34.1854, 5.3058, 300, 0, 0, 48069),
(25727, 19784, 530, 3520, 3749, 1, 1, 0, -2580.79, 1389.61, 42.4415, 0.820305, 300, 0, 0, 48069),
(25738, 19784, 530, 3520, 3749, 1, 1, 0, -2583.63, 1393.74, 42.5982, 0.471239, 300, 0, 0, 48069),
(25739, 19784, 530, 3520, 3749, 1, 1, 0, -2780.42, 1393.01, 38.8631, 0.873989, 300, 5, 1, 48069),
(25740, 19784, 530, 3520, 3749, 1, 1, 0, -2790.03, 1393.41, 39.1302, 1.59271, 300, 5, 1, 48069),
(25741, 19784, 530, 3520, 3749, 1, 1, 0, -2708.27, 1223.95, 32.8727, 1.35922, 300, 5, 1, 48069),
(25742, 19784, 530, 3520, 3749, 1, 1, 0, -2720.86, 1215.66, 37.045, 2.45076, 300, 5, 1, 48069),
(25743, 19784, 530, 3520, 3749, 1, 1, 0, -2779.55, 1279.2603, 34.014435, 2.45076, 300, 0, 0, 48069),
(25744, 19784, 530, 3520, 3749, 1, 1, 0, -2779.55, 1279.2603, 34.014435, 2.45076, 300, 0, 0, 48069);

SET @NPC := 24915;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2823.2131,`position_y`=1231.4794,`position_z`=6.2438025 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2823.2131,1231.4794,6.2438025,NULL,0,0,0,100,0),
(@PATH,2,-2812.9219,1218.5132,6.26481,NULL,0,0,0,100,0),
(@PATH,3,-2809.2012,1208.1838,6.32249,NULL,0,0,0,100,0),
(@PATH,4,-2806.4219,1203.8843,6.3185363,NULL,0,0,0,100,0),
(@PATH,5,-2809.2012,1208.1838,6.32249,NULL,0,0,0,100,0),
(@PATH,6,-2812.9219,1218.5132,6.26481,NULL,0,0,0,100,0);

SET @NPC := 24948;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2644.4155,`position_y`=1194.6781,`position_z`=6.600725 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2644.4155,1194.6781,6.600725,NULL,0,0,0,100,0),
(@PATH,2,-2634.681,1206.1174,10.327223,NULL,0,0,0,100,0),
(@PATH,3,-2625.3433,1232.7086,16.544775,NULL,0,0,0,100,0),
(@PATH,4,-2634.681,1206.1174,10.327223,NULL,0,0,0,100,0);

SET @NPC := 24945;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2748.4146,`position_y`=1268.3123,`position_z`=33.184956 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2748.4146,1268.3123,33.184956,NULL,0,0,0,100,0),
(@PATH,2,-2753.3994,1260.7609,33.38965,NULL,0,0,0,100,0),
(@PATH,3,-2749.2388,1246.1364,33.239746,NULL,0,0,0,100,0),
(@PATH,4,-2740.1255,1235.6766,33.070683,NULL,0,0,0,100,0),
(@PATH,5,-2722.9575,1231.541,33.249657,NULL,0,0,0,100,0),
(@PATH,6,-2740.1255,1235.6766,33.070683,NULL,0,0,0,100,0),
(@PATH,7,-2749.2388,1246.1364,33.239746,NULL,0,0,0,100,0),
(@PATH,8,-2753.3994,1260.7609,33.38965,NULL,0,0,0,100,0);

SET @NPC := 25112;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2762.0657,`position_y`=1151.654,`position_z`=6.546216 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2762.0657,1151.654,6.546216,NULL,0,0,0,100,0),
(@PATH,2,-2748.221,1145.59,4.7005005,NULL,0,0,0,100,0),
(@PATH,3,-2728.986,1141.1119,1.6215124,NULL,0,0,0,100,0),
(@PATH,4,-2712.8843,1145.7828,2.4614542,NULL,0,0,0,100,0),
(@PATH,5,-2704.414,1160.1536,5.125069,NULL,0,0,0,100,0),
(@PATH,6,-2712.8843,1145.7828,2.4614542,NULL,0,0,0,100,0),
(@PATH,7,-2728.986,1141.1119,1.6215124,NULL,0,0,0,100,0),
(@PATH,8,-2748.221,1145.59,4.7005005,NULL,0,0,0,100,0);

SET @NPC := 25111;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2759.5168,`position_y`=1304.1704,`position_z`=33.314373 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2759.5168,1304.1704,33.314373,NULL,0,0,0,100,0),
(@PATH,2,-2746.1182,1311.1138,33.605423,NULL,0,0,0,100,0),
(@PATH,3,-2719.3152,1324.5756,33.971096,NULL,0,0,0,100,0),
(@PATH,4,-2698.994,1332.9515,34.436684,NULL,0,0,0,100,0),
(@PATH,5,-2683.1274,1345.1252,34.436684,NULL,0,0,0,100,0),
(@PATH,6,-2668.0637,1348.902,34.48238,NULL,0,0,0,100,0),
(@PATH,7,-2683.1274,1345.1252,34.436684,NULL,0,0,0,100,0),
(@PATH,8,-2698.9836,1332.9558,34.436684,NULL,0,0,0,100,0),
(@PATH,9,-2719.3152,1324.5756,33.971096,NULL,0,0,0,100,0),
(@PATH,10,-2746.1182,1311.1138,33.605423,NULL,0,0,0,100,0);

SET @NPC := 25117;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2641.9058,`position_y`=1268.142,`position_z`=23.927183 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,-2641.9058,1268.142,23.927183,NULL,0,0,0,100,0),
(@PATH,2 ,-2650.1309,1277.2792,25.416039,NULL,0,0,0,100,0),
(@PATH,3 ,-2673.4944,1283.977,29.292665,NULL,0,0,0,100,0),
(@PATH,4 ,-2691.0823,1290.7217,33.745926,NULL,0,0,0,100,0),
(@PATH,5 ,-2705.8076,1298.7185,32.94668,NULL,0,0,0,100,0),
(@PATH,6 ,-2709.4016,1314.3235,33.262363,NULL,0,0,0,100,0),
(@PATH,7 ,-2705.8076,1298.7185,32.94668,NULL,0,0,0,100,0),
(@PATH,8 ,-2691.0823,1290.7217,33.745926,NULL,0,0,0,100,0),
(@PATH,9 ,-2673.4944,1283.977,29.292665,NULL,0,0,0,100,0),
(@PATH,10,-2650.1309,1277.2792,25.416039,NULL,0,0,0,100,0);

SET @NPC := 25098;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2912.6753,`position_y`=1318.8967,`position_z`=6.3883452 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,-2912.6753,1318.8967,6.3883452,NULL,0,0,0,100,0),
(@PATH,2 ,-2906.6418,1313.7617,6.6383452,NULL,0,0,0,100,0),
(@PATH,3 ,-2893.7417,1307.0945,6.3466606,NULL,0,0,0,100,0),
(@PATH,4 ,-2880.6794,1305.1588,5.410137,NULL,0,0,0,100,0),
(@PATH,5 ,-2858.01,1298.7424,6.7960815,NULL,0,0,0,100,0),
(@PATH,6 ,-2842.9072,1292.9916,6.1282473,NULL,0,0,0,100,0),
(@PATH,7 ,-2843.1912,1280.0597,7.683124,NULL,0,0,0,100,0),
(@PATH,8 ,-2848.1216,1266.8289,8.083833,NULL,0,0,0,100,0),
(@PATH,9 ,-2853.8364,1255.8324,6.9199033,NULL,0,0,0,100,0),
(@PATH,10,-2842.4497,1243.7681,6.7960606,NULL,0,0,0,100,0),
(@PATH,11,-2853.8364,1255.8324,6.9199033,NULL,0,0,0,100,0),
(@PATH,12,-2848.1216,1266.8289,8.083833,NULL,0,0,0,100,0),
(@PATH,13,-2843.1912,1280.0597,7.683124,NULL,0,0,0,100,0),
(@PATH,14,-2842.9072,1292.9916,6.1282473,NULL,0,0,0,100,0),
(@PATH,15,-2858.01,1298.7424,6.7960815,NULL,0,0,0,100,0),
(@PATH,16,-2880.6794,1305.1588,5.410137,NULL,0,0,0,100,0),
(@PATH,17,-2893.7417,1307.0945,6.3466606,NULL,0,0,0,100,0),
(@PATH,18,-2906.6418,1313.7617,6.6383452,NULL,0,0,0,100,0);

SET @NPC := 25114;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2709.4016,`position_y`=1314.3235,`position_z`=33.262363 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,-2709.4016,1314.3235,33.262363,NULL,0,0,0,100,0),
(@PATH,2 ,-2705.8076,1298.7185,32.94668,NULL,0,0,0,100,0),
(@PATH,3 ,-2691.0823,1290.7217,33.745926,NULL,0,0,0,100,0),
(@PATH,4 ,-2673.4944,1283.977,29.292665,NULL,0,0,0,100,0),
(@PATH,5 ,-2650.1309,1277.2792,25.416039,NULL,0,0,0,100,0),
(@PATH,6 ,-2641.9058,1268.142,23.927183,NULL,0,0,0,100,0),
(@PATH,7 ,-2650.1309,1277.2792,25.416039,NULL,0,0,0,100,0),
(@PATH,8 ,-2673.4944,1283.977,29.292665,NULL,0,0,0,100,0),
(@PATH,9 ,-2691.0823,1290.7217,33.745926,NULL,0,0,0,100,0),
(@PATH,10,-2705.8076,1298.7185,32.94668,NULL,0,0,0,100,0);

SET @NPC := 25116;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2643.4558,`position_y`=1364.8234,`position_z`=35.86493 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,-2643.4558,1364.8234,35.86493,NULL,0,0,0,100,0),
(@PATH,2 ,-2634.716,1374.6797,36.22216,NULL,0,0,0,100,0),
(@PATH,3 ,-2626.5833,1383.2074,37.50213,NULL,0,0,0,100,0),
(@PATH,4 ,-2618.2117,1387.6519,39.28746,NULL,0,0,0,100,0),
(@PATH,5 ,-2611.0234,1393.2262,41.428757,NULL,0,0,0,100,0),
(@PATH,6 ,-2602.1787,1400.6476,41.767567,NULL,0,0,0,100,0),
(@PATH,7 ,-2611.0234,1393.2262,41.428757,NULL,0,0,0,100,0),
(@PATH,8 ,-2618.2117,1387.6519,39.28746,NULL,0,0,0,100,0),
(@PATH,9 ,-2626.5833,1383.2074,37.50213,NULL,0,0,0,100,0),
(@PATH,10,-2634.716,1374.6797,36.22216,NULL,0,0,0,100,0);

SET @NPC := 25099;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2809.3833,`position_y`=1356.3115,`position_z`=37.325497 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2809.3833,1356.3115,37.325497,NULL,0,0,0,100,0),
(@PATH,2,-2804.8496,1338.0927,36.000645,NULL,0,0,0,100,0),
(@PATH,3,-2784.9128,1322.3423,33.37369,NULL,0,0,0,100,0),
(@PATH,4,-2772.6155,1327.1848,33.624535,NULL,0,0,0,100,0),
(@PATH,5,-2767.8467,1360.8962,35.79723,NULL,0,0,0,100,0),
(@PATH,6,-2784.864,1388.3601,38.49067,NULL,0,0,0,100,0),
(@PATH,7,-2801.9087,1382.2137,38.60972,NULL,0,0,0,100,0);

SET @NPC := 25113;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2655.3274,`position_y`=1202.3822,`position_z`=6.115521 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2655.3274,1202.3822,6.115521,NULL,0,0,0,100,0),
(@PATH,2,-2666.605,1190.8188,3.529532,NULL,0,0,0,100,0),
(@PATH,3,-2679.0286,1182.2574,4.7928033,NULL,0,0,0,100,0),
(@PATH,4,-2699.4224,1167.3142,5.547194,NULL,0,0,0,100,0),
(@PATH,5,-2679.0286,1182.2574,4.7928033,NULL,0,0,0,100,0),
(@PATH,6,-2666.6719,1190.7727,3.5094023,NULL,0,0,0,100,0);

SET @NPC := 25115;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2634.4636,`position_y`=1345.4458,`position_z`=35.481934 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2634.4636,1345.4458,35.481934,NULL,0,0,0,100,0),
(@PATH,2,-2620.018,1353.861,37.13554,NULL,0,0,0,100,0),
(@PATH,3,-2598.73,1358.416,38.889954,NULL,0,0,0,100,0),
(@PATH,4,-2590.0383,1365.4989,40.473846,NULL,0,0,0,100,0),
(@PATH,5,-2598.73,1358.416,38.889954,NULL,0,0,0,100,0),
(@PATH,6,-2620.018,1353.861,37.13554,NULL,0,0,0,100,0);

SET @NPC := 25743;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2779.55,`position_y`=1279.2603,`position_z`=34.014435 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2779.55,1279.2603,34.014435,NULL,0,0,0,100,0),
(@PATH,2,-2799.971,1261.2897,33.647408,NULL,0,0,0,100,0),
(@PATH,3,-2810.8,1254.8387,31.11925,NULL,0,0,0,100,0),
(@PATH,4,-2799.971,1261.2897,33.647408,NULL,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (25743, 25744);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(25743, 25743, 0, 0, 3),
(25743, 25744, 3, 90, 515);

-- Sorceress (-25065)
DELETE FROM `waypoints` WHERE `entry`=1976700 AND `point_comment`='Coilskar Sorceress';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(1976700,1,-2699.7734,1352.9802,32.96573,NULL,'Coilskar Sorceress'),
(1976700,2,-2695.3882,1362.5975,35.82666,NULL,'Coilskar Sorceress'),
(1976700,3,-2687.7195,1368.574,37.474815,NULL,'Coilskar Sorceress'),
(1976700,4,-2677.8486,1371.7639,36.15712,NULL,'Coilskar Sorceress'),
(1976700,5,-2668.1536,1368.8298,33.586617,NULL,'Coilskar Sorceress'),
(1976700,6,-2677.8486,1371.7639,36.15712,NULL,'Coilskar Sorceress'),
(1976700,7,-2687.6226,1368.6053,37.475197,NULL,'Coilskar Sorceress'),
(1976700,8,-2695.3882,1362.5975,35.82666,NULL,'Coilskar Sorceress'),
(1976700,9,-2699.7734,1352.9802,32.96573,NULL,'Coilskar Sorceress');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19767);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19767, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2500, 4700, 0, 11, 32011, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - In Combat - Cast \'Water Bolt\''),
(19767, 0, 1, 0, 2, 0, 100, 1, 0, 80, 0, 0, 0, 11, 38026, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Between 0-80% Health - Cast \'Viscous Shield\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -25065);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-25065, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2500, 4700, 0, 11, 32011, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - In Combat - Cast \'Water Bolt\''),
(-25065, 0, 1, 0, 2, 0, 100, 1, 0, 80, 0, 0, 0, 11, 38026, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Between 0-80% Health - Cast \'Viscous Shield\' (No Repeat)'),
(-25065, 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - On Respawn - Set Event Phase 1'),
(-25065, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1976700, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - On Respawn - Start Waypoint'),
(-25065, 0, 1003, 0, 1, 0, 100, 0, 60000, 120000, 60000, 120000, 0, 80, 1976700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Out of Combat - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1976700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1976700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 13000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Actionlist - Pause Waypoint'),
(1976700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 2, 0, 0, 19, 19765, 30, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Actionlist - Move To Closest Creature \'Coilskar Myrmidon\''),
(1976700, 9, 2, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Actionlist - Say Line 0'),
(1976700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 19765, 10, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Actionlist - Set Data 1 1'),
(1976700, 9, 5, 0, 0, 0, 100, 0, 2600, 2600, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 19765, 10, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Actionlist - Set Data 2 2'),
(1976700, 9, 6, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sorceress - Actionlist - Play Emote 15');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19765);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19765, 0, 0, 0, 9, 0, 100, 0, 0, 20, 11500, 13000, 0, 11, 38027, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Myrmidon - Within 0-20 Range - Cast \'Boiling Blood\''),
(19765, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 19767, 10, 0, 0, 0, 0, 0, 0, 'Coilskar Myrmidon - On Data Set 1 1 - Set Orientation Closest Creature \'Coilskar Sorceress\''),
(19765, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Myrmidon - On Data Set 2 2 - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID` IN (19767, 19765) AND `GroupID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Probability`, `Emote`, `BroadcastTextId`, `comment`) VALUES
(19767, 0, 0, 'Stay alert!', 12, 100, 1, 17711, 'Coilskar Sorceress'),
(19767, 0, 1, 'Be wary of intruders.', 12, 100, 1, 17713, 'Coilskar Sorceress'),
(19767, 0, 2, 'We must not fail the master.', 12, 100, 1, 17715, 'Coilskar Sorceress'),
(19765, 0, 0, 'Understood.', 12, 100, 1, 18146, 'Coilskar Myrmidon'),
(19765, 0, 1, 'We will not fail.', 12, 100, 1, 18410, 'Coilskar Myrmidon');

-- EmoteState for Myrmidons
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 19765);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(19765, 1, 28965, 0, 0, 18019),
(19765, 2, 2028, 0, 0, 18019);

DELETE FROM `creature_addon` WHERE `guid` IN (24946, 24974);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(24946,0,0,0,1,173,0, ''),
(24974,0,0,0,1,173,0, '');
