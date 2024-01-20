-- DB update 2022_03_18_06 -> 2022_03_18_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_18_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_18_06 2022_03_18_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647361710364876100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647361710364876100');

/*  Shadowsworn Adept - GUID 2665  */


SET @NPC := 2665;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11263.1, `position_y` = -3544.69, `position_z` = 7.98925, `orientation` = 1.82146 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11263.1, -3544.69, 7.98925, 100.0, 0),
(@PATH, 2, -11262.3, -3536.72, 8.18768, 100.0, 0),
(@PATH, 3, -11264.4, -3525.14, 8.20411, 100.0, 0),
(@PATH, 4, -11271.8, -3510.85, 7.91639, 100.0, 0),
(@PATH, 5, -11273.5, -3499.33, 9.6355, 100.0, 0),
(@PATH, 6, -11267.6, -3489.89, 9.61001, 100.0, 0),
(@PATH, 7, -11264.7, -3480.86, 9.26794, 100.0, 0),
(@PATH, 8, -11271.7, -3493.48, 9.51587, 100.0, 0),
(@PATH, 9, -11273.3, -3504.72, 9.57357, 100.0, 0),
(@PATH, 10, -11269.2, -3515.57, 7.47703, 100.0, 0),
(@PATH, 11, -11263.8, -3526.29, 8.34191, 100.0, 0),
(@PATH, 12, -11262.8, -3541.9, 7.83647, 100.0, 0);


/*  Nethergarde Cleric - GUID 2681  */


SET @NPC := 2681;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10961.7, `position_y` = -3284.85, `position_z` = 54.0278, `orientation` = 0.784552 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10961.7, -3284.85, 54.0278, 100.0, 0),
(@PATH, 2, -10952.0, -3289.88, 55.0095, 100.0, 0),
(@PATH, 3, -10930.8, -3290.89, 55.0791, 100.0, 0),
(@PATH, 4, -10943.0, -3290.71, 55.0812, 100.0, 0),
(@PATH, 5, -10955.0, -3289.35, 54.7276, 100.0, 0),
(@PATH, 6, -10972.1, -3265.76, 45.8974, 100.0, 0),
(@PATH, 7, -10977.1, -3274.71, 49.0335, 100.0, 0),
(@PATH, 8, -10986.5, -3287.01, 51.3938, 100.0, 0),
(@PATH, 9, -11011.1, -3287.01, 54.6847, 100.0, 0),
(@PATH, 10, -10995.2, -3289.74, 52.8056, 100.0, 0),
(@PATH, 11, -10979.7, -3280.04, 49.9635, 100.0, 0),
(@PATH, 12, -10975.5, -3265.54, 45.9276, 100.0, 0),
(@PATH, 13, -10962.4, -3283.62, 53.89, 100.0, 0);

/*  Felguard Sentry - GUID 2718  */


SET @NPC := 2718;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11697.2, `position_y` = -3175.77, `position_z` = 10.0519, `orientation` = 3.75344 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11697.2, -3175.77, 10.0519, 100.0, 0),
(@PATH, 2, -11697.0, -3199.49, 7.62958, 100.0, 0),
(@PATH, 3, -11712.4, -3236.27, 7.80203, 100.0, 0),
(@PATH, 4, -11721.7, -3258.75, 6.91549, 100.0, 0),
(@PATH, 5, -11738.7, -3280.61, 5.20007, 100.0, 0),
(@PATH, 6, -11759.6, -3299.08, 5.25464, 100.0, 0),
(@PATH, 7, -11782.7, -3315.46, 5.6667, 100.0, 0),
(@PATH, 8, -11809.0, -3326.26, 4.62931, 100.0, 0),
(@PATH, 9, -11790.2, -3319.69, 5.32741, 100.0, 0),
(@PATH, 10, -11763.3, -3301.95, 5.44173, 100.0, 0),
(@PATH, 11, -11744.7, -3286.86, 5.00674, 100.0, 0),
(@PATH, 12, -11726.5, -3266.12, 6.03492, 100.0, 0),
(@PATH, 13, -11714.4, -3240.88, 7.77631, 100.0, 0),
(@PATH, 14, -11699.4, -3207.74, 8.93876, 100.0, 0),
(@PATH, 15, -11696.4, -3180.4, 10.0966, 100.0, 0),
(@PATH, 16, -11703.5, -3157.33, 8.76819, 100.0, 0),
(@PATH, 17, -11703.2, -3130.34, 11.3779, 100.0, 0),
(@PATH, 18, -11713.4, -3109.65, 11.3121, 100.0, 0),
(@PATH, 19, -11726.2, -3094.9, 12.0208, 100.0, 0),
(@PATH, 20, -11740.4, -3088.22, 10.1719, 100.0, 0),
(@PATH, 21, -11756.3, -3077.47, 9.843, 100.0, 0),
(@PATH, 22, -11774.9, -3071.06, 7.84356, 100.0, 0),
(@PATH, 23, -11797.6, -3066.03, 6.62067, 100.0, 0),
(@PATH, 24, -11825.2, -3061.05, 6.05357, 100.0, 0),
(@PATH, 25, -11844.3, -3054.71, 5.89437, 100.0, 0),
(@PATH, 26, -11859.0, -3044.52, 13.9269, 100.0, 0),
(@PATH, 27, -11881.5, -3056.87, 20.2624, 100.0, 0),
(@PATH, 28, -11903.5, -3069.43, 24.1628, 100.0, 0),
(@PATH, 29, -11889.6, -3061.7, 22.5331, 100.0, 0),
(@PATH, 30, -11863.6, -3044.98, 15.4583, 100.0, 0),
(@PATH, 31, -11851.4, -3050.6, 10.5351, 100.0, 0),
(@PATH, 32, -11834.6, -3058.43, 5.5463, 100.0, 0),
(@PATH, 33, -11806.0, -3064.4, 6.35987, 100.0, 0),
(@PATH, 34, -11782.9, -3068.96, 6.75974, 100.0, 0),
(@PATH, 35, -11763.9, -3074.23, 9.41394, 100.0, 0),
(@PATH, 36, -11747.3, -3084.53, 9.37471, 100.0, 0),
(@PATH, 37, -11729.9, -3092.47, 11.5539, 100.0, 0),
(@PATH, 38, -11718.3, -3103.37, 12.9114, 100.0, 0),
(@PATH, 39, -11705.5, -3122.84, 12.3253, 100.0, 0),
(@PATH, 40, -11704.3, -3149.17, 9.67389, 100.0, 0);


/*  Shadowsworn Warlock - GUID 2727  */


SET @NPC := 2727;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11504.9, `position_y` = -2657.08, `position_z` = 11.6719, `orientation` = 0.191033 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11504.9, -2657.08, 11.6719, 100.0, 0),
(@PATH, 2, -11493.8, -2667.97, 9.16258, 100.0, 0),
(@PATH, 3, -11476.6, -2674.26, 12.4304, 100.0, 0),
(@PATH, 4, -11464.0, -2667.26, 12.5638, 100.0, 0),
(@PATH, 5, -11450.7, -2645.67, 23.4096, 100.0, 0),
(@PATH, 6, -11431.1, -2626.37, 39.1451, 100.0, 0),
(@PATH, 7, -11418.4, -2609.54, 50.3675, 100.0, 0),
(@PATH, 8, -11402.8, -2594.36, 60.5906, 100.0, 0),
(@PATH, 9, -11373.3, -2571.97, 76.2189, 100.0, 0),
(@PATH, 10, -11357.7, -2560.42, 81.7875, 100.0, 0),
(@PATH, 11, -11339.4, -2555.33, 87.389, 100.0, 0),
(@PATH, 12, -11315.5, -2552.53, 96.2945, 100.0, 0),
(@PATH, 13, -11332.2, -2557.83, 89.0049, 100.0, 0),
(@PATH, 14, -11349.9, -2557.19, 84.6853, 100.0, 0),
(@PATH, 15, -11366.2, -2566.72, 78.7274, 100.0, 0),
(@PATH, 16, -11396.5, -2588.94, 64.2837, 100.0, 0),
(@PATH, 17, -11415.3, -2606.06, 52.5221, 100.0, 0),
(@PATH, 18, -11428.0, -2622.91, 41.3438, 100.0, 0),
(@PATH, 19, -11445.8, -2639.32, 27.4417, 100.0, 0),
(@PATH, 20, -11458.3, -2661.03, 15.201, 100.0, 0),
(@PATH, 21, -11472.6, -2673.6, 13.3983, 100.0, 0),
(@PATH, 22, -11486.6, -2672.08, 9.72051, 100.0, 0);


/*  Shadowsworn Enforcer - GUID 2786  */


SET @NPC := 2786;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11234.8, -2593.78, 96.2911, 100.0, 0),
(@PATH, 2, -11230.5, -2587.57, 99.0153, 100.0, 0),
(@PATH, 3, -11218.8, -2576.38, 94.1016, 100.0, 0),
(@PATH, 4, -11218.6, -2570.05, 93.2954, 100.0, 0),
(@PATH, 5, -11220.6, -2562.68, 92.806, 100.0, 0),
(@PATH, 6, -11218.6, -2570.05, 93.2954, 100.0, 0),
(@PATH, 7, -11218.8, -2576.38, 94.1016, 100.0, 0),
(@PATH, 8, -11230.5, -2587.57, 99.0153, 100.0, 0),
(@PATH, 9, -11234.8, -2593.78, 96.2911, 100.0, 0),
(@PATH, 10, -11277.7, -2602.66, 98.9525, 100.0, 0),
(@PATH, 11, -11280.9, -2603.64, 96.7767, 100.0, 0),
(@PATH, 12, -11289.4, -2600.27, 91.6653, 100.0, 0),
(@PATH, 13, -11301.7, -2590.93, 89.6448, 100.0, 0),
(@PATH, 14, -11309.4, -2582.18, 89.867, 100.0, 0),
(@PATH, 15, -11324.3, -2569.9, 92.007, 100.0, 0),
(@PATH, 16, -11336.1, -2559.85, 88.5162, 100.0, 0),
(@PATH, 17, -11338.5, -2552.67, 87.3467, 100.0, 0),
(@PATH, 18, -11333.2, -2544.14, 88.9595, 100.0, 0),
(@PATH, 19, -11326.6, -2534.51, 90.819, 100.0, 0),
(@PATH, 20, -11314.7, -2523.51, 92.5943, 100.0, 0),
(@PATH, 21, -11323.9, -2531.22, 91.4691, 100.0, 0),
(@PATH, 22, -11328.3, -2537.74, 89.9348, 100.0, 0),
(@PATH, 23, -11336.4, -2546.06, 88.0747, 100.0, 0),
(@PATH, 24, -11337.9, -2556.33, 87.7897, 100.0, 0),
(@PATH, 25, -11330.3, -2564.98, 89.5463, 100.0, 0),
(@PATH, 26, -11324.3, -2569.9, 92.007, 100.0, 0),
(@PATH, 27, -11309.4, -2582.18, 89.867, 100.0, 0),
(@PATH, 28, -11301.7, -2590.93, 89.6448, 100.0, 0),
(@PATH, 29, -11289.4, -2600.27, 91.6653, 100.0, 0),
(@PATH, 30, -11285.2, -2604.89, 95.4095, 100.0, 0),
(@PATH, 31, -11280.9, -2603.64, 96.7767, 100.0, 0),
(@PATH, 32, -11277.7, -2602.66, 98.9525, 100.0, 0);

/*  Felguard Elite - GUID 2791  */


SET @NPC := 2791;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11924.9, `position_y` = -2665.26, `position_z` = -4.13615, `orientation` = 5.9485 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11924.9, -2665.26, -4.13615, 100.0, 0),
(@PATH, 2, -11909.2, -2663.06, -1.0627, 100.0, 0),
(@PATH, 3, -11895.7, -2655.5, -3.25965, 100.0, 0),
(@PATH, 4, -11870.4, -2635.81, -4.30517, 100.0, 0),
(@PATH, 5, -11859.3, -2624.18, -3.70689, 100.0, 0),
(@PATH, 6, -11838.4, -2615.14, -2.88186, 100.0, 0),
(@PATH, 7, -11825.5, -2608.6, 0.51049, 100.0, 0),
(@PATH, 8, -11816.3, -2589.04, -0.734763, 100.0, 0),
(@PATH, 9, -11802.1, -2572.28, -1.98653, 100.0, 0),
(@PATH, 10, -11788.0, -2564.39, -1.59518, 100.0, 0),
(@PATH, 11, -11766.8, -2552.84, 0.0904483, 100.0, 0),
(@PATH, 12, -11746.4, -2528.44, -1.45359, 100.0, 0),
(@PATH, 13, -11730.3, -2510.74, -2.84845, 100.0, 0),
(@PATH, 14, -11720.2, -2499.1, -3.38654, 100.0, 0),
(@PATH, 15, -11691.2, -2468.83, -3.09698, 100.0, 0),
(@PATH, 16, -11710.1, -2484.09, -4.26825, 100.0, 0),
(@PATH, 17, -11719.3, -2496.71, -3.6583, 100.0, 0),
(@PATH, 18, -11734.5, -2514.51, -2.24706, 100.0, 0),
(@PATH, 19, -11754.2, -2539.78, -0.342065, 100.0, 0),
(@PATH, 20, -11771.6, -2555.61, -0.526829, 100.0, 0),
(@PATH, 21, -11793.0, -2566.86, -2.02095, 100.0, 0),
(@PATH, 22, -11806.5, -2575.26, -1.93057, 100.0, 0),
(@PATH, 23, -11817.0, -2594.04, 0.0304065, 100.0, 0),
(@PATH, 24, -11829.8, -2611.83, -0.246485, 100.0, 0),
(@PATH, 25, -11843.8, -2615.82, -4.05847, 100.0, 0),
(@PATH, 26, -11862.8, -2628.29, -4.00317, 100.0, 0),
(@PATH, 27, -11880.8, -2643.74, -3.55695, 100.0, 0),
(@PATH, 28, -11899.5, -2658.56, -2.71281, 100.0, 0),
(@PATH, 29, -11914.0, -2663.74, -1.67681, 100.0, 0),
(@PATH, 30, -11936.6, -2669.59, -7.28362, 100.0, 0),
(@PATH, 31, -11952.0, -2669.04, -10.1938, 100.0, 0),
(@PATH, 32, -11958.3, -2665.27, -10.8756, 100.0, 0),
(@PATH, 33, -11976.6, -2651.97, -12.5223, 100.0, 0),
(@PATH, 34, -11989.2, -2648.87, -21.5704, 100.0, 0),
(@PATH, 35, -11997.1, -2647.67, -21.4651, 100.0, 0),
(@PATH, 36, -12010.6, -2650.97, -24.6536, 100.0, 0),
(@PATH, 37, -12016.5, -2664.62, -22.0722, 100.0, 0),
(@PATH, 38, -12012.6, -2690.81, -5.74008, 100.0, 0),
(@PATH, 39, -12013.3, -2712.04, 3.35226, 100.0, 0),
(@PATH, 40, -12023.0, -2722.75, 4.73668, 100.0, 0),
(@PATH, 41, -12058.6, -2725.86, 4.35547, 100.0, 0),
(@PATH, 42, -12042.8, -2727.22, 4.47039, 100.0, 0),
(@PATH, 43, -12021.0, -2721.75, 4.41762, 100.0, 0),
(@PATH, 44, -12012.9, -2709.81, 3.12055, 100.0, 0),
(@PATH, 45, -12015.4, -2677.05, -17.3785, 100.0, 0),
(@PATH, 46, -12016.3, -2662.64, -22.7659, 100.0, 0),
(@PATH, 47, -12014.8, -2655.16, -24.2672, 100.0, 0),
(@PATH, 48, -12002.5, -2647.93, -23.1457, 100.0, 0),
(@PATH, 49, -11987.5, -2649.12, -19.97, 100.0, 0),
(@PATH, 50, -11974.4, -2652.73, -12.2078, 100.0, 0),
(@PATH, 51, -11961.4, -2660.57, -11.5603, 100.0, 0),
(@PATH, 52, -11949.5, -2669.58, -9.83856, 100.0, 0),
(@PATH, 53, -11934.4, -2668.76, -6.60297, 100.0, 0);

/*  Nethergarde Cleric - GUID 2818  */


SET @NPC := 2818;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10934.1, -3512.56, 70.4819, 100.0, 0),
(@PATH, 2, -10947.8, -3513.0, 72.5398, 100.0, 0),
(@PATH, 3, -10937.0, -3512.66, 70.4382, 100.0, 0),
(@PATH, 4, -10918.1, -3500.31, 65.0347, 100.0, 0),
(@PATH, 5, -10889.9, -3482.18, 67.633, 100.0, 0),
(@PATH, 6, -10883.2, -3469.39, 73.0592, 100.0, 0),
(@PATH, 7, -10894.5, -3417.88, 65.0947, 100.0, 0),
(@PATH, 8, -10896.8, -3402.14, 65.0793, 100.0, 0),
(@PATH, 9, -10889.5, -3386.58, 65.0793, 100.0, 0),
(@PATH, 10, -10894.5, -3393.0, 65.0793, 100.0, 0),
(@PATH, 11, -10895.3, -3411.92, 65.0793, 100.0, 0),
(@PATH, 12, -10893.7, -3431.05, 68.179, 100.0, 0),
(@PATH, 13, -10886.9, -3450.2, 76.2477, 100.0, 0),
(@PATH, 14, -10888.7, -3479.92, 68.2514, 100.0, 0),
(@PATH, 15, -10910.6, -3495.16, 65.1038, 100.0, 0);


/*  Nethergarde Engineer - GUID 2831  */


SET @NPC := 2831;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10648.9, `position_y` = -3601.93, `position_z` = -7.69235, `orientation` = 4.374 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10648.9, -3601.93, -7.69235, 100.0, 0),
(@PATH, 2, -10659.1, -3595.96, -7.68188, 100.0, 0),
(@PATH, 3, -10648.9, -3601.93, -7.69235, 100.0, 0),
(@PATH, 4, -10626.6, -3610.75, -10.7745, 100.0, 0),
(@PATH, 5, -10612.9, -3598.59, -12.8931, 100.0, 0),
(@PATH, 6, -10606.1, -3571.67, -13.016, 100.0, 0),
(@PATH, 7, -10589.8, -3530.78, -7.4113, 100.0, 0),
(@PATH, 8, -10594.2, -3512.79, -1.94191, 100.0, 0),
(@PATH, 9, -10605.1, -3480.25, 2.54678, 100.0, 0),
(@PATH, 10, -10597.5, -3503.14, -0.636889, 100.0, 0),
(@PATH, 11, -10589.4, -3525.17, -6.258, 100.0, 0),
(@PATH, 12, -10603.2, -3561.93, -12.0188, 100.0, 0),
(@PATH, 13, -10610.2, -3593.34, -13.7081, 100.0, 0),
(@PATH, 14, -10621.9, -3609.4, -11.2378, 100.0, 0),
(@PATH, 15, -10644.0, -3603.87, -8.01393, 100.0, 0);


/*  Nethergarde Engineer - GUID 2874  */


SET @NPC := 2874;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10642.9, `position_y` = -3368.9, `position_z` = -11.8411, `orientation` = 4.24475 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10642.9, -3368.9, -11.8411, 100.0, 0),
(@PATH, 2, -10648.6, -3384.93, -12.3627, 100.0, 0),
(@PATH, 3, -10644.6, -3373.5, -12.0937, 100.0, 0),
(@PATH, 4, -10640.0, -3353.96, -10.3258, 100.0, 0),
(@PATH, 5, -10637.3, -3329.85, -8.91358, 100.0, 0),
(@PATH, 6, -10637.2, -3305.46, -7.41371, 100.0, 0),
(@PATH, 7, -10638.8, -3273.21, -6.90623, 100.0, 0),
(@PATH, 8, -10645.8, -3245.98, -3.66932, 100.0, 0),
(@PATH, 9, -10642.1, -3235.39, -3.87247, 100.0, 0),
(@PATH, 10, -10619.1, -3230.37, -5.53486, 100.0, 0),
(@PATH, 11, -10635.3, -3231.73, -4.40398, 100.0, 0),
(@PATH, 12, -10644.2, -3239.16, -3.68146, 100.0, 0),
(@PATH, 13, -10640.2, -3265.78, -6.27386, 100.0, 0),
(@PATH, 14, -10637.5, -3298.74, -6.91279, 100.0, 0),
(@PATH, 15, -10637.0, -3322.96, -8.58814, 100.0, 0),
(@PATH, 16, -10638.9, -3347.12, -9.78694, 100.0, 0),
(@PATH, 17, -10642.6, -3366.95, -11.6916, 100.0, 0);

/*  Shadowsworn Adept - GUID 3033  */


SET @NPC := 3033;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11220.6, `position_y` = -3490.08, `position_z` = 8.29975, `orientation` = 2.08067 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11220.6, -3490.08, 8.29975, 100.0, 0),
(@PATH, 2, -11224.4, -3483.23, 8.61958, 100.0, 0),
(@PATH, 3, -11226.4, -3489.85, 8.9811, 100.0, 0),
(@PATH, 4, -11228.6, -3497.12, 10.7039, 100.0, 0),
(@PATH, 5, -11232.3, -3507.94, 13.2225, 100.0, 0),
(@PATH, 6, -11233.0, -3512.34, 12.9489, 100.0, 0),
(@PATH, 7, -11231.8, -3504.36, 12.6232, 100.0, 0),
(@PATH, 8, -11228.8, -3497.46, 10.7407, 100.0, 0),
(@PATH, 9, -11226.2, -3486.18, 8.71983, 100.0, 0),
(@PATH, 10, -11220.6, -3490.01, 8.3012, 100.0, 0),
(@PATH, 11, -11219.0, -3497.81, 8.18111, 100.0, 0);


/*  Shadowsworn Thug - GUID 3039  */


SET @NPC := 3039;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11272.8, `position_y` = -3471.56, `position_z` = 9.00077, `orientation` = 5.32283 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11272.8, -3471.56, 9.00077, 100.0, 0),
(@PATH, 2, -11269.2, -3472.61, 9.22681, 100.0, 0),
(@PATH, 3, -11262.8, -3473.72, 8.25433, 100.0, 0),
(@PATH, 4, -11255.2, -3471.01, 7.63428, 100.0, 0),
(@PATH, 5, -11247.2, -3462.88, 8.15743, 100.0, 0),
(@PATH, 6, -11250.3, -3452.97, 8.23619, 100.0, 0),
(@PATH, 7, -11256.8, -3449.05, 8.28499, 100.0, 0),
(@PATH, 8, -11268.1, -3450.79, 8.44782, 100.0, 0),
(@PATH, 9, -11281.6, -3446.38, 9.40464, 100.0, 0),
(@PATH, 10, -11299.9, -3423.65, 10.2112, 100.0, 0),
(@PATH, 11, -11288.2, -3439.91, 10.5062, 100.0, 0),
(@PATH, 12, -11276.3, -3450.31, 8.96439, 100.0, 0),
(@PATH, 13, -11265.9, -3449.81, 8.43113, 100.0, 0),
(@PATH, 14, -11258.3, -3448.72, 8.3498, 100.0, 0),
(@PATH, 15, -11246.7, -3458.11, 8.30735, 100.0, 0),
(@PATH, 16, -11248.4, -3464.84, 8.3026, 100.0, 0),
(@PATH, 17, -11253.6, -3470.38, 7.54197, 100.0, 0),
(@PATH, 18, -11264.9, -3474.44, 8.8038, 100.0, 0),
(@PATH, 19, -11268.1, -3473.94, 9.15129, 100.0, 0),
(@PATH, 20, -11275.5, -3471.36, 8.78418, 100.0, 0);

/*  Nethergarde Cleric - GUID 3666  */


SET @NPC := 3666;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11046.8, `position_y` = -3453.58, `position_z` = 66.1462, `orientation` = 1.5747 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11046.8, -3453.58, 66.1462, 100.0, 0),
(@PATH, 2, -11071.2, -3468.0, 65.0318, 100.0, 0),
(@PATH, 3, -11086.4, -3468.36, 65.0318, 100.0, 0),
(@PATH, 4, -11105.0, -3446.41, 65.0793, 100.0, 0),
(@PATH, 5, -11090.5, -3466.01, 65.0357, 100.0, 0),
(@PATH, 6, -11079.5, -3469.85, 65.0318, 100.0, 0),
(@PATH, 7, -11051.2, -3456.16, 66.2434, 100.0, 0),
(@PATH, 8, -10998.7, -3434.04, 62.1056, 100.0, 0),
(@PATH, 9, -10997.2, -3406.58, 61.9534, 100.0, 0),
(@PATH, 10, -10997.4, -3378.02, 62.4127, 100.0, 0),
(@PATH, 11, -10970.4, -3362.69, 65.6759, 100.0, 0),
(@PATH, 12, -10992.7, -3370.5, 63.8867, 100.0, 0),
(@PATH, 13, -10997.3, -3399.75, 62.1183, 100.0, 0),
(@PATH, 14, -10996.7, -3427.96, 62.0976, 100.0, 0),
(@PATH, 15, -11013.8, -3448.43, 65.0439, 100.0, 0),
(@PATH, 16, -11044.9, -3453.47, 66.0004, 100.0, 0);


/*  Nethergarde Cleric - GUID 3690  */


SET @NPC := 3690;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11086.2, `position_y` = -3321.87, `position_z` = 50.1266, `orientation` = 4.20245 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11086.2, -3321.87, 50.1266, 100.0, 0),
(@PATH, 2, -11077.2, -3305.76, 48.8462, 100.0, 0),
(@PATH, 3, -11070.7, -3302.37, 49.4901, 100.0, 0),
(@PATH, 4, -11058.8, -3300.88, 51.0413, 100.0, 0),
(@PATH, 5, -11043.1, -3293.34, 53.247, 100.0, 0),
(@PATH, 6, -11053.5, -3299.43, 51.7197, 100.0, 0),
(@PATH, 7, -11061.2, -3301.09, 50.6723, 100.0, 0),
(@PATH, 8, -11073.2, -3302.75, 49.2254, 100.0, 0),
(@PATH, 9, -11086.3, -3322.01, 50.1673, 100.0, 0),
(@PATH, 10, -11098.9, -3337.11, 54.1329, 100.0, 0),
(@PATH, 11, -11108.0, -3354.97, 55.173, 100.0, 0),
(@PATH, 12, -11119.0, -3380.05, 60.4307, 100.0, 0),
(@PATH, 13, -11111.2, -3362.29, 55.229, 100.0, 0),
(@PATH, 14, -11102.8, -3343.94, 54.9184, 100.0, 0),
(@PATH, 15, -11091.0, -3328.04, 51.8839, 100.0, 0);


/*  Nethergarde Foreman - GUID 3713  */


SET @NPC := 3713;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10554.5, `position_y` = -3275.27, `position_z` = 0.5635, `orientation` = 1.8138 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10554.5, -3275.27, 0.5635, 100.0, 0),
(@PATH, 2, -10548.2, -3242.41, 4.85151, 100.0, 0),
(@PATH, 3, -10554.2, -3215.09, 7.23001, 100.0, 0),
(@PATH, 4, -10566.4, -3207.48, 6.59443, 100.0, 0),
(@PATH, 5, -10581.6, -3189.98, 8.82543, 100.0, 0),
(@PATH, 6, -10606.5, -3158.75, 15.1609, 100.0, 0),
(@PATH, 7, -10629.9, -3131.81, 21.0762, 100.0, 0),
(@PATH, 8, -10642.8, -3106.11, 24.3004, 100.0, 0),
(@PATH, 9, -10634.7, -3124.47, 23.0367, 100.0, 0),
(@PATH, 10, -10612.3, -3151.92, 16.9673, 100.0, 0),
(@PATH, 11, -10586.8, -3182.57, 10.4541, 100.0, 0),
(@PATH, 12, -10573.5, -3202.47, 6.87191, 100.0, 0),
(@PATH, 13, -10559.8, -3209.23, 6.76615, 100.0, 0),
(@PATH, 14, -10549.4, -3233.43, 6.3903, 100.0, 0),
(@PATH, 15, -10549.3, -3269.11, 0.723815, 100.0, 0),
(@PATH, 16, -10575.9, -3281.14, 2.45524, 100.0, 0),
(@PATH, 17, -10592.0, -3282.19, 4.25849, 100.0, 0),
(@PATH, 18, -10598.0, -3300.63, 4.41337, 100.0, 0),
(@PATH, 19, -10596.9, -3284.42, 4.67518, 100.0, 0),
(@PATH, 20, -10582.9, -3281.84, 3.12483, 100.0, 0),
(@PATH, 21, -10555.2, -3275.47, 0.605453, 100.0, 0);


/*  Nethergarde Foreman - GUID 3774  */


SET @NPC := 3774;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10761.8, `position_y` = -3490.84, `position_z` = -24.0558, `orientation` = 0.376827 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10761.8, -3490.84, -24.0558, 100.0, 0),
(@PATH, 2, -10756.1, -3526.03, -29.7689, 100.0, 0),
(@PATH, 3, -10743.8, -3546.47, -31.6446, 100.0, 0),
(@PATH, 4, -10724.5, -3560.71, -29.6694, 100.0, 0),
(@PATH, 5, -10701.5, -3559.02, -31.3383, 100.0, 0),
(@PATH, 6, -10685.4, -3524.72, -31.3166, 100.0, 0),
(@PATH, 7, -10695.9, -3555.16, -33.0907, 100.0, 0),
(@PATH, 8, -10717.3, -3562.17, -29.2047, 100.0, 0),
(@PATH, 9, -10738.0, -3551.85, -31.3237, 100.0, 0),
(@PATH, 10, -10752.8, -3532.63, -30.754, 100.0, 0),
(@PATH, 11, -10760.8, -3501.59, -24.3013, 100.0, 0),
(@PATH, 12, -10761.3, -3461.58, -20.9321, 100.0, 0),
(@PATH, 13, -10778.5, -3448.6, -20.3839, 100.0, 0),
(@PATH, 14, -10764.4, -3456.58, -20.1006, 100.0, 0);


/*  Nethergarde Foreman - GUID 3775  */


SET @NPC := 3775;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10742.7, `position_y` = -3433.8, `position_z` = -18.0851, `orientation` = 0.613927 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10742.7, -3433.8, -18.0851, 100.0, 0),
(@PATH, 2, -10724.0, -3418.6, -15.7225, 100.0, 0),
(@PATH, 3, -10711.8, -3385.43, -11.4765, 100.0, 0),
(@PATH, 4, -10719.5, -3366.86, -11.9022, 100.0, 0),
(@PATH, 5, -10738.7, -3353.69, -10.4333, 100.0, 0),
(@PATH, 6, -10740.7, -3336.38, -10.4926, 100.0, 0),
(@PATH, 7, -10708.2, -3335.23, -5.23888, 100.0, 0),
(@PATH, 8, -10708.6, -3294.39, -8.14299, 100.0, 0),
(@PATH, 9, -10703.8, -3330.19, -6.03449, 100.0, 0),
(@PATH, 10, -10737.1, -3332.44, -10.2388, 100.0, 0),
(@PATH, 11, -10742.1, -3345.53, -10.2689, 100.0, 0),
(@PATH, 12, -10726.9, -3359.89, -11.0028, 100.0, 0),
(@PATH, 13, -10713.2, -3378.52, -11.8183, 100.0, 0),
(@PATH, 14, -10719.8, -3412.85, -14.3594, 100.0, 0);


/*  Nethergarde Engineer - GUID 3781  */


SET @NPC := 3781;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10759.6, -3628.64, -11.8502, 100.0, 0),
(@PATH, 2, -10767.4, -3602.98, -12.34, 100.0, 0),
(@PATH, 3, -10810.0, -3580.72, -11.8548, 100.0, 0),
(@PATH, 4, -10773.0, -3596.63, -12.7723, 100.0, 0),
(@PATH, 5, -10762.8, -3625.1, -11.6665, 100.0, 0),
(@PATH, 6, -10741.8, -3634.75, -11.3745, 100.0, 0),
(@PATH, 7, -10731.9, -3636.92, -12.0072, 100.0, 0),
(@PATH, 8, -10649.5, -3627.04, -11.135, 100.0, 0),
(@PATH, 9, -10689.4, -3640.92, -11.412, 100.0, 0),
(@PATH, 10, -10670.4, -3649.98, -12.9239, 100.0, 0),
(@PATH, 11, -10649.8, -3627.33, -11.1637, 100.0, 0),
(@PATH, 12, -10628.7, -3632.16, -13.2274, 100.0, 0),
(@PATH, 13, -10644.4, -3628.3, -11.6658, 100.0, 0),
(@PATH, 14, -10676.5, -3652.24, -12.6203, 100.0, 0),
(@PATH, 15, -10688.4, -3641.85, -11.4654, 100.0, 0),
(@PATH, 16, -10695.7, -3638.85, -11.1722, 100.0, 0),
(@PATH, 17, -10733.1, -3636.85, -11.9445, 100.0, 0);


/*  Nethergarde Engineer - GUID 3786  */


SET @NPC := 3786;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10557.7, `position_y` = -3308.53, `position_z` = 2.53452, `orientation` = 1.29931 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10557.7, -3308.53, 2.53452, 100.0, 0),
(@PATH, 2, -10563.1, -3331.25, 3.46868, 100.0, 0),
(@PATH, 3, -10559.2, -3366.81, -1.99552, 100.0, 0),
(@PATH, 4, -10557.5, -3386.87, -2.52529, 100.0, 0),
(@PATH, 5, -10560.6, -3406.69, -1.33124, 100.0, 0),
(@PATH, 6, -10564.3, -3435.8, -2.18551, 100.0, 0),
(@PATH, 7, -10566.0, -3451.87, -2.01642, 100.0, 0),
(@PATH, 8, -10551.7, -3475.82, -5.29398, 100.0, 0),
(@PATH, 9, -10566.2, -3453.03, -2.05965, 100.0, 0),
(@PATH, 10, -10564.0, -3432.89, -2.15259, 100.0, 0),
(@PATH, 11, -10560.3, -3404.97, -1.38721, 100.0, 0),
(@PATH, 12, -10557.3, -3389.28, -2.39065, 100.0, 0),
(@PATH, 13, -10558.5, -3373.19, -2.64956, 100.0, 0),
(@PATH, 14, -10563.3, -3341.84, 2.64804, 100.0, 0),
(@PATH, 15, -10557.2, -3306.38, 2.32065, 100.0, 0),
(@PATH, 16, -10534.5, -3295.0, 2.31873, 100.0, 0),
(@PATH, 17, -10553.5, -3301.78, 2.01342, 100.0, 0);


/*  Felguard Sentry - GUID 3804  */


SET @NPC := 3804;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11667.7, `position_y` = -3181.51, `position_z` = 16.5394, `orientation` = 4.13413 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11667.7, -3181.51, 16.5394, 100.0, 0),
(@PATH, 2, -11675.7, -3199.63, 14.4383, 100.0, 0),
(@PATH, 3, -11676.7, -3211.48, 14.7261, 100.0, 0),
(@PATH, 4, -11684.6, -3239.69, 13.2437, 100.0, 0),
(@PATH, 5, -11677.8, -3219.6, 14.8258, 100.0, 0),
(@PATH, 6, -11676.8, -3203.64, 14.3528, 100.0, 0),
(@PATH, 7, -11670.0, -3189.23, 15.8881, 100.0, 0),
(@PATH, 8, -11667.0, -3169.67, 17.4875, 100.0, 0),
(@PATH, 9, -11671.9, -3150.63, 17.7599, 100.0, 0),
(@PATH, 10, -11677.5, -3135.18, 17.2494, 100.0, 0),
(@PATH, 11, -11673.3, -3146.8, 17.9156, 100.0, 0),
(@PATH, 12, -11668.1, -3161.96, 17.7618, 100.0, 0);



/*  Wretched Lost One - GUID 3860  */


SET @NPC := 3860;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10999.0, `position_y` = -2800.09, `position_z` = 5.62823, `orientation` = -2.44515 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10999.0, -2800.09, 5.62823, 100.0, 0),
(@PATH, 2, -11005.3, -2773.62, 4.31754, 100.0, 0),
(@PATH, 3, -11007.8, -2751.05, 4.83231, 100.0, 0),
(@PATH, 4, -11028.3, -2729.71, 7.94714, 100.0, 0),
(@PATH, 5, -11055.4, -2735.16, 9.8893, 100.0, 0),
(@PATH, 6, -11096.7, -2743.91, 14.8477, 100.0, 0),
(@PATH, 7, -11115.9, -2715.93, 11.3128, 100.0, 0),
(@PATH, 8, -11131.5, -2726.57, 12.3768, 100.0, 0),
(@PATH, 9, -11120.2, -2756.56, 17.4683, 100.0, 0),
(@PATH, 10, -11096.9, -2769.01, 14.2931, 100.0, 0),
(@PATH, 11, -11080.0, -2782.48, 8.97423, 100.0, 0),
(@PATH, 12, -11059.6, -2817.04, 9.30728, 100.0, 0),
(@PATH, 13, -11040.7, -2835.05, 13.2246, 100.0, 0),
(@PATH, 14, -11023.0, -2860.15, 9.30639, 100.0, 0),
(@PATH, 15, -11004.0, -2879.04, 9.54558, 100.0, 0),
(@PATH, 16, -10980.4, -2878.03, 4.31457, 100.0, 0),
(@PATH, 17, -10970.3, -2856.53, 5.85792, 100.0, 0),
(@PATH, 18, -10957.9, -2843.16, 6.3895, 100.0, 0),
(@PATH, 19, -10965.6, -2836.89, 10.2696, 100.0, 0),
(@PATH, 20, -10994.8, -2804.28, 5.58265, 100.0, 0);


/*  Nethergarde Foreman - GUID 3863  */


SET @NPC := 3863;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10858.6, `position_y` = -3173.48, `position_z` = 47.9651, `orientation` = 2.17203 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10858.6, -3173.48, 47.9651, 100.0, 0),
(@PATH, 2, -10834.9, -3170.2, 43.8266, 100.0, 0),
(@PATH, 3, -10810.5, -3157.26, 38.1632, 100.0, 0),
(@PATH, 4, -10793.3, -3130.43, 39.808, 100.0, 0),
(@PATH, 5, -10793.9, -3106.77, 42.466, 100.0, 0),
(@PATH, 6, -10805.1, -3080.42, 44.5298, 100.0, 0),
(@PATH, 7, -10822.1, -3058.07, 46.827, 100.0, 0),
(@PATH, 8, -10835.2, -3037.96, 47.9975, 100.0, 0),
(@PATH, 9, -10854.8, -3030.38, 48.6057, 100.0, 0),
(@PATH, 10, -10843.2, -3033.76, 48.9103, 100.0, 0),
(@PATH, 11, -10825.1, -3053.99, 47.1558, 100.0, 0),
(@PATH, 12, -10810.0, -3073.3, 45.9343, 100.0, 0),
(@PATH, 13, -10796.5, -3097.89, 43.0488, 100.0, 0),
(@PATH, 14, -10792.1, -3125.45, 40.4063, 100.0, 0),
(@PATH, 15, -10804.3, -3150.36, 37.9849, 100.0, 0),
(@PATH, 16, -10829.8, -3168.39, 42.7027, 100.0, 0),
(@PATH, 17, -10853.0, -3172.71, 46.8383, 100.0, 0),
(@PATH, 18, -10889.0, -3176.64, 49.6548, 100.0, 0),
(@PATH, 19, -10907.1, -3179.64, 49.0975, 100.0, 0),
(@PATH, 20, -10895.2, -3177.57, 48.9644, 100.0, 0),
(@PATH, 21, -10863.2, -3173.96, 48.5966, 100.0, 0);


/*  Nethergarde Foreman - GUID 3878  */


SET @NPC := 3878;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10714.0, `position_y` = -3148.43, `position_z` = 30.0566, `orientation` = 0.60608 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10714.0, -3148.43, 30.0566, 100.0, 0),
(@PATH, 2, -10697.5, -3165.31, 23.1402, 100.0, 0),
(@PATH, 3, -10692.4, -3146.68, 21.981, 100.0, 0),
(@PATH, 4, -10727.9, -3132.28, 33.6175, 100.0, 0),
(@PATH, 5, -10766.1, -3124.32, 36.3195, 100.0, 0),
(@PATH, 6, -10734.1, -3130.41, 34.1391, 100.0, 0),
(@PATH, 7, -10697.5, -3143.38, 24.0037, 100.0, 0),
(@PATH, 8, -10669.3, -3171.65, 20.0758, 100.0, 0),
(@PATH, 9, -10655.3, -3191.03, 23.6126, 100.0, 0),
(@PATH, 10, -10658.6, -3199.02, 22.5891, 100.0, 0),
(@PATH, 11, -10670.0, -3200.39, 21.5484, 100.0, 0),
(@PATH, 12, -10691.3, -3172.31, 20.4547, 100.0, 0),
(@PATH, 13, -10710.2, -3152.99, 28.6011, 100.0, 0),
(@PATH, 14, -10727.8, -3126.52, 33.9305, 100.0, 0),
(@PATH, 15, -10764.6, -3112.06, 36.036, 100.0, 0),
(@PATH, 16, -10734.4, -3122.79, 33.9899, 100.0, 0),
(@PATH, 17, -10714.9, -3146.92, 30.296, 100.0, 0);


/*  Felguard Sentry - GUID 3883  */


SET @NPC := 3883;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11717.8, `position_y` = -3079.98, `position_z` = 16.7711, `orientation` = 3.79812 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11748.0, -3072.61, 12.723, 100.0, 0),
(@PATH, 2, -11768.6, -3062.86, 11.6676, 100.0, 0),
(@PATH, 3, -11784.8, -3051.62, 12.8146, 100.0, 0),
(@PATH, 4, -11804.2, -3045.84, 11.1862, 100.0, 0),
(@PATH, 5, -11792.7, -3047.8, 12.6724, 100.0, 0),
(@PATH, 6, -11772.6, -3060.12, 11.4166, 100.0, 0),
(@PATH, 7, -11755.9, -3071.26, 11.3215, 100.0, 0),
(@PATH, 8, -11744.9, -3071.97, 13.5623, 100.0, 0),
(@PATH, 9, -11733.9, -3075.55, 14.8634, 100.0, 0),
(@PATH, 10, -11717.8, -3079.98, 16.7711, 100.0, 0),
(@PATH, 11, -11725.6, -3078.5, 15.7444, 100.0, 0),
(@PATH, 12, -11740.5, -3072.44, 14.1576, 100.0, 0);


/*  Wretched Lost One - GUID 3905  */


SET @NPC := 3905;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11085.8, `position_y` = -2859.62, `position_z` = 11.0827, `orientation` = 5.837 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11085.8, -2859.62, 11.0827, 100.0, 0),
(@PATH, 2, -11089.8, -2847.19, 13.748, 100.0, 0),
(@PATH, 3, -11090.7, -2826.35, 19.1503, 100.0, 0),
(@PATH, 4, -11085.1, -2812.46, 12.5627, 100.0, 0),
(@PATH, 5, -11074.9, -2792.95, 8.73555, 100.0, 0),
(@PATH, 6, -11089.0, -2775.96, 11.4759, 100.0, 0),
(@PATH, 7, -11110.7, -2761.69, 16.8771, 100.0, 0),
(@PATH, 8, -11139.0, -2748.69, 15.1873, 100.0, 0),
(@PATH, 9, -11167.1, -2734.94, 15.0996, 100.0, 0),
(@PATH, 10, -11205.2, -2727.85, 14.5844, 100.0, 0),
(@PATH, 11, -11174.0, -2732.59, 15.0697, 100.0, 0),
(@PATH, 12, -11149.6, -2743.74, 15.2432, 100.0, 0),
(@PATH, 13, -11117.0, -2758.03, 17.2808, 100.0, 0),
(@PATH, 14, -11094.6, -2772.21, 13.4907, 100.0, 0),
(@PATH, 15, -11076.8, -2784.46, 8.52577, 100.0, 0),
(@PATH, 16, -11079.9, -2802.41, 9.74095, 100.0, 0),
(@PATH, 17, -11089.5, -2821.1, 17.105, 100.0, 0),
(@PATH, 18, -11091.1, -2837.12, 16.4493, 100.0, 0),
(@PATH, 19, -11087.7, -2853.55, 11.6245, 100.0, 0),
(@PATH, 20, -11073.1, -2869.51, 9.89613, 100.0, 0),
(@PATH, 21, -11061.3, -2866.45, 10.5352, 100.0, 0),
(@PATH, 22, -11039.8, -2866.83, 9.46481, 100.0, 0),
(@PATH, 23, -11017.5, -2868.7, 9.05997, 100.0, 0),
(@PATH, 24, -11000.6, -2888.18, 9.75397, 100.0, 0),
(@PATH, 25, -11010.3, -2873.07, 9.3845, 100.0, 0),
(@PATH, 26, -11030.5, -2867.9, 9.21214, 100.0, 0),
(@PATH, 27, -11052.6, -2864.22, 10.3806, 100.0, 0),
(@PATH, 28, -11069.0, -2870.14, 9.94091, 100.0, 0),
(@PATH, 29, -11083.4, -2861.5, 10.826, 100.0, 0);


/*  Felguard Sentry - GUID 3913  */


SET @NPC := 3913;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11736.3, `position_y` = -3259.69, `position_z` = 3.54905, `orientation` = 4.5376 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11736.3, -3259.69, 3.54905, 100.0, 0),
(@PATH, 2, -11749.5, -3274.19, 5.63097, 100.0, 0),
(@PATH, 3, -11767.4, -3293.38, 4.19673, 100.0, 0),
(@PATH, 4, -11787.8, -3305.24, 6.42096, 100.0, 0),
(@PATH, 5, -11816.1, -3315.23, 7.21743, 100.0, 0),
(@PATH, 6, -11836.1, -3319.79, 4.44235, 100.0, 0),
(@PATH, 7, -11821.1, -3316.57, 8.00434, 100.0, 0),
(@PATH, 8, -11796.0, -3308.72, 4.61497, 100.0, 0),
(@PATH, 9, -11774.5, -3298.33, 6.61566, 100.0, 0),
(@PATH, 10, -11755.6, -3280.86, 4.93735, 100.0, 0),
(@PATH, 11, -11750.2, -3274.98, 5.73358, 100.0, 0),
(@PATH, 12, -11750.2, -3274.98, 5.73358, 100.0, 0),
(@PATH, 13, -11739.6, -3263.25, 2.58626, 100.0, 0),
(@PATH, 14, -11726.8, -3254.63, 5.70093, 100.0, 0),
(@PATH, 15, -11715.0, -3229.81, 7.3399, 100.0, 0),
(@PATH, 16, -11705.7, -3204.77, 6.76301, 100.0, 0),
(@PATH, 17, -11714.7, -3119.52, 9.6553, 100.0, 0),
(@PATH, 18, -11724.7, -3103.51, 11.5906, 100.0, 0),
(@PATH, 19, -11737.6, -3094.55, 10.0939, 100.0, 0),
(@PATH, 20, -11759.4, -3089.36, 7.90247, 100.0, 0),
(@PATH, 21, -11777.3, -3082.01, 3.71249, 100.0, 0),
(@PATH, 22, -11802.8, -3071.57, 6.52768, 100.0, 0),
(@PATH, 23, -11833.5, -3061.21, 5.51503, 100.0, 0),
(@PATH, 24, -11855.2, -3053.98, 10.5513, 100.0, 0),
(@PATH, 25, -11866.7, -3053.56, 13.575, 100.0, 0),
(@PATH, 26, -11878.8, -3067.78, 25.3558, 100.0, 0),
(@PATH, 27, -11885.3, -3081.64, 29.9102, 100.0, 0),
(@PATH, 28, -11898.3, -3091.15, 33.1133, 100.0, 0),
(@PATH, 29, -11891.4, -3087.62, 30.8659, 100.0, 0),
(@PATH, 30, -11880.8, -3071.89, 27.2562, 100.0, 0),
(@PATH, 31, -11873.3, -3056.77, 16.8792, 100.0, 0),
(@PATH, 32, -11864.1, -3053.36, 12.838, 100.0, 0),
(@PATH, 33, -11842.5, -3058.19, 5.18285, 100.0, 0),
(@PATH, 34, -11811.8, -3068.34, 6.53923, 100.0, 0),
(@PATH, 35, -11785.4, -3078.3, 4.92409, 100.0, 0),
(@PATH, 36, -11768.3, -3086.51, 7.10831, 100.0, 0),
(@PATH, 37, -11745.5, -3091.76, 6.49939, 100.0, 0),
(@PATH, 38, -11728.5, -3099.67, 11.1712, 100.0, 0),
(@PATH, 39, -11717.2, -3115.41, 8.65608, 100.0, 0),
(@PATH, 40, -11709.5, -3132.75, 9.94938, 100.0, 0),
(@PATH, 41, -11699.9, -3161.87, 9.60486, 100.0, 0),
(@PATH, 42, -11695.3, -3181.58, 10.3783, 100.0, 0),
(@PATH, 43, -11702.7, -3198.54, 6.13815, 100.0, 0),
(@PATH, 44, -11714.2, -3227.76, 7.42097, 100.0, 0),
(@PATH, 45, -11720.7, -3247.27, 6.71452, 100.0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_18_07' WHERE sql_rev = '1647361710364876100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
