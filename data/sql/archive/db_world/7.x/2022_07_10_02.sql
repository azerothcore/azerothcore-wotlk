-- DB update 2022_07_10_01 -> 2022_07_10_02
--
/*  Defias Pillager - GUID 90358  */


SET @NPC := 90358;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11013.9, `position_y` = 1526.34, `position_z` = 43.5456, `orientation` = 0.872665 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11013.9, 1526.34, 43.5456, 100.0, 0),
(@PATH, 2, -11024.2, 1514.22, 43.0419, 100.0, 5000),
(@PATH, 3, -11033.7, 1520.32, 43.1222, 100.0, 0),
(@PATH, 4, -11040.3, 1523.96, 44.0335, 100.0, 0),
(@PATH, 5, -11046.1, 1525.12, 44.8055, 100.0, 0),
(@PATH, 6, -11052.3, 1525.4, 43.4291, 100.0, 0),
(@PATH, 7, -11060.0, 1527.29, 43.1826, 100.0, 5000),
(@PATH, 8, -11062.1, 1541.59, 43.2847, 100.0, 0),
(@PATH, 9, -11061.8, 1550.5, 43.5759, 100.0, 0),
(@PATH, 10, -11061.6, 1555.51, 43.2883, 100.0, 0),
(@PATH, 11, -11061.5, 1558.3, 43.7854, 100.0, 0),
(@PATH, 12, -11061.4, 1563.31, 44.7892, 100.0, 0),
(@PATH, 13, -11051.2, 1563.06, 43.774, 100.0, 0),
(@PATH, 14, -11040.7, 1563.24, 44.1439, 100.0, 0),
(@PATH, 15, -11035.2, 1561.71, 44.5776, 100.0, 0),
(@PATH, 16, -11025.5, 1558.66, 43.5138, 100.0, 0),
(@PATH, 17, -11014.9, 1555.34, 43.464, 100.0, 0),
(@PATH, 18, -11012.5, 1548.38, 43.2418, 100.0, 0),
(@PATH, 19, -11012.2, 1530.67, 43.8959, 100.0, 0);

/*  Defias Smuggler - GUID 90350  */


SET @NPC := 90350;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10381.3, `position_y` = 1276.99, `position_z` = 43.7388, `orientation` = 1.37881 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10381.3, 1276.99, 43.7388, 100.0, 0),
(@PATH, 2, -10375.2, 1286.1, 39.7524, 100.0, 0),
(@PATH, 3, -10368.6, 1296.23, 39.8004, 100.0, 0),
(@PATH, 4, -10366.3, 1307.64, 40.5539, 100.0, 0),
(@PATH, 5, -10365.8, 1323.52, 43.5592, 100.0, 0),
(@PATH, 6, -10362.8, 1330.4, 45.6286, 100.0, 0),
(@PATH, 7, -10353.7, 1336.09, 49.4501, 100.0, 0),
(@PATH, 8, -10350.1, 1337.0, 50.8949, 100.0, 0),
(@PATH, 9, -10340.1, 1333.29, 53.3552, 100.0, 0),
(@PATH, 10, -10329.0, 1315.43, 56.19, 100.0, 0),
(@PATH, 11, -10331.5, 1304.13, 54.6818, 100.0, 0),
(@PATH, 12, -10334.1, 1292.54, 52.3621, 100.0, 0),
(@PATH, 13, -10335.6, 1284.83, 50.5088, 100.0, 0),
(@PATH, 14, -10339.5, 1258.11, 43.0081, 100.0, 0),
(@PATH, 15, -10340.8, 1246.47, 40.0832, 100.0, 0),
(@PATH, 16, -10340.8, 1234.33, 39.4116, 100.0, 0),
(@PATH, 17, -10339.5, 1230.53, 39.1954, 100.0, 0),
(@PATH, 18, -10335.4, 1224.18, 38.3961, 100.0, 0),
(@PATH, 19, -10333.7, 1220.53, 38.1536, 100.0, 0),
(@PATH, 20, -10325.1, 1217.49, 36.8027, 100.0, 0),
(@PATH, 21, -10320.2, 1220.7, 36.8137, 100.0, 0),
(@PATH, 22, -10317.7, 1215.73, 36.8383, 100.0, 0),
(@PATH, 23, -10326.1, 1207.24, 37.9803, 100.0, 0),
(@PATH, 24, -10329.4, 1205.02, 38.7191, 100.0, 0),
(@PATH, 25, -10336.4, 1201.38, 39.9898, 100.0, 0),
(@PATH, 26, -10343.4, 1201.5, 41.5607, 100.0, 0),
(@PATH, 27, -10349.7, 1206.12, 43.4238, 100.0, 0),
(@PATH, 28, -10363.3, 1220.43, 47.0017, 100.0, 0),
(@PATH, 29, -10368.1, 1226.72, 48.6343, 100.0, 0),
(@PATH, 30, -10377.8, 1238.4, 53.1986, 100.0, 0),
(@PATH, 31, -10384.8, 1246.36, 55.3563, 100.0, 0),
(@PATH, 32, -10385.0, 1254.46, 54.8993, 100.0, 0),
(@PATH, 33, -10384.3, 1265.85, 51.1467, 100.0, 0);

/*  Riverpaw Gnoll - GUID 90339  */


SET @NPC := 90339;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -9733.86, `position_y` = 1033.9, `position_z` = 36.6799, `orientation` = 5.4891 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -9733.86, 1033.9, 36.6799, 100.0, 0),
(@PATH, 2, -9730.37, 1037.65, 36.1886, 100.0, 0),
(@PATH, 3, -9728.65, 1047.72, 35.6938, 100.0, 0),
(@PATH, 4, -9733.25, 1044.45, 36.0473, 100.0, 0),
(@PATH, 5, -9733.25, 1044.45, 36.0473, 100.0, 0),
(@PATH, 6, -9734.38, 1039.72, 36.1325, 100.0, 0),
(@PATH, 7, -9733.14, 1015.86, 37.7528, 100.0, 0),
(@PATH, 8, -9713.75, 990.32, 35.1059, 100.0, 0),
(@PATH, 9, -9728.36, 1002.99, 36.1766, 100.0, 0),
(@PATH, 10, -9733.67, 1029.95, 37.4562, 100.0, 0);

/*  Defias Pillager - GUID 90334  */


SET @NPC := 90334;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10990.4, `position_y` = 1470.57, `position_z` = 43.2027, `orientation` = 6.26153 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10990.4, 1470.57, 43.2027, 100.0, 0),
(@PATH, 2, -10969.7, 1470.42, 43.2836, 100.0, 0),
(@PATH, 3, -10987.0, 1470.77, 43.2028, 100.0, 0),
(@PATH, 4, -11001.9, 1470.2, 43.2028, 100.0, 0),
(@PATH, 5, -11004.8, 1474.26, 43.2719, 100.0, 0),
(@PATH, 6, -11005.6, 1485.05, 43.4474, 100.0, 0),
(@PATH, 7, -11009.5, 1491.76, 43.438, 100.0, 0),
(@PATH, 8, -11015.4, 1495.34, 43.2219, 100.0, 0),
(@PATH, 9, -11016.1, 1498.34, 43.2023, 100.0, 0),
(@PATH, 10, -11012.5, 1507.18, 43.2116, 100.0, 0),
(@PATH, 11, -11006.9, 1512.16, 43.1356, 100.0, 0),
(@PATH, 12, -10992.1, 1515.56, 43.5812, 100.0, 0),
(@PATH, 13, -10984.1, 1515.59, 43.2338, 100.0, 0),
(@PATH, 14, -10972.1, 1515.62, 43.2303, 100.0, 0),
(@PATH, 15, -10952.9, 1515.54, 43.3141, 100.0, 0),
(@PATH, 16, -10973.7, 1515.32, 43.2298, 100.0, 0),
(@PATH, 17, -10981.7, 1515.24, 43.0236, 100.0, 0),
(@PATH, 18, -10988.7, 1515.16, 43.5447, 100.0, 0),
(@PATH, 19, -10999.2, 1515.05, 43.2992, 100.0, 0),
(@PATH, 20, -11007.0, 1513.06, 43.1063, 100.0, 0),
(@PATH, 21, -11012.7, 1508.11, 43.2005, 100.0, 0),
(@PATH, 22, -11016.3, 1498.66, 43.2022, 100.0, 0),
(@PATH, 23, -11013.6, 1494.86, 43.2536, 100.0, 0),
(@PATH, 24, -11008.6, 1488.69, 43.7166, 100.0, 0),
(@PATH, 25, -11006.1, 1482.73, 43.5303, 100.0, 0),
(@PATH, 26, -11003.7, 1472.12, 43.2018, 100.0, 0),
(@PATH, 27, -10998.5, 1470.52, 43.2018, 100.0, 0);

/*  Murloc Oracle - GUID 90114  */


SET @NPC := 90114;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11368.4, `position_y` = 1838.63, `position_z` = 2.56064, `orientation` = 0.141069 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11368.4, 1838.63, 2.56064, 100.0, 0),
(@PATH, 2, -11409.8, 1832.37, -3.20341, 100.0, 0),
(@PATH, 3, -11428.7, 1808.82, -0.126871, 100.0, 0),
(@PATH, 4, -11430.1, 1787.12, 4.75527, 100.0, 0),
(@PATH, 5, -11413.2, 1774.67, 8.57256, 100.0, 0),
(@PATH, 6, -11381.7, 1776.74, 8.93824, 100.0, 0),
(@PATH, 7, -11352.7, 1790.51, 9.28233, 100.0, 0),
(@PATH, 8, -11348.8, 1813.23, 8.39409, 100.0, 0);

/*  Murloc Oracle - GUID 90114  */


SET @NPC := 90114;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11368.4, `position_y` = 1838.63, `position_z` = 2.56064, `orientation` = 0.141069 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11368.4, 1838.63, 2.56064, 100.0, 0),
(@PATH, 2, -11409.8, 1832.37, -3.20341, 100.0, 0),
(@PATH, 3, -11428.7, 1808.82, -0.126871, 100.0, 0),
(@PATH, 4, -11430.1, 1787.12, 4.75527, 100.0, 0),
(@PATH, 5, -11413.2, 1774.67, 8.57256, 100.0, 0),
(@PATH, 6, -11381.7, 1776.74, 8.93824, 100.0, 0),
(@PATH, 7, -11352.7, 1790.51, 9.28233, 100.0, 0),
(@PATH, 8, -11348.8, 1813.23, 8.39409, 100.0, 0);


/*  Defias Trapper - GUID 89446  */


SET @NPC := 89446;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -9865.91, `position_y` = 1282.22, `position_z` = 41.075, `orientation` = 1.45052 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -9865.91, 1282.22, 41.075, 100.0, 0),
(@PATH, 2, -9855.47, 1334.11, 42.0275, 100.0, 0),
(@PATH, 3, -9858.09, 1337.14, 42.0275, 100.0, 0),
(@PATH, 4, -9864.26, 1347.41, 42.2422, 100.0, 0),
(@PATH, 5, -9876.45, 1356.29, 43.304, 100.0, 0),
(@PATH, 6, -9903.66, 1341.49, 42.227, 100.0, 0),
(@PATH, 7, -9909.55, 1327.98, 43.6793, 100.0, 0),
(@PATH, 8, -9907.43, 1312.43, 41.8484, 100.0, 0),
(@PATH, 9, -9888.3, 1289.56, 41.2171, 100.0, 0),
(@PATH, 10, -9881.77, 1286.46, 40.94, 100.0, 0),
(@PATH, 11, -9881.77, 1286.46, 40.94, 100.0, 0),
(@PATH, 12, -9878.98, 1283.59, 40.9402, 100.0, 0),
(@PATH, 13, -9873.12, 1278.0, 41.0067, 100.0, 0),
(@PATH, 14, -9870.62, 1275.69, 41.0454, 100.0, 0);


/*  Defias Trapper - GUID 89455  */


SET @NPC := 89455;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10196.2, `position_y` = 1933.59, `position_z` = 34.3548, `orientation` = 0.243558 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10196.2, 1933.59, 34.3548, 100.0, 0),
(@PATH, 2, -10172.7, 1949.45, 34.5606, 100.0, 0),
(@PATH, 3, -10165.0, 1948.98, 35.6094, 100.0, 0),
(@PATH, 4, -10161.3, 1947.41, 35.578, 100.0, 0),
(@PATH, 5, -10158.1, 1940.82, 35.2363, 100.0, 0),
(@PATH, 6, -10156.6, 1933.68, 35.0369, 100.0, 0),
(@PATH, 7, -10155.6, 1917.85, 34.6293, 100.0, 0),
(@PATH, 8, -10169.5, 1899.29, 34.4169, 100.0, 0),
(@PATH, 9, -10195.8, 1901.09, 36.581, 100.0, 0),
(@PATH, 10, -10208.0, 1901.65, 36.8232, 100.0, 0),
(@PATH, 11, -10219.8, 1911.92, 37.4382, 100.0, 0),
(@PATH, 12, -10216.1, 1913.47, 37.5772, 100.0, 0);


/*  Murloc Netter - GUID 89481  */


SET @NPC := 89481;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -9914.59, `position_y` = 1752.35, `position_z` = 12.8358, `orientation` = 2.50359 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -9914.59, 1752.35, 12.8358, 100.0, 0),
(@PATH, 2, -9902.26, 1752.25, 11.3582, 100.0, 0),
(@PATH, 3, -9881.66, 1765.31, 9.47887, 100.0, 0),
(@PATH, 4, -9875.1, 1775.49, 8.5288, 100.0, 0),
(@PATH, 5, -9874.13, 1783.04, 6.79059, 100.0, 0),
(@PATH, 6, -9874.39, 1794.77, 3.76829, 100.0, 0),
(@PATH, 7, -9903.08, 1808.47, 5.87756, 100.0, 0),
(@PATH, 8, -9914.24, 1806.03, 8.55169, 100.0, 0),
(@PATH, 9, -9923.94, 1799.06, 10.9354, 100.0, 0),
(@PATH, 10, -9927.95, 1775.17, 13.1672, 100.0, 0),
(@PATH, 11, -9926.36, 1766.37, 13.1647, 100.0, 0);


/*  Murloc Hunter - GUID 89482  */


SET @NPC := 89482;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10219.3, `position_y` = 1938.64, `position_z` = 32.0274, `orientation` = 6.21337 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10219.3, 1938.64, 32.0274, 100.0, 0),
(@PATH, 2, -10205.9, 1955.58, 18.9374, 100.0, 0),
(@PATH, 3, -10202.0, 1966.41, 14.6351, 100.0, 0),
(@PATH, 4, -10214.1, 1987.34, 13.7051, 100.0, 0),
(@PATH, 5, -10236.9, 1999.2, 12.8899, 100.0, 0),
(@PATH, 6, -10224.8, 1994.79, 13.1926, 100.0, 0),
(@PATH, 7, -10204.5, 1982.36, 12.4621, 100.0, 0);


/*  Defias Henchman - GUID 89539  */


SET @NPC := 89539;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11094.0, `position_y` = 1515.68, `position_z` = 29.6682, `orientation` = 1.54702 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11094.0, 1515.68, 29.6682, 100.0, 0),
(@PATH, 2, -11097.0, 1508.24, 27.9174, 100.0, 0),
(@PATH, 3, -11102.6, 1502.71, 25.7775, 100.0, 0),
(@PATH, 4, -11108.3, 1499.75, 24.8937, 100.0, 0),
(@PATH, 5, -11111.4, 1499.1, 24.0996, 100.0, 0),
(@PATH, 6, -11122.4, 1500.49, 23.7685, 100.0, 0),
(@PATH, 7, -11128.2, 1503.81, 23.6246, 100.0, 0),
(@PATH, 8, -11135.8, 1510.13, 24.1285, 100.0, 0),
(@PATH, 9, -11140.7, 1515.16, 22.2516, 100.0, 0),
(@PATH, 10, -11145.9, 1520.65, 20.5637, 100.0, 0),
(@PATH, 11, -11140.1, 1513.41, 22.8337, 100.0, 0),
(@PATH, 12, -11136.3, 1509.59, 24.2035, 100.0, 0),
(@PATH, 13, -11127.5, 1503.32, 23.4235, 100.0, 0),
(@PATH, 14, -11122.0, 1500.11, 23.8235, 100.0, 0),
(@PATH, 15, -11112.4, 1499.08, 24.0635, 100.0, 0),
(@PATH, 16, -11109.1, 1499.75, 24.8094, 100.0, 0),
(@PATH, 17, -11102.8, 1502.75, 25.7257, 100.0, 0),
(@PATH, 18, -11097.4, 1508.22, 27.8733, 100.0, 0),
(@PATH, 19, -11095.5, 1510.28, 28.3437, 100.0, 0);


/*  Defias Henchman - GUID 89540  */


SET @NPC := 89540;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11230.1, `position_y` = 1552.47, `position_z` = 34.8252, `orientation` = 4.01685 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11230.1, 1552.47, 34.8252, 100.0, 0),
(@PATH, 2, -11221.9, 1560.27, 33.6759, 100.0, 0),
(@PATH, 3, -11216.5, 1564.62, 32.1784, 100.0, 0),
(@PATH, 4, -11211.7, 1569.23, 30.0665, 100.0, 0),
(@PATH, 5, -11205.5, 1573.36, 29.1579, 100.0, 0),
(@PATH, 6, -11199.0, 1578.48, 28.3536, 100.0, 0),
(@PATH, 7, -11189.8, 1580.01, 27.5988, 100.0, 0),
(@PATH, 8, -11197.1, 1579.18, 28.0992, 100.0, 0),
(@PATH, 9, -11202.9, 1576.39, 28.8413, 100.0, 0),
(@PATH, 10, -11211.4, 1571.1, 29.7876, 100.0, 0),
(@PATH, 11, -11216.1, 1565.64, 31.6509, 100.0, 0),
(@PATH, 12, -11219.5, 1562.13, 32.8494, 100.0, 0),
(@PATH, 13, -11223.8, 1558.48, 33.8651, 100.0, 0);


/*  Defias Conjurer - GUID 89542  */


SET @NPC := 89542;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11134.2, 1487.29, 34.4006, 100.0, 0),
(@PATH, 2, -11130.9, 1481.86, 34.0631, 100.0, 0),
(@PATH, 3, -11125.8, 1479.81, 34.1457, 100.0, 0),
(@PATH, 4, -11120.4, 1480.2, 33.394, 100.0, 0),
(@PATH, 5, -11118.1, 1480.34, 32.8811, 100.0, 1000),
(@PATH, 6, -11122.2, 1479.99, 33.7389, 100.0, 0),
(@PATH, 7, -11126.2, 1480.33, 34.1436, 100.0, 0),
(@PATH, 8, -11131.2, 1482.19, 34.034, 100.0, 0),
(@PATH, 9, -11134.0, 1487.54, 34.4618, 100.0, 0),
(@PATH, 10, -11133.2, 1493.89, 35.4293, 100.0, 0),
(@PATH, 11, -11131.7, 1496.18, 36.0648, 100.0, 0),
(@PATH, 12, -11126.5, 1505.59, 36.0837, 100.0, 0),
(@PATH, 13, -11124.0, 1508.4, 35.368, 100.0, 0),
(@PATH, 14, -11115.8, 1513.71, 32.2482, 100.0, 0),
(@PATH, 15, -11109.8, 1518.14, 31.0309, 100.0, 0),
(@PATH, 16, -11106.1, 1521.27, 30.5751, 100.0, 0),
(@PATH, 17, -11101.2, 1523.96, 30.0775, 100.0, 0),
(@PATH, 18, -11106.4, 1520.33, 30.5448, 100.0, 0),
(@PATH, 19, -11111.2, 1516.98, 31.3695, 100.0, 0),
(@PATH, 20, -11116.8, 1513.1, 32.536, 100.0, 0),
(@PATH, 21, -11122.2, 1509.78, 34.584, 100.0, 0),
(@PATH, 22, -11125.6, 1508.02, 35.8518, 100.0, 0),
(@PATH, 23, -11127.0, 1504.95, 36.2006, 100.0, 0),
(@PATH, 24, -11132.0, 1496.91, 36.0692, 100.0, 0),
(@PATH, 25, -11133.2, 1495.18, 35.8511, 100.0, 0),
(@PATH, 26, -11134.4, 1492.74, 35.1301, 100.0, 0);


/*  Defias Conjurer - GUID 89543  */


SET @NPC := 89543;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11225.8, `position_y` = 1599.5, `position_z` = 32.5048, `orientation` = 4.57128 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11225.8, 1599.5, 32.5048, 100.0, 0),
(@PATH, 2, -11231.4, 1593.3, 32.3584, 100.0, 0),
(@PATH, 3, -11236.7, 1591.89, 32.5344, 100.0, 0),
(@PATH, 4, -11241.9, 1591.47, 33.9402, 100.0, 0),
(@PATH, 5, -11249.0, 1589.34, 33.8443, 100.0, 0),
(@PATH, 6, -11254.4, 1583.28, 33.6242, 100.0, 0),
(@PATH, 7, -11257.1, 1576.84, 34.4809, 100.0, 0),
(@PATH, 8, -11258.3, 1572.04, 34.2398, 100.0, 0),
(@PATH, 9, -11258.7, 1563.69, 33.8814, 100.0, 0),
(@PATH, 10, -11255.9, 1558.79, 34.0503, 100.0, 0),
(@PATH, 11, -11250.9, 1557.46, 34.1264, 100.0, 0),
(@PATH, 12, -11246.4, 1556.22, 34.3026, 100.0, 0),
(@PATH, 13, -11240.4, 1553.9, 34.0097, 100.0, 0),
(@PATH, 14, -11235.2, 1551.54, 34.6532, 100.0, 0),
(@PATH, 15, -11231.0, 1549.0, 34.6751, 100.0, 0),
(@PATH, 16, -11227.1, 1546.37, 33.2081, 100.0, 0),
(@PATH, 17, -11223.6, 1540.88, 33.363, 100.0, 0),
(@PATH, 18, -11225.3, 1536.64, 35.8336, 100.0, 0),
(@PATH, 19, -11227.4, 1532.78, 36.3449, 100.0, 0),
(@PATH, 20, -11225.6, 1536.5, 35.8424, 100.0, 0),
(@PATH, 21, -11224.2, 1541.66, 33.3484, 100.0, 0),
(@PATH, 22, -11227.0, 1547.04, 33.0505, 100.0, 0),
(@PATH, 23, -11231.6, 1550.07, 34.7343, 100.0, 0),
(@PATH, 24, -11236.6, 1552.22, 34.5733, 100.0, 0),
(@PATH, 25, -11240.9, 1553.79, 34.0058, 100.0, 0),
(@PATH, 26, -11248.2, 1555.38, 34.512, 100.0, 0),
(@PATH, 27, -11256.0, 1557.74, 34.1733, 100.0, 0),
(@PATH, 28, -11258.9, 1564.62, 33.9098, 100.0, 0),
(@PATH, 29, -11257.8, 1572.19, 34.2096, 100.0, 0),
(@PATH, 30, -11256.3, 1578.33, 34.4142, 100.0, 0),
(@PATH, 31, -11254.2, 1584.0, 33.5165, 100.0, 0),
(@PATH, 32, -11248.9, 1588.66, 33.9453, 100.0, 0),
(@PATH, 33, -11243.6, 1590.26, 34.1238, 100.0, 0),
(@PATH, 34, -11241.0, 1590.71, 33.9038, 100.0, 0),
(@PATH, 35, -11235.8, 1591.62, 32.4636, 100.0, 0),
(@PATH, 36, -11230.0, 1594.15, 32.2135, 100.0, 0),
(@PATH, 37, -11226.3, 1599.69, 32.5146, 100.0, 0),
(@PATH, 38, -11224.9, 1603.64, 32.8318, 100.0, 0),
(@PATH, 39, -11224.8, 1609.44, 32.4755, 100.0, 0),
(@PATH, 40, -11225.2, 1618.89, 32.7543, 100.0, 0),
(@PATH, 41, -11225.1, 1609.8, 32.5821, 100.0, 0);


/*  Defias Conjurer - GUID 89544  */


SET @NPC := 89544;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11175.1, 1557.35, 20.8878, 100.0, 0),
(@PATH, 2, -11176.8, 1551.92, 19.7929, 100.0, 0),
(@PATH, 3, -11180.2, 1543.6, 19.1841, 100.0, 0),
(@PATH, 4, -11176.0, 1541.38, 19.5086, 100.0, 0),
(@PATH, 5, -11171.2, 1538.67, 19.9968, 100.0, 0),
(@PATH, 6, -11172.0, 1528.09, 19.4731, 100.0, 0),
(@PATH, 7, -11174.8, 1525.48, 19.2678, 100.0, 0),
(@PATH, 8, -11179.1, 1522.45, 18.2682, 100.0, 0),
(@PATH, 9, -11183.2, 1521.24, 18.8178, 100.0, 0),
(@PATH, 10, -11187.9, 1520.28, 19.0749, 100.0, 0),
(@PATH, 11, -11195.8, 1516.17, 19.2995, 100.0, 0),
(@PATH, 12, -11188.3, 1520.47, 19.0449, 100.0, 0),
(@PATH, 13, -11182.0, 1521.92, 18.5771, 100.0, 0),
(@PATH, 14, -11179.2, 1522.0, 18.1742, 100.0, 0),
(@PATH, 15, -11173.0, 1524.07, 19.5604, 100.0, 0),
(@PATH, 16, -11171.3, 1529.91, 19.4338, 100.0, 0),
(@PATH, 17, -11171.5, 1539.58, 20.0647, 100.0, 0),
(@PATH, 18, -11179.8, 1543.5, 19.2262, 100.0, 0),
(@PATH, 19, -11178.3, 1548.47, 19.2018, 100.0, 0),
(@PATH, 20, -11176.9, 1552.79, 19.885, 100.0, 0),
(@PATH, 21, -11174.8, 1558.16, 21.0343, 100.0, 0),
(@PATH, 22, -11173.3, 1562.81, 21.6115, 100.0, 0),
(@PATH, 23, -11173.8, 1566.87, 22.0143, 100.0, 0),
(@PATH, 24, -11174.1, 1561.54, 21.5484, 100.0, 0);


/*  Defias Henchman - GUID 89545  */


SET @NPC := 89545;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11197.1, 1483.13, 14.7718, 100.0, 0),
(@PATH, 2, -11194.6, 1481.43, 15.2471, 100.0, 0),
(@PATH, 3, -11185.8, 1475.91, 15.1833, 100.0, 0),
(@PATH, 4, -11192.3, 1479.89, 15.0735, 100.0, 0),
(@PATH, 5, -11195.2, 1481.87, 15.2271, 100.0, 0),
(@PATH, 6, -11200.0, 1484.69, 14.3403, 100.0, 0),
(@PATH, 7, -11203.3, 1486.41, 14.1811, 100.0, 0),
(@PATH, 8, -11207.5, 1485.28, 15.2073, 100.0, 0),
(@PATH, 9, -11213.0, 1484.44, 16.3027, 100.0, 0),
(@PATH, 10, -11217.4, 1483.69, 17.1971, 100.0, 0),
(@PATH, 11, -11221.6, 1483.33, 17.18, 100.0, 0),
(@PATH, 12, -11225.2, 1482.19, 18.4761, 100.0, 0),
(@PATH, 13, -11221.6, 1483.51, 17.2067, 100.0, 0),
(@PATH, 14, -11216.3, 1483.23, 17.0766, 100.0, 0),
(@PATH, 15, -11211.0, 1484.23, 15.5416, 100.0, 0),
(@PATH, 16, -11206.8, 1485.7, 15.0362, 100.0, 0),
(@PATH, 17, -11203.1, 1486.92, 14.1065, 100.0, 0),
(@PATH, 18, -11203.6, 1492.16, 14.5976, 100.0, 0),
(@PATH, 19, -11203.9, 1497.3, 15.6943, 100.0, 0),
(@PATH, 20, -11203.4, 1500.5, 16.8106, 100.0, 0),
(@PATH, 21, -11201.4, 1505.96, 17.7007, 100.0, 0),
(@PATH, 22, -11200.3, 1509.78, 17.1463, 100.0, 0),
(@PATH, 23, -11201.2, 1504.96, 17.7165, 100.0, 0),
(@PATH, 24, -11202.0, 1501.27, 17.0266, 100.0, 0),
(@PATH, 25, -11203.0, 1495.52, 14.9367, 100.0, 0),
(@PATH, 26, -11202.6, 1491.69, 14.3678, 100.0, 0),
(@PATH, 27, -11202.7, 1488.68, 13.9171, 100.0, 0),
(@PATH, 28, -11207.4, 1485.98, 15.1297, 100.0, 0),
(@PATH, 29, -11212.1, 1484.39, 16.0848, 100.0, 0),
(@PATH, 30, -11217.2, 1483.14, 17.1309, 100.0, 0),
(@PATH, 31, -11222.3, 1483.82, 17.3443, 100.0, 0),
(@PATH, 32, -11225.5, 1481.97, 18.5549, 100.0, 0),
(@PATH, 33, -11221.9, 1483.21, 17.1994, 100.0, 0),
(@PATH, 34, -11216.1, 1483.39, 17.0702, 100.0, 0),
(@PATH, 35, -11211.8, 1484.46, 15.9843, 100.0, 0),
(@PATH, 36, -11207.2, 1485.61, 15.114, 100.0, 0),
(@PATH, 37, -11202.8, 1485.76, 14.2358, 100.0, 0),
(@PATH, 38, -11199.4, 1484.85, 14.3099, 100.0, 0);


/*  Defias Henchman - GUID 89546  */


SET @NPC := 89546;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11138.1, `position_y` = 1539.61, `position_z` = 19.8672, `orientation` = 1.03873 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11138.1, 1539.61, 19.8672, 100.0, 0),
(@PATH, 2, -11139.3, 1544.8, 20.0026, 100.0, 0),
(@PATH, 3, -11143.5, 1549.38, 20.3499, 100.0, 0),
(@PATH, 4, -11147.0, 1554.18, 20.5807, 100.0, 0),
(@PATH, 5, -11152.0, 1560.88, 21.135, 100.0, 0),
(@PATH, 6, -11154.2, 1565.87, 20.6251, 100.0, 0),
(@PATH, 7, -11157.6, 1569.39, 22.1427, 100.0, 0),
(@PATH, 8, -11160.5, 1570.58, 22.6205, 100.0, 0),
(@PATH, 9, -11167.3, 1570.8, 22.3262, 100.0, 0),
(@PATH, 10, -11159.5, 1570.13, 22.557, 100.0, 0),
(@PATH, 11, -11156.8, 1568.41, 21.8058, 100.0, 0),
(@PATH, 12, -11154.1, 1565.52, 20.6765, 100.0, 0),
(@PATH, 13, -11151.9, 1561.47, 21.133, 100.0, 0),
(@PATH, 14, -11149.3, 1556.3, 20.6631, 100.0, 0),
(@PATH, 15, -11144.0, 1549.96, 20.4302, 100.0, 0),
(@PATH, 16, -11139.1, 1544.44, 19.9948, 100.0, 0),
(@PATH, 17, -11138.5, 1540.12, 19.8858, 100.0, 0),
(@PATH, 18, -11138.9, 1537.73, 19.8196, 100.0, 0),
(@PATH, 19, -11142.0, 1531.21, 19.8486, 100.0, 0),
(@PATH, 20, -11145.4, 1526.58, 20.6125, 100.0, 0),
(@PATH, 21, -11142.1, 1531.45, 19.8534, 100.0, 0);


/*  Defias Magician - GUID 89547  */


SET @NPC := 89547;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11248.1, `position_y` = 1540.82, `position_z` = 30.3923, `orientation` = 4.05791 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11248.1, 1540.82, 30.3923, 100.0, 0),
(@PATH, 2, -11250.1, 1535.74, 28.794, 100.0, 0),
(@PATH, 3, -11248.0, 1529.0, 28.5427, 100.0, 0),
(@PATH, 4, -11242.7, 1522.63, 29.0852, 100.0, 0),
(@PATH, 5, -11239.2, 1518.81, 29.4526, 100.0, 0),
(@PATH, 6, -11235.6, 1514.86, 28.9362, 100.0, 0),
(@PATH, 7, -11231.8, 1508.71, 27.3691, 100.0, 0),
(@PATH, 8, -11231.5, 1505.13, 26.7057, 100.0, 0),
(@PATH, 9, -11232.9, 1499.5, 24.6279, 100.0, 0),
(@PATH, 10, -11235.3, 1495.83, 24.0899, 100.0, 0),
(@PATH, 11, -11239.0, 1491.15, 23.2676, 100.0, 0),
(@PATH, 12, -11243.4, 1486.42, 23.3557, 100.0, 0),
(@PATH, 13, -11244.8, 1481.92, 23.4936, 100.0, 0),
(@PATH, 14, -11245.9, 1475.25, 23.2748, 100.0, 0),
(@PATH, 15, -11243.6, 1485.17, 23.4756, 100.0, 0),
(@PATH, 16, -11240.2, 1489.71, 23.1676, 100.0, 0),
(@PATH, 17, -11236.1, 1494.49, 23.8889, 100.0, 0),
(@PATH, 18, -11232.7, 1500.2, 24.7314, 100.0, 0),
(@PATH, 19, -11231.9, 1504.27, 26.3206, 100.0, 0),
(@PATH, 20, -11232.1, 1508.78, 27.4447, 100.0, 0),
(@PATH, 21, -11233.2, 1512.05, 28.2267, 100.0, 0),
(@PATH, 22, -11236.2, 1515.27, 29.0431, 100.0, 0),
(@PATH, 23, -11240.1, 1519.18, 29.5584, 100.0, 0),
(@PATH, 24, -11245.4, 1524.08, 28.7879, 100.0, 0),
(@PATH, 25, -11248.6, 1528.17, 28.8883, 100.0, 0),
(@PATH, 26, -11249.4, 1531.72, 28.3138, 100.0, 0),
(@PATH, 27, -11249.7, 1538.15, 28.9969, 100.0, 0),
(@PATH, 28, -11247.3, 1541.78, 31.0061, 100.0, 0),
(@PATH, 29, -11243.8, 1546.86, 33.499, 100.0, 0),
(@PATH, 30, -11242.0, 1549.11, 34.077, 100.0, 0),
(@PATH, 31, -11244.8, 1544.96, 32.8711, 100.0, 0);


/*  Defias Watchman - GUID 89548  */


SET @NPC := 89548;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11243.4, `position_y` = 1644.96, `position_z` = 28.3952, `orientation` = 5.21458 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11243.4, 1644.96, 28.3952, 100.0, 0),
(@PATH, 2, -11240.1, 1639.82, 27.247, 100.0, 0),
(@PATH, 3, -11235.7, 1634.67, 26.5843, 100.0, 0),
(@PATH, 4, -11230.2, 1629.99, 26.6885, 100.0, 0),
(@PATH, 5, -11234.9, 1632.98, 26.5913, 100.0, 0),
(@PATH, 6, -11238.5, 1637.99, 26.721, 100.0, 0),
(@PATH, 7, -11241.5, 1641.15, 27.7996, 100.0, 0),
(@PATH, 8, -11244.2, 1646.21, 29.0121, 100.0, 0),
(@PATH, 9, -11246.3, 1650.37, 31.178, 100.0, 0),
(@PATH, 10, -11247.5, 1652.76, 32.6129, 100.0, 0),
(@PATH, 11, -11247.5, 1656.95, 33.1515, 100.0, 0),
(@PATH, 12, -11242.7, 1660.01, 33.1569, 100.0, 0),
(@PATH, 13, -11237.5, 1660.08, 33.4376, 100.0, 0),
(@PATH, 14, -11232.7, 1658.87, 33.6492, 100.0, 0),
(@PATH, 15, -11228.1, 1654.63, 33.7588, 100.0, 0),
(@PATH, 16, -11225.6, 1647.44, 33.9664, 100.0, 0),
(@PATH, 17, -11225.3, 1645.56, 34.0018, 100.0, 0),
(@PATH, 18, -11225.0, 1641.48, 33.5206, 100.0, 0),
(@PATH, 19, -11225.0, 1635.55, 34.3171, 100.0, 0),
(@PATH, 20, -11225.1, 1630.86, 34.3065, 100.0, 0),
(@PATH, 21, -11225.2, 1626.43, 33.8627, 100.0, 0),
(@PATH, 22, -11225.2, 1621.65, 32.8276, 100.0, 0),
(@PATH, 23, -11225.1, 1625.67, 33.6907, 100.0, 0),
(@PATH, 24, -11225.0, 1631.38, 34.3498, 100.0, 0),
(@PATH, 25, -11225.0, 1635.81, 34.3142, 100.0, 0),
(@PATH, 26, -11225.4, 1642.32, 33.5582, 100.0, 0),
(@PATH, 27, -11225.6, 1645.7, 34.0176, 100.0, 0),
(@PATH, 28, -11226.1, 1651.15, 33.8824, 100.0, 0),
(@PATH, 29, -11229.5, 1656.02, 33.6558, 100.0, 0),
(@PATH, 30, -11234.7, 1659.15, 33.6779, 100.0, 0),
(@PATH, 31, -11240.8, 1660.11, 33.0679, 100.0, 0),
(@PATH, 32, -11246.4, 1658.1, 33.1507, 100.0, 0),
(@PATH, 33, -11247.3, 1652.35, 32.4744, 100.0, 0),
(@PATH, 34, -11246.9, 1650.45, 31.378, 100.0, 0);


/*  Defias Watchman - GUID 89549  */


SET @NPC := 89549;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11209.5, `position_y` = 1630.75, `position_z` = 27.6946, `orientation` = 6.08786 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11209.5, 1630.75, 27.6946, 100.0, 0),
(@PATH, 2, -11207.5, 1630.12, 27.9765, 100.0, 0),
(@PATH, 3, -11200.3, 1628.43, 28.2547, 100.0, 0),
(@PATH, 4, -11196.0, 1627.64, 28.298, 100.0, 0),
(@PATH, 5, -11191.2, 1626.44, 27.7467, 100.0, 0),
(@PATH, 6, -11186.5, 1623.49, 27.4069, 100.0, 0),
(@PATH, 7, -11181.6, 1623.12, 27.4995, 100.0, 0),
(@PATH, 8, -11177.2, 1624.82, 26.8471, 100.0, 0),
(@PATH, 9, -11172.7, 1627.88, 26.7131, 100.0, 0),
(@PATH, 10, -11170.2, 1632.69, 25.8934, 100.0, 0),
(@PATH, 11, -11172.3, 1628.27, 26.633, 100.0, 0),
(@PATH, 12, -11177.8, 1624.46, 26.9755, 100.0, 0),
(@PATH, 13, -11182.2, 1623.12, 27.5322, 100.0, 0),
(@PATH, 14, -11187.2, 1623.67, 27.4429, 100.0, 0),
(@PATH, 15, -11192.9, 1627.5, 27.8782, 100.0, 0),
(@PATH, 16, -11198.3, 1627.88, 28.4775, 100.0, 0),
(@PATH, 17, -11203.6, 1628.7, 28.1579, 100.0, 0),
(@PATH, 18, -11209.9, 1630.88, 27.6221, 100.0, 0),
(@PATH, 19, -11214.5, 1631.01, 27.3626, 100.0, 0),
(@PATH, 20, -11218.1, 1630.43, 27.5549, 100.0, 0),
(@PATH, 21, -11215.0, 1630.64, 27.4725, 100.0, 0);


/*  Defias Watchman - GUID 89552  */


SET @NPC := 89552;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11275.5, `position_y` = 1514.45, `position_z` = 37.4291, `orientation` = 5.74718 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11275.5, 1514.45, 37.4291, 100.0, 0),
(@PATH, 2, -11276.2, 1526.52, 37.8871, 100.0, 0),
(@PATH, 3, -11276.8, 1534.65, 37.7208, 100.0, 0),
(@PATH, 4, -11276.3, 1522.64, 37.7833, 100.0, 0),
(@PATH, 5, -11276.2, 1518.6, 37.7137, 100.0, 0),
(@PATH, 6, -11272.3, 1512.54, 37.6033, 100.0, 0),
(@PATH, 7, -11265.1, 1509.08, 37.602, 100.0, 0),
(@PATH, 8, -11253.8, 1508.86, 37.0322, 100.0, 0),
(@PATH, 9, -11246.9, 1512.06, 37.6119, 100.0, 0),
(@PATH, 10, -11232.6, 1524.94, 36.5898, 100.0, 0),
(@PATH, 11, -11238.3, 1519.31, 37.3898, 100.0, 0),
(@PATH, 12, -11248.0, 1511.29, 37.596, 100.0, 0),
(@PATH, 13, -11255.3, 1508.63, 37.0006, 100.0, 0),
(@PATH, 14, -11262.9, 1508.45, 38.5104, 100.0, 0);


/*  Skeletal Miner - GUID 89571  */


SET @NPC := 89571;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11298.4, `position_y` = 1541.34, `position_z` = 36.2275, `orientation` = 2.48481 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11298.4, 1541.34, 36.2275, 100.0, 0),
(@PATH, 2, -11299.1, 1550.36, 35.0483, 100.0, 0),
(@PATH, 3, -11298.7, 1557.11, 35.2341, 100.0, 0),
(@PATH, 4, -11299.3, 1558.21, 35.9197, 100.0, 0),
(@PATH, 5, -11297.9, 1563.77, 35.8406, 100.0, 0),
(@PATH, 6, -11293.2, 1568.2, 36.4277, 100.0, 0),
(@PATH, 7, -11291.2, 1573.17, 36.4677, 100.0, 0),
(@PATH, 8, -11290.8, 1578.81, 36.2772, 100.0, 0),
(@PATH, 9, -11291.0, 1582.19, 36.3787, 100.0, 0),
(@PATH, 10, -11293.1, 1586.51, 34.3967, 100.0, 0),
(@PATH, 11, -11290.6, 1582.5, 36.401, 100.0, 0),
(@PATH, 12, -11291.6, 1573.55, 36.4412, 100.0, 0),
(@PATH, 13, -11294.0, 1568.91, 36.3576, 100.0, 0),
(@PATH, 14, -11297.7, 1563.42, 35.8459, 100.0, 0),
(@PATH, 15, -11299.0, 1558.56, 35.9184, 100.0, 0),
(@PATH, 16, -11298.9, 1555.66, 34.9815, 100.0, 0),
(@PATH, 17, -11299.0, 1548.78, 35.1173, 100.0, 0);


/*  Defias Trapper - GUID 89580  */


SET @NPC := 89580;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10272.4, `position_y` = 1389.16, `position_z` = 39.8143, `orientation` = 1.09613 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10272.4, 1389.16, 39.8143, 100.0, 0),
(@PATH, 2, -10269.1, 1383.22, 40.0638, 100.0, 0),
(@PATH, 3, -10271.1, 1378.12, 40.3763, 100.0, 0),
(@PATH, 4, -10264.8, 1362.0, 41.7079, 100.0, 0),
(@PATH, 5, -10268.2, 1354.66, 42.3306, 100.0, 0),
(@PATH, 6, -10280.5, 1345.8, 42.4084, 100.0, 0),
(@PATH, 7, -10296.5, 1344.48, 40.745, 100.0, 0),
(@PATH, 8, -10300.2, 1346.06, 40.4689, 100.0, 0),
(@PATH, 9, -10310.4, 1352.34, 40.7874, 100.0, 0),
(@PATH, 10, -10315.4, 1366.59, 40.2821, 100.0, 0),
(@PATH, 11, -10309.4, 1381.76, 40.4122, 100.0, 0),
(@PATH, 12, -10285.4, 1391.57, 40.1888, 100.0, 0);


/*  Riverpaw Mongrel - GUID 89608  */


SET @NPC := 89608;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10627.1, `position_y` = 1921.69, `position_z` = 44.6054, `orientation` = 2.94496 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10627.1, 1921.69, 44.6054, 100.0, 0),
(@PATH, 2, -10606.5, 1909.1, 42.1032, 100.0, 0),
(@PATH, 3, -10598.6, 1908.01, 41.615, 100.0, 0),
(@PATH, 4, -10588.5, 1913.88, 39.8285, 100.0, 0),
(@PATH, 5, -10579.0, 1930.5, 35.4542, 100.0, 0),
(@PATH, 6, -10577.5, 1946.43, 35.7899, 100.0, 0),
(@PATH, 7, -10581.7, 1970.09, 35.1459, 100.0, 0),
(@PATH, 8, -10611.2, 1977.96, 39.4256, 100.0, 0),
(@PATH, 9, -10645.1, 1952.56, 36.3332, 100.0, 0);


/*  Defias Looter - GUID 89854  */


SET @NPC := 89854;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10559.6, `position_y` = 1963.24, `position_z` = -4.16059, `orientation` = 2.22827 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10559.6, 1963.24, -4.16059, 100.0, 0),
(@PATH, 2, -10557.0, 1960.16, -3.6813, 100.0, 0),
(@PATH, 3, -10552.0, 1955.1, -2.11934, 100.0, 0),
(@PATH, 4, -10545.1, 1949.99, 0.710735, 100.0, 0),
(@PATH, 5, -10530.0, 1943.98, 3.47681, 100.0, 0),
(@PATH, 6, -10519.3, 1946.39, 4.41357, 100.0, 0),
(@PATH, 7, -10511.5, 1960.43, 7.24038, 100.0, 0),
(@PATH, 8, -10507.2, 1966.95, 8.97882, 100.0, 0),
(@PATH, 9, -10509.8, 1963.67, 8.09104, 100.0, 0),
(@PATH, 10, -10517.8, 1949.99, 4.70008, 100.0, 0),
(@PATH, 11, -10523.7, 1945.09, 4.12331, 100.0, 0),
(@PATH, 12, -10538.7, 1946.93, 2.26992, 100.0, 0);


/*  Murloc Warrior - GUID 89945  */


SET @NPC := 89945;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10194.1, `position_y` = 2000.96, `position_z` = 10.1692, `orientation` = 3.20151 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10194.1, 2000.96, 10.1692, 100.0, 0),
(@PATH, 2, -10228.4, 2004.84, 12.3037, 100.0, 0),
(@PATH, 3, -10230.8, 2013.02, 12.5739, 100.0, 0),
(@PATH, 4, -10205.1, 2043.05, 4.62464, 100.0, 0),
(@PATH, 5, -10178.8, 2031.62, 4.20453, 100.0, 0),
(@PATH, 6, -10173.9, 2025.71, 6.4271, 100.0, 0),
(@PATH, 7, -10171.9, 2016.29, 6.86461, 100.0, 0);


/*  Skeletal Miner - GUID 89989  */


SET @NPC := 89989;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11341.2, `position_y` = 1568.69, `position_z` = 32.3883, `orientation` = 3.85718 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11341.2, 1568.69, 32.3883, 100.0, 0),
(@PATH, 2, -11343.8, 1560.84, 31.8406, 100.0, 0),
(@PATH, 3, -11344.4, 1555.17, 30.7656, 100.0, 0),
(@PATH, 4, -11343.1, 1547.98, 28.7201, 100.0, 0),
(@PATH, 5, -11340.2, 1542.73, 28.5754, 100.0, 0),
(@PATH, 6, -11336.6, 1539.72, 29.0597, 100.0, 0),
(@PATH, 7, -11332.6, 1539.87, 29.0933, 100.0, 0),
(@PATH, 8, -11327.8, 1543.21, 28.6285, 100.0, 0),
(@PATH, 9, -11324.7, 1549.85, 27.9406, 100.0, 0),
(@PATH, 10, -11324.6, 1553.88, 27.2777, 100.0, 0),
(@PATH, 11, -11325.9, 1558.22, 26.4931, 100.0, 0),
(@PATH, 12, -11324.7, 1550.65, 27.813, 100.0, 0),
(@PATH, 13, -11325.7, 1544.95, 28.6396, 100.0, 0),
(@PATH, 14, -11331.5, 1539.43, 28.9613, 100.0, 0),
(@PATH, 15, -11335.8, 1538.97, 29.1052, 100.0, 0),
(@PATH, 16, -11341.1, 1541.43, 28.4216, 100.0, 0),
(@PATH, 17, -11343.4, 1547.55, 28.7287, 100.0, 0),
(@PATH, 18, -11343.9, 1552.88, 29.9349, 100.0, 0),
(@PATH, 19, -11343.8, 1560.35, 31.7605, 100.0, 0);

/*  Riverpaw Scout - GUID 88749  */


SET @NPC := 88749;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10059.4, `position_y` = 1673.4, `position_z` = 36.1322, `orientation` = 0.002869 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10059.4, 1673.4, 36.1322, 100.0, 0),
(@PATH, 2, -10062.1, 1678.72, 35.0778, 100.0, 0),
(@PATH, 3, -10062.8, 1679.95, 34.8889, 100.0, 0),
(@PATH, 4, -10070.7, 1666.99, 37.3629, 100.0, 0),
(@PATH, 5, -10072.2, 1664.41, 38.0826, 100.0, 0),
(@PATH, 6, -10087.5, 1664.8, 40.1002, 100.0, 0),
(@PATH, 7, -10092.6, 1674.94, 40.4896, 100.0, 0),
(@PATH, 8, -10076.9, 1709.13, 35.3352, 100.0, 0),
(@PATH, 9, -10067.3, 1714.01, 36.6148, 100.0, 0),
(@PATH, 10, -10065.5, 1714.88, 36.9976, 100.0, 0),
(@PATH, 11, -10041.9, 1717.4, 38.2179, 100.0, 0),
(@PATH, 12, -10030.7, 1714.01, 37.3666, 100.0, 0),
(@PATH, 13, -10023.7, 1692.4, 38.5037, 100.0, 0),
(@PATH, 14, -10025.5, 1672.48, 40.4177, 100.0, 0),
(@PATH, 15, -10043.5, 1659.81, 39.1718, 100.0, 0),
(@PATH, 16, -10053.5, 1664.03, 37.745, 100.0, 0);


/*  Riverpaw Scout - GUID 88748  */


SET @NPC := 88748;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10151.5, `position_y` = 1613.36, `position_z` = 41.8154, `orientation` = 2.84194 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10151.5, 1613.36, 41.8154, 100.0, 0),
(@PATH, 2, -10170.8, 1609.61, 44.1574, 100.0, 0),
(@PATH, 3, -10180.3, 1632.16, 43.0468, 100.0, 0),
(@PATH, 4, -10173.2, 1650.24, 41.0259, 100.0, 0),
(@PATH, 5, -10165.9, 1653.4, 40.1324, 100.0, 0),
(@PATH, 6, -10149.0, 1649.16, 38.1738, 100.0, 0),
(@PATH, 7, -10151.3, 1659.9, 38.9078, 100.0, 0),
(@PATH, 8, -10139.4, 1668.6, 38.988, 100.0, 0),
(@PATH, 9, -10122.2, 1661.83, 38.1707, 100.0, 0),
(@PATH, 10, -10115.6, 1652.04, 38.6099, 100.0, 0),
(@PATH, 11, -10115.7, 1644.7, 38.2118, 100.0, 0);


/*  Riverpaw Gnoll - GUID 86784  */


SET @NPC := 86784;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -9730.34, `position_y` = 1451.46, `position_z` = 44.769, `orientation` = 2.89254 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -9730.34, 1451.46, 44.769, 100.0, 0),
(@PATH, 2, -9738.7, 1470.82, 44.2172, 100.0, 0),
(@PATH, 3, -9747.79, 1475.23, 43.549, 100.0, 0),
(@PATH, 4, -9750.1, 1474.15, 43.4027, 100.0, 0),
(@PATH, 5, -9750.1, 1474.15, 43.4027, 100.0, 0),
(@PATH, 6, -9756.14, 1463.63, 42.9047, 100.0, 0),
(@PATH, 7, -9759.92, 1440.27, 41.6578, 100.0, 0),
(@PATH, 8, -9753.55, 1421.69, 42.4276, 100.0, 0),
(@PATH, 9, -9746.56, 1411.95, 43.6791, 100.0, 0),
(@PATH, 10, -9735.13, 1407.75, 43.5392, 100.0, 0),
(@PATH, 11, -9728.78, 1426.62, 45.1107, 100.0, 0);


/*  Riverpaw Scout - GUID 86788  */


SET @NPC := 86788;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -9880.3, `position_y` = 1540.43, `position_z` = 44.9256, `orientation` = 2.62696 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -9880.3, 1540.43, 44.9256, 100.0, 0),
(@PATH, 2, -9882.0, 1538.97, 45.198, 100.0, 0),
(@PATH, 3, -9915.98, 1554.02, 41.8685, 100.0, 0),
(@PATH, 4, -9925.49, 1564.06, 42.5624, 100.0, 0),
(@PATH, 5, -9926.4, 1571.31, 42.8584, 100.0, 0),
(@PATH, 6, -9919.27, 1577.08, 45.3244, 100.0, 0),
(@PATH, 7, -9913.63, 1584.0, 43.2094, 100.0, 0),
(@PATH, 8, -9893.66, 1593.97, 41.7161, 100.0, 0),
(@PATH, 9, -9874.96, 1590.52, 41.6566, 100.0, 0),
(@PATH, 10, -9842.02, 1575.39, 39.5086, 100.0, 0),
(@PATH, 11, -9838.06, 1561.86, 42.1772, 100.0, 0),
(@PATH, 12, -9844.73, 1545.88, 45.8219, 100.0, 0);


/*  Riverpaw Mongrel - GUID 87031  */


SET @NPC := 87031;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10044.9, `position_y` = 1825.42, `position_z` = 36.7228, `orientation` = 2.37829 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10044.9, 1825.42, 36.7228, 100.0, 0),
(@PATH, 2, -10054.0, 1843.14, 36.2392, 100.0, 0),
(@PATH, 3, -10071.7, 1865.05, 37.271, 100.0, 0),
(@PATH, 4, -10080.1, 1865.5, 36.1371, 100.0, 0),
(@PATH, 5, -10083.2, 1863.06, 36.1071, 100.0, 0),
(@PATH, 6, -10088.9, 1848.24, 35.8601, 100.0, 0),
(@PATH, 7, -10079.3, 1827.32, 34.5404, 100.0, 0),
(@PATH, 8, -10078.7, 1819.33, 34.8642, 100.0, 0),
(@PATH, 9, -10063.0, 1802.55, 35.6077, 100.0, 0),
(@PATH, 10, -10047.5, 1799.62, 36.8821, 100.0, 0),
(@PATH, 11, -10030.5, 1814.1, 37.8549, 100.0, 0);


/*  Riverpaw Mongrel - GUID 87034  */


SET @NPC := 87034;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10130.5, `position_y` = 1771.31, `position_z` = 33.4298, `orientation` = 0.30238 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10130.5, 1771.31, 33.4298, 100.0, 0),
(@PATH, 2, -10113.5, 1753.53, 33.7831, 100.0, 0),
(@PATH, 3, -10117.0, 1728.55, 34.8017, 100.0, 0),
(@PATH, 4, -10134.7, 1712.59, 33.8679, 100.0, 0),
(@PATH, 5, -10162.3, 1718.54, 33.0249, 100.0, 0),
(@PATH, 6, -10166.6, 1710.57, 34.1821, 100.0, 0),
(@PATH, 7, -10178.1, 1703.31, 35.3224, 100.0, 0),
(@PATH, 8, -10209.6, 1720.62, 34.3335, 100.0, 0),
(@PATH, 9, -10209.8, 1745.43, 35.3641, 100.0, 0),
(@PATH, 10, -10193.3, 1763.24, 37.9666, 100.0, 0),
(@PATH, 11, -10167.8, 1768.87, 35.3923, 100.0, 0),
(@PATH, 12, -10154.6, 1770.99, 34.7537, 100.0, 0);


/*  Defias Drone - GUID 66989  */


SET @NPC := 66989;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11065.4, `position_y` = 503.794, `position_z` = 22.6767, `orientation` = 2.46632 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11072.2, 508.853, 24.8021, 0.0, 0),
(@PATH, 2, -11080.5, 515.885, 26.1464, 0.0, 0),
(@PATH, 3, -11092.1, 525.413, 29.6541, 0.0, 0),
(@PATH, 4, -11100.2, 529.407, 31.2408, 0.0, 0),
(@PATH, 5, -11103.7, 534.984, 32.6456, 0.0, 0),
(@PATH, 6, -11107.0, 546.109, 33.8103, 0.0, 0),
(@PATH, 7, -11105.5, 554.917, 33.4921, 0.0, 0),
(@PATH, 8, -11106.7, 564.058, 33.2482, 0.0, 0),
(@PATH, 9, -11110.5, 571.955, 33.3912, 0.0, 0),
(@PATH, 10, -11116.3, 576.251, 33.3609, 0.0, 3000),
(@PATH, 11, -11112.4, 576.758, 33.6797, 0.0, 0),
(@PATH, 12, -11108.1, 572.881, 33.6452, 0.0, 0),
(@PATH, 13, -11104.9, 567.346, 33.5479, 0.0, 0),
(@PATH, 14, -11102.7, 558.91, 33.437, 0.0, 0),
(@PATH, 15, -11102.7, 552.037, 33.6585, 0.0, 0),
(@PATH, 16, -11104.2, 543.763, 33.6709, 0.0, 0),
(@PATH, 17, -11099.8, 534.054, 32.1437, 0.0, 0),
(@PATH, 18, -11091.1, 527.534, 29.8738, 0.0, 0),
(@PATH, 19, -11078.8, 517.76, 26.1589, 0.0, 0),
(@PATH, 20, -11070.2, 509.893, 24.6128, 0.0, 0),
(@PATH, 21, -11064.0, 504.684, 22.4856, 0.0, 0),
(@PATH, 22, -11065.9, 504.269, 22.9024, 0.0, 3000);


/*  Venture Co. Drone - GUID 66992  */


SET @NPC := 66992;
SET @PATH := @NPC * 10;

UPDATE `creature_addon` set `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11103.2, 530.823, 31.8316, 4.65353, 0),
(@PATH, 2, -11105.0, 519.364, 30.8736, 4.28204, 0),
(@PATH, 3, -11106.8, 511.95, 31.1417, 4.08176, 3000),
(@PATH, 4, -11114.1, 505.521, 30.9313, 3.66472, 0),
(@PATH, 5, -11127.2, 500.049, 31.919, 3.19505, 0),
(@PATH, 6, -11142.9, 504.602, 32.1449, 2.61543, 0),
(@PATH, 7, -11157.8, 512.947, 30.8424, 2.64684, 0),
(@PATH, 8, -11170.1, 520.713, 32.6791, 2.26592, 0),
(@PATH, 9, -11169.5, 539.733, 33.3686, 1.57477, 0),
(@PATH, 10, -11170.2, 552.948, 34.0339, 1.18207, 0),
(@PATH, 11, -11160.4, 573.238, 33.3233, 0.981012, 0),
(@PATH, 12, -11146.9, 585.606, 35.0119, 0.509772, 0),
(@PATH, 13, -11134.1, 590.105, 34.7976, 0.144562, 0),
(@PATH, 14, -11121.6, 588.518, 34.5425, 5.96829, 0),
(@PATH, 15, -11112.1, 582.693, 34.3821, 5.51984, 0),
(@PATH, 16, -11104.8, 572.473, 33.868, 5.01247, 0),
(@PATH, 17, -11103.4, 560.609, 33.3978, 4.80827, 0),
(@PATH, 18, -11102.8, 544.496, 33.6181, 4.67083, 0);


/*  Defias Tower Sentry - GUID 66995  */


SET @NPC := 66995;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11137.9, `position_y` = 528.19, `position_z` = 61.6491, `orientation` = 5.98733 WHERE `guid` = @NPC;

UPDATE `creature_addon` set `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11137.9, 528.19, 61.6491, 100.0, 0),
(@PATH, 2, -11132.5, 531.749, 61.6491, 100.0, 0),
(@PATH, 3, -11128.7, 538.241, 61.6491, 100.0, 0),
(@PATH, 4, -11127.7, 545.851, 61.6491, 100.0, 0),
(@PATH, 5, -11131.4, 554.485, 61.6491, 100.0, 0),
(@PATH, 6, -11139.1, 558.844, 61.6491, 100.0, 0),
(@PATH, 7, -11147.1, 559.053, 61.6491, 100.0, 0),
(@PATH, 8, -11154.2, 554.621, 61.6491, 100.0, 0),
(@PATH, 9, -11158.1, 546.604, 61.6491, 100.0, 0),
(@PATH, 10, -11157.2, 538.943, 61.6491, 100.0, 0),
(@PATH, 11, -11152.6, 531.842, 61.6491, 100.0, 0),
(@PATH, 12, -11146.3, 529.056, 61.6491, 100.0, 0);
