--
/*  Defias Miner  - GUID 79127  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79127;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79127, 79127, 0, 0, 3, 0, 0);

/*  Defias Miner  - GUID 79134  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79134;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79127, 79134, 0.0, 0.0, 3, 0, 0);

/*  Defias Miner  - GUID 79136  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79136;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79136, 79136, 0, 0, 3, 0, 0);

/*  Defias Overseer  - GUID 79151  */

UPDATE `creature` SET `position_x` = -90.571, `position_y` = -400.149, `position_z` = 58.4755, `orientation` = 3.20291 WHERE `guid` = 79151;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79151;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79188, 79151, 2.0, 89.95437383553926, 519, 0, 0);

/*  Defias Miner  - GUID 79160  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79160;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79160, 79160, 0, 0, 3, 0, 0);

/*  Defias Overseer  - GUID 79170  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79170;
DELETE FROM `creature_addon` WHERE `guid` = 79170;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79170, 7917000);

DELETE FROM `waypoint_data` WHERE `id` = 7917000;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7917000, 1, -190.081, -480.93, 54.0442, 4.72042, 0),
(7917000, 2, -187.47, -492.907, 53.563, 4.92698, 0),
(7917000, 3, -193.975, -504.087, 53.1475, 3.58002, 0),
(7917000, 4, -209.675, -506.274, 51.2768, 2.98312, 0),
(7917000, 5, -220.823, -492.074, 48.2184, 2.27233, 0),
(7917000, 6, -235.942, -483.635, 49.0422, 3.03809, 0),
(7917000, 7, -244.61, -482.027, 48.8547, 0.104633, 0),
(7917000, 8, -229.791, -484.612, 48.8188, 5.98727, 0),
(7917000, 9, -217.823, -497.897, 49.23, 5.36681, 0),
(7917000, 10, -206.083, -505.612, 51.9032, 5.88517, 0),
(7917000, 11, -191.232, -503.006, 52.9131, 0.253858, 0),
(7917000, 12, -187.267, -492.515, 53.5679, 0.540529, 0),
(7917000, 13, -189.152, -483.356, 54.0488, 1.53798, 0);
DELETE FROM `creature_formations` WHERE `memberGUID` = 79170;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79170, 79170, 0, 0, 519, 0, 0);

/*  Defias Evoker  - GUID 79171  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79171;
DELETE FROM `creature_addon` WHERE `guid` = 79171;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79171, 7917100);

DELETE FROM `waypoint_data` WHERE `id` = 7917100;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7917100, 1, -153.951, -517.067, 52.5085, 1.98408, 0),
(7917100, 2, -158.165, -508.746, 53.4221, 4.72905, 0),
(7917100, 3, -171.265, -505.67, 53.7993, 2.74199, 0),
(7917100, 4, -182.304, -499.904, 53.5155, 2.21577, 0),
(7917100, 5, -188.829, -484.756, 54.0488, 1.89376, 0),
(7917100, 6, -189.451, -497.05, 53.3645, 4.27352, 0),
(7917100, 7, -195.512, -504.183, 53.144, 3.73159, 0),
(7917100, 8, -209.55, -505.987, 51.3288, 2.47888, 0),
(7917100, 9, -222.604, -490.607, 48.3476, 2.30609, 0),
(7917100, 10, -234.403, -483.539, 49.0352, 2.84802, 0),
(7917100, 11, -250.934, -482.922, 49.4486, 3.10327, 0),
(7917100, 12, -229.54, -486.109, 48.6882, 5.7807, 0),
(7917100, 13, -218.519, -496.638, 48.9294, 5.36837, 0),
(7917100, 14, -205.659, -505.366, 51.9966, 6.0713, 0),
(7917100, 15, -187.638, -497.089, 53.4258, 1.64558, 0),
(7917100, 16, -188.134, -483.888, 54.0488, 1.58668, 0),
(7917100, 17, -181.332, -500.802, 53.497, 5.28983, 0),
(7917100, 18, -170.014, -506.459, 53.6273, 6.0281, 0),
(7917100, 19, -156.823, -509.046, 53.4042, 4.77539, 0),
(7917100, 20, -153.8, -518.653, 52.458, 5.04242, 0);
DELETE FROM `creature_formations` WHERE `memberGUID` = 79171;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79171, 79171, 0, 0, 3, 0, 0);

/*  Defias Evoker  - GUID 79177  */

UPDATE `creature` SET `position_x` = -189.848, `position_y` = -479.181, `position_z` = 54.045, `orientation` = 4.91698 WHERE `guid` = 79177;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79177;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79170, 79177, 1.5, 89.95437383553926, 519, 0, 0);

/*  Goblin Woodcarver  - GUID 79193  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79193;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79193, 79193, 0, 0, 3, 0, 0);

/*  Goblin Engineer  - GUID 79196  */

UPDATE `creature` SET `position_x` = -187.23, `position_y` = -549.39, `position_z` = 19.3, `orientation` = 4.45445 WHERE `guid` = 79196;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79196;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79196, 79196, 0, 0, 3, 0, 0);

/*  Goblin Craftsman  - GUID 79197  */

UPDATE `creature` SET `position_x` = -210.095, `position_y` = -552.754, `position_z` = 19.3065, `orientation` = 3.36937 WHERE `guid` = 79197;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79197;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79197, 79197, 0, 0, 3, 0, 0);

/*  Goblin Engineer  - GUID 79198  */

UPDATE `creature` SET `position_x` = -207.133, `position_y` = -551.25, `position_z` = 19.3065, `orientation` = 0.779517 WHERE `guid` = 79198;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79198;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79197, 79198, 0.0, 0.0, 3, 0, 0);

/*  Goblin Craftsman  - GUID 79201  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79201;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79196, 79201, 0.0, 0.0, 3, 0, 0);

/*  Goblin Craftsman  - GUID 79205  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79205;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79205, 79205, 0, 0, 3, 0, 0);

/*  Gilnid  - GUID 79206  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79206;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79206, 79206, 0, 0, 3, 0, 0);

/*  Goblin Woodcarver  - GUID 79207  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79207;
DELETE FROM `creature_addon` WHERE `guid` = 79207;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79207, 7920700);

DELETE FROM `waypoint_data` WHERE `id` = 7920700;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7920700, 1, -283.242, -513.183, 49.0546, 4.79239, 0),
(7920700, 2, -284.152, -531.136, 49.2175, 1.70813, 0),
(7920700, 3, -290.872, -533.825, 49.4501, 0.121625, 0),
(7920700, 4, -290.716, -504.662, 50.0333, 4.60232, 0),
(7920700, 5, -271.187, -482.45, 48.921, 3.95043, 0),
(7920700, 6, -282.772, -496.034, 49.2864, 4.18212, 0);

/*  Goblin Engineer  - GUID 79208  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79208;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79205, 79208, 0.0, 0.0, 3, 0, 0);

/*  Goblin Craftsman  - GUID 79211  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79211;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79206, 79211, 0.0, 0.0, 3, 0, 0);

/*  Goblin Engineer  - GUID 79213  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79213;
DELETE FROM `creature_addon` WHERE `guid` = 79213;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79213, 7921300);

DELETE FROM `waypoint_data` WHERE `id` = 7921300;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7921300, 1, -234.377, -589.598, 19.3071, 1.52281, 0),
(7921300, 2, -235.564, -576.039, 19.3071, 1.35002, 0),
(7921300, 3, -229.963, -563.706, 19.3071, 1.04764, 0),
(7921300, 4, -220.842, -555.834, 19.3071, 0.631381, 0),
(7921300, 5, -210.288, -552.669, 19.3071, 0.203338, 0),
(7921300, 6, -198.858, -552.138, 19.3071, 6.11346, 0),
(7921300, 7, -188.165, -556.427, 19.3071, 5.57546, 0),
(7921300, 8, -180.023, -566.472, 19.3079, 5.13564, 0),
(7921300, 9, -177.207, -586.139, 19.3198, 1.67518, 0),
(7921300, 10, -177.487, -584.147, 19.3164, 1.71053, 0),
(7921300, 11, -178.32, -583.971, 19.317, 1.54166, 0),
(7921300, 12, -179.89, -567.017, 19.3091, 1.78672, 0),
(7921300, 13, -189.352, -555.185, 19.3077, 2.4229, 0),
(7921300, 14, -197.542, -551.851, 19.3077, 2.98053, 0),
(7921300, 15, -209.959, -552.603, 19.3077, 3.36537, 0),
(7921300, 16, -220.52, -555.795, 19.3077, 3.95128, 0),
(7921300, 17, -229.166, -563.003, 19.3077, 4.13192, 0),
(7921300, 18, -234.725, -575.257, 19.3077, 4.53561, 0),
(7921300, 19, -233.679, -588.712, 19.3077, 4.85134, 0);

/*  Defias Taskmaster  - GUID 79214  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79214;
DELETE FROM `creature_addon` WHERE `guid` = 79214;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79214, 7921400);

DELETE FROM `waypoint_data` WHERE `id` = 7921400;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7921400, 1, -141.372, -579.397, 18.6903, 5.59869, 0),
(7921400, 2, -131.908, -592.661, 17.8248, 4.77009, 0),
(7921400, 3, -132.482, -608.359, 14.0761, 4.67585, 0),
(7921400, 4, -130.692, -623.219, 13.059, 5.20991, 0),
(7921400, 5, -125.646, -636.321, 12.8268, 5.28845, 0),
(7921400, 6, -108.726, -644.974, 8.19231, 5.26096, 0),
(7921400, 7, -126.729, -635.659, 12.8837, 1.95442, 0),
(7921400, 8, -131.083, -621.164, 13.0504, 1.87195, 0);

/*  Goblin Craftsman  - GUID 79218  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79218;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79218, 79218, 0, 0, 3, 0, 0);

/*  Goblin Woodcarver  - GUID 79219  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79219;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79219, 79219, 0, 0, 3, 0, 0);

/*  Goblin Woodcarver  - GUID 79220  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79220;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79193, 79220, 0.0, 0.0, 3, 0, 0);

/*  Defias Taskmaster  - GUID 79233  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79233;
DELETE FROM `creature_addon` WHERE `guid` = 79233;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79233, 7923300);

DELETE FROM `waypoint_data` WHERE `id` = 7923300;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7923300, 1, -270.347, -583.559, 49.9629, 5.63651, 0),
(7923300, 2, -275.479, -592.516, 51.2754, 4.22123, 0),
(7923300, 3, -278.652, -592.354, 50.9278, 3.98325, 0),
(7923300, 4, -279.293, -588.709, 50.7539, 1.24064, 0),
(7923300, 5, -275.266, -581.112, 50.2998, 1.02937, 0),
(7923300, 6, -269.277, -575.118, 50.3089, 0.075108, 0),
(7923300, 7, -258.154, -574.293, 51.1511, 0.07118, 0),
(7923300, 8, -252.396, -579.794, 51.1481, 3.29918, 0),
(7923300, 9, -261.17, -582.182, 50.66, 3.17273, 0);

/*  Defias Strip Miner  - GUID 79240  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79240;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79240, 79240, 0, 0, 3, 0, 0);

/*  Goblin Craftsman  - GUID 79242  */

UPDATE `creature` SET `position_x` = -208.324, `position_y` = -606.89, `position_z` = 28.3691, `orientation` = 3.16188 WHERE `guid` = 79242;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79242;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79242, 79242, 0, 0, 3, 0, 0);

/*  Goblin Craftsman  - GUID 79243  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79243;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79242, 79243, 0.0, 0.0, 3, 0, 0);

/*  Defias Pirate  - GUID 79292  */

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 79292;
DELETE FROM `creature_addon` WHERE `guid` = 79292;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (79292, 7929200);

DELETE FROM `waypoint_data` WHERE `id` = 7929200;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(7929200, 1, -97.1064, -724.403, 8.3481, 1.49925, 0),
(7929200, 2, -95.907, -704.224, 8.88853, 1.52282, 0),
(7929200, 3, -96.5913, -685.761, 7.43101, 1.66026, 0);

/*  Defias Pirate  - GUID 79297  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79297;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79297, 79297, 0, 0, 3, 0, 0);

/*  Defias Pirate  - GUID 79300  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79300;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79300, 79300, 0, 0, 3, 0, 0);

/*  Goblin Shipbuilder  - GUID 79304  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79304;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79304, 79304, 0, 0, 3, 0, 0);

/*  Defias Pirate  - GUID 79305  */

UPDATE `creature` SET `position_x` = -79.6583, `position_y` = -782.438, `position_z` = 17.965, `orientation` = 0.686417 WHERE `guid` = 79305;

DELETE FROM `creature_formations` WHERE `memberGUID` = 79305;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79305, 79305, 0, 0, 3, 0, 0);

/*  Goblin Shipbuilder  - GUID 79309  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79309;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79309, 79309, 0, 0, 3, 0, 0);

/*  Defias Pirate  - GUID 79311  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79311;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79304, 79311, 0.0, 0.0, 3, 0, 0);

/*  Goblin Shipbuilder  - GUID 79319  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79319;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79319, 79319, 0, 0, 3, 0, 0);

/*  Goblin Shipbuilder  - GUID 79320  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79320;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79320, 79320, 0, 0, 3, 0, 0);

/*  Defias Pirate  - GUID 79323  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79323;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79323, 79323, 0, 0, 3, 0, 0);

/*  Goblin Shipbuilder  - GUID 79325  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79325;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79323, 79325, 0.0, 0.0, 3, 0, 0);

/*  Defias Squallshaper  - GUID 79327  */

DELETE FROM `creature_formations` WHERE `memberGUID` = 79327;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(79309, 79327, 0.0, 0.0, 3, 0, 0);
