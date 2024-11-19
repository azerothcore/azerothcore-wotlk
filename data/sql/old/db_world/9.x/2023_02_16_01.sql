-- DB update 2023_02_16_00 -> 2023_02_16_01
-- Remove all of the same Ids, remove non-combat pet, remove mines
DELETE FROM `creature` WHERE `id1` IN (19754,19756,19757,19759,19760,20872,20878,20887,21080,21207,21210,21211,21725,22024,18381,22315) AND `map`=530;

SET @CGUID := 83028;

DELETE FROM `creature` WHERE `id1` IN (19754,19756,19757,19759,19760,20872,20878,20887,21080,21207,21210,21211,21725,22024) AND `map`=530 AND `ZoneId`=3520 AND `guid` BETWEEN @CGUID+0 AND @CGUID+84;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0 , 19754, 530, 3520, 3748, 1, 1, 0, -3471.39, 2147.28, 33.2387, 5.74268, 300, 4, 1, 0, 0, 48001),
(@CGUID+1 , 19754, 530, 3520, 3748, 1, 1, 0, -3473.13, 2222.15, 33.5265, 0.567704, 300, 0, 0, 0, 0, 48001),
(@CGUID+2 , 19754, 530, 3520, 3748, 1, 1, 0, -3483.68, 2185.69, 33.5114, 3.69491, 300, 4, 1, 0, 0, 48001),
(@CGUID+3 , 19754, 530, 3520, 3748, 1, 1, 0, -3451.49, 2221.58, 33.4266, 5.38249, 300, 0, 0, 0, 0, 48001),
(@CGUID+4 , 19754, 530, 3520, 3748, 1, 1, 0, -3484.9, 2227.74, 33.5262, 1.15788, 300, 5, 1, 0, 0, 48001),
(@CGUID+5 , 19754, 530, 3520, 3748, 1, 1, 0, -3457.4, 2231.82, 33.6344, 3.76717, 300, 0, 0, 0, 0, 48001),
(@CGUID+6 , 19756, 530, 3520, 3748, 1, 1, 0, -3460.3118, 2176.2397, 33.525658, 4.537856101989746093, 300, 0, 0, 0, 0, 48001),
(@CGUID+7 , 19756, 530, 3520, 3748, 1, 1, 0, -3490.547, 2153.1892, 33.485687, 0.03490658476948738, 300, 0, 0, 0, 0, 48001),
(@CGUID+8 , 19756, 530, 3520, 3748, 1, 1, 0, -3470.43, 2181.19, 33.5385, 2.699963, 300, 0, 0, 0, 0, 48001),
(@CGUID+9 , 19756, 530, 3520, 3748, 1, 1, 0, -3466.94, 2202.81, 33.603, 3.31613, 300, 0, 0, 0, 0, 48001),
(@CGUID+10, 19756, 530, 3520, 3748, 1, 1, 0, -3502.97, 2183.39, 33.611, 5.75959, 300, 0, 0, 0, 0, 48001),
(@CGUID+11, 19756, 530, 3520, 3748, 1, 1, 0, -3498.51, 2210.14, 33.6135, 5.72468, 300, 0, 0, 0, 0, 48001),
(@CGUID+12, 19759, 530, 3520, 3748, 1, 1, 0, -3448.43, 2240.86, 33.7625, 2.36354, 300, 5, 1, 0, 0, 48001),
(@CGUID+13, 19759, 530, 3520, 3748, 1, 1, 0, -3555.51, 2190.91, 30.1227, 5.32783, 300, 4, 1, 0, 0, 48001),
(@CGUID+14, 19759, 530, 3520, 3748, 1, 1, 0, -3418.07, 2255.31, 33.6775, 2.97726, 300, 5, 1, 0, 0, 48001),
(@CGUID+15, 19760, 530, 3520, 3748, 1, 1, 0, -3475.41, 2170.14, 32.8636, 5.41052, 300, 0, 0, 33554432, 0, 48001),
(@CGUID+16, 19760, 530, 3520, 3748, 1, 1, 0, -3483.61, 2201.5, 32.8564, 5.06145, 300, 0, 0, 33554432, 0, 48001),
(@CGUID+17, 19760, 530, 3520, 3748, 1, 1, 0, -3554.93, 2140.11, 24.1701, 5.76413, 300, 8, 1, 0, 0, 48001),
(@CGUID+22, 20872, 530, 3520, 3748, 1, 1, 1, -3291.68, 1923.85, 143.069, 5.06823, 300, 0, 0, 0, 0, 48001),
(@CGUID+23, 20872, 530, 3520, 3748, 1, 1, 1, -3223.39, 1961.9, 109.363, 4.30813, 300, 0, 0, 0, 0, 48001),
(@CGUID+24, 20872, 530, 3520, 3748, 1, 1, 1, -3302.89, 2000.53, 46.7258, 5.07585, 300, 0, 0, 0, 0, 48001),
(@CGUID+25, 20872, 530, 3520, 3748, 1, 1, 1, -3275.83, 2026.08, 63.7421, 4.75732, 300, 0, 0, 0, 0, 48001),
(@CGUID+26, 20872, 530, 3520, 3748, 1, 1, 1, -3335.89, 2133.7, -2.183, 2.51327, 300, 0, 0, 0, 0, 48001),
(@CGUID+27, 20872, 530, 3520, 3748, 1, 1, 1, -3361.14, 2088.28, 4.8676, 0.819882, 300, 0, 0, 0, 0, 48001),
(@CGUID+28, 20872, 530, 3520, 3748, 1, 1, 1, -3335.6, 2151.81, -1.21132, 3.00197, 300, 0, 0, 0, 0, 48001),
(@CGUID+29, 20872, 530, 3520, 3748, 1, 1, 1, -3341.74, 2168.38, 2.22799, 3.9968, 300, 0, 0, 0, 0, 48001),
(@CGUID+30, 20872, 530, 3520, 3748, 1, 1, 1, -3415.38, 2095.36, 34.1878, 6.21337, 300, 0, 0, 0, 0, 48001),
(@CGUID+31, 20872, 530, 3520, 3748, 1, 1, 1, -3413.25, 2132.96, 34.4846, 4.97419, 300, 0, 0, 0, 0, 48001),
(@CGUID+32, 20872, 530, 3520, 3748, 1, 1, 1, -3437.93, 2131.51, 33.8578, 5.30604, 300, 0, 0, 0, 0, 48001),
(@CGUID+33, 20872, 530, 3520, 3748, 1, 1, 1, -3410.42, 2321.58, 37.2106, 4.72984, 300, 0, 0, 0, 0, 48001),
(@CGUID+34, 20878, 530, 3520, 3748, 1, 1, 1, -3292.99, 1907.61, 142.326, 0.122173, 300, 0, 0, 0, 0, 48001),
(@CGUID+35, 20878, 530, 3520, 3748, 1, 1, 1, -3223.44, 1969.5, 144.56, 5.32325, 300, 0, 0, 0, 0, 48001),
(@CGUID+36, 20878, 530, 3520, 3748, 1, 1, 1, -3258.72, 2051.92, 74.4014, 1.46608, 300, 0, 0, 0, 0, 48001),
(@CGUID+37, 20878, 530, 3520, 3748, 1, 1, 1, -3216.56, 2054.98, 84.2059, 4.36162, 300, 5, 1, 0, 0, 48001),
(@CGUID+38, 20878, 530, 3520, 3748, 1, 1, 1, -3295, 2059.66, 76.2516, 1.20428, 300, 0, 0, 0, 0, 48001),
(@CGUID+39, 20878, 530, 3520, 3748, 1, 1, 1, -3341.51, 2016.82, 33.6518, 5.42797, 300, 0, 0, 0, 0, 48001),
(@CGUID+40, 20878, 530, 3520, 3748, 1, 1, 1, -3280.61, 2093.41, 82.6315, 5.44455, 300, 10, 1, 0, 0, 48001),
(@CGUID+41, 20878, 530, 3520, 3748, 1, 1, 1, -3285.27, 2135.91, 85.348, 5.00357, 300, 10, 1, 0, 0, 48001),
(@CGUID+42, 20878, 530, 3520, 3748, 1, 1, 1, -3363.54, 2046.37, 39.0521, 5.18363, 300, 0, 0, 0, 0, 48001),
(@CGUID+43, 20878, 530, 3520, 3748, 1, 1, 1, -3356.56, 2107.09, 11.9433, 0.484243, 300, 4, 1, 0, 0, 48001),
(@CGUID+44, 20878, 530, 3520, 3748, 1, 1, 1, -3361.23, 1980.19, 26.3597, 1.76278, 300, 0, 0, 0, 0, 48001),
(@CGUID+45, 20878, 530, 3520, 3748, 1, 1, 1, -3376.09, 2038.66, 37.6801, 5.91667, 300, 0, 0, 0, 0, 48001),
(@CGUID+46, 20878, 530, 3520, 3748, 1, 1, 1, -3396.01, 2036.34, 20.4044, 3.31276, 300, 5, 1, 0, 0, 48001),
(@CGUID+47, 20878, 530, 3520, 3748, 1, 1, 1, -3392.49, 2062.84, 14.4613, 3.0207, 300, 4, 1, 0, 0, 48001),
(@CGUID+48, 20878, 530, 3520, 3748, 1, 1, 1, -3373.86, 2098, 34.0214, 5.07891, 300, 0, 0, 0, 0, 48001),
(@CGUID+49, 20878, 530, 3520, 3748, 1, 1, 1, -3396.89, 2070.46, 34.0593, 5.65487, 300, 0, 0, 0, 0, 48001),
(@CGUID+50, 20878, 530, 3520, 3748, 1, 1, 1, -3396.38, 2101.97, 77.6685, 3.68218, 300, 10, 1, 0, 0, 48001),
(@CGUID+51, 20878, 530, 3520, 3748, 1, 1, 1, -3415.89, 2058.72, 15.4273, 0.96285, 300, 4, 1, 0, 0, 48001),
(@CGUID+52, 20878, 530, 3520, 3748, 1, 1, 1, -3438.19, 2059.36, 15.2807, 2.66248, 300, 4, 1, 0, 0, 48001),
(@CGUID+53, 20878, 530, 3520, 3748, 1, 1, 1, -3387.48, 1996.93, 25.9171, 4.85202, 300, 0, 0, 0, 0, 48001),
(@CGUID+54, 20878, 530, 3520, 3748, 1, 1, 1, -3422.34, 2032.42, 79.414, 6.03884, 300, 10, 1, 0, 0, 48001),
(@CGUID+55, 20878, 530, 3520, 3748, 1, 1, 1, -3455.95, 2136.25, 31.6043, 0.15708, 300, 0, 0, 0, 0, 48001),
(@CGUID+56, 20878, 530, 3520, 3748, 1, 1, 1, -3440.93, 2151.51, 31.6043, 4.57276, 300, 0, 0, 0, 0, 48001),
(@CGUID+57, 20878, 530, 3520, 3748, 1, 1, 1, -3537.11, 2159.12, 34.0734, 0.872665, 300, 0, 0, 0, 0, 48001),
(@CGUID+58, 20878, 530, 3520, 3748, 1, 1, 1, -3541.49, 2176.84, 34.6825, 5.96903, 300, 0, 0, 0, 0, 48001),
(@CGUID+59, 20878, 530, 3520, 3748, 1, 1, 1, -3420.47, 2291.11, 33.8036, 5.11381, 300, 0, 0, 0, 0, 48001),
(@CGUID+60, 20878, 530, 3520, 3748, 1, 1, 1, -3405.89, 2290.53, 34.1082, 4.76475, 300, 0, 0, 0, 0, 48001),
(@CGUID+61, 20887, 530, 3520, 3748, 1, 1, 0, -3292.91, 1928.15, 143.472, 3.89206, 300, 0, 0, 0, 0, 48001),
(@CGUID+62, 20887, 530, 3520, 3748, 1, 1, 0, -3221.2, 1965.33, 109.058, 4.26113, 300, 0, 0, 0, 0, 48001),
(@CGUID+63, 20887, 530, 3520, 3748, 1, 1, 0, -3305.26, 1996.93, 47.4617, 5.07585, 300, 0, 0, 0, 0, 48001),
(@CGUID+64, 20887, 530, 3520, 3748, 1, 1, 0, -3272.2, 2023.24, 63.6514, 4.75732, 300, 0, 0, 0, 0, 48001),
(@CGUID+65, 20887, 530, 3520, 3748, 1, 1, 0, -3360.54, 2094.05, 5.31642, 0.819888, 300, 0, 0, 0, 0, 48001),
(@CGUID+66, 20887, 530, 3520, 3748, 1, 1, 0, -3412.58, 2100.51, 34.1129, 5.8287, 300, 5, 1, 0, 0, 48001),
(@CGUID+67, 20887, 530, 3520, 3748, 1, 1, 0, -3410.94, 2128.02, 34.3914, 6.07672, 300, 5, 1, 0, 0, 48001),
(@CGUID+68, 20887, 530, 3520, 3748, 1, 1, 0, -3433.5, 2131.21, 34.3465, 2.16448, 300, 0, 0, 0, 0, 48001),
(@CGUID+69, 20887, 530, 3520, 3748, 1, 1, 0, -3418.47, 2313.28, 37.0325, 4.43495, 300, 5, 1, 0, 0, 48001),
(@CGUID+70, 21080, 530, 3520, 3748, 1, 1, 0, -3456.48, 2241.29, 33.8697, 4.53786, 300, 0, 0, 0, 0, 48001),
(@CGUID+71, 21080, 530, 3520, 3748, 1, 1, 0, -3439.95, 2250.68, 33.574, 5.42797, 300, 0, 0, 0, 0, 48001),
(@CGUID+72, 21080, 530, 3520, 3748, 1, 1, 0, -3425.34, 2279.42, 33.4432, 1.09956, 300, 0, 0, 0, 0, 48001),
(@CGUID+73, 21080, 530, 3520, 3748, 1, 1, 0, -3404.85, 2266.46, 34.057, 2.74017, 300, 0, 0, 0, 0, 48001),
(@CGUID+74, 21080, 530, 3520, 3748, 1, 1, 0, -3422.23, 2237.42, 34.2742, 2.51327, 300, 0, 0, 0, 0, 48001),
(@CGUID+75, 21207, 530, 3520, 3748, 1, 1, 1, -3350.91, 2151.45, -7.08715, 3.71755, 300, 0, 0, 0, 0, 48001),
(@CGUID+76, 21210, 530, 3520, 3748, 1, 1, 0, -3366.9, 2121.34, -7.62779, 1.78024, 300, 0, 0, 0, 0, 48001),
(@CGUID+77, 21210, 530, 3520, 3748, 1, 1, 0, -3349.4, 2139.45, -7.73881, 3.15905, 300, 0, 0, 0, 0, 48001),
(@CGUID+78, 21210, 530, 3520, 3748, 1, 1, 0, -3368.91, 2145.37, -8.39026, 4.4855, 300, 0, 0, 0, 0, 48001),
(@CGUID+79, 21210, 530, 3520, 3748, 1, 1, 0, -3392.08, 2153.75, -7.5305, 6.16101, 300, 0, 0, 0, 0, 48001),
(@CGUID+80, 21210, 530, 3520, 3748, 1, 1, 0, -3369.89, 2164.47, -7.06302, 4.90438, 300, 0, 0, 0, 0, 48001),
(@CGUID+81, 21211, 530, 3520, 3748, 1, 1, 0, -3369, 2145.35, 2.92919, 1.309, 300, 0, 0, 0, 0, 48001),
(@CGUID+82, 21211, 530, 3520, 3748, 1, 1, 0, -3368.97, 2145.44, -8.01526, 1.13446, 300, 0, 0, 0, 0, 48001),
(@CGUID+83, 21725, 530, 3520, 3748, 1, 1, 0, -3421.36, 2289.39, 33.6348, 3.87463, 300, 0, 0, 0, 0, 48001),
(@CGUID+84, 22024, 530, 3520, 3748, 1, 1, 0, -3412.86, 2291.42, 63.1161, 3.12795, 300, 0, 0, 0, 0, 48001);

-- Pathing for Deathforge Smith Entry: 19756
SET @NPC := @CGUID+8;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3479.9746,`position_y`=2202.5378,`position_z`=33.05405 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3479.9746,2202.5378,33.05405,NULL,40000,0,0,100,0),
(@PATH,2,-3477.6575,2191.7336,33.01089,NULL,0,0,0,100,0),
(@PATH,3,-3474.3267,2184.2778,33.403313,NULL,0,0,0,100,0),
(@PATH,4,-3468.784,2179.888,33.52856,NULL,0,0,0,100,0),
(@PATH,5,-3467.121,2176.402,33.92342,NULL,0,0,0,100,0),
(@PATH,6,-3468.7075,2173.587,33.400917,NULL,0,0,0,100,0),
(@PATH,7,-3471.544,2172.4304,33.143215,NULL,0,0,0,100,0),
(@PATH,8,-3491.4849,2167.5889,34.046986,NULL,0,0,0,100,0),
(@PATH,9,-3493.7341,2188.488,33.526424,NULL,0,0,0,100,0),
(@PATH,10,-3487.2883,2193.0696,33.466507,NULL,0,0,0,100,0),
(@PATH,11,-3478.9119,2197.492,32.95795,NULL,0,0,0,100,0),
(@PATH,12,-3478.3247,2201.7632,33.23236,NULL,0,0,0,100,0),
(@PATH,13,-3479.9746,2202.5378,33.05405,NULL,80000,0,0,100,0),
(@PATH,14,-3478.9119,2197.492,32.95795,NULL,0,0,0,100,0),
(@PATH,15,-3477.9863,2199.7947,33.230984,NULL,0,0,0,100,0);
-- 0x2030FC4240134B0000392800016AA0E7 .go xyz -3479.9746 2202.5378 33.05405

-- GUID auras
DELETE FROM `creature_addon` WHERE `guid` IN (@CGUID+15, @CGUID+16, @CGUID+81,@CGUID+82,86493);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@CGUID+15,0,0,0,0,0,0, '31261'),
(@CGUID+16,0,0,0,0,0,0, '31261'),
(@CGUID+81,0,0,0,0,0,2, '30540'),
(@CGUID+82,0,0,0,0,0,2, '');

-- Cooling Infernal Flags
UPDATE `creature_template` SET `unit_flags` = 0 WHERE (`entry` = 19760);

-- Dormant Infernal Detection range
UPDATE `creature_template` SET `detection_range` = 10 WHERE (`entry` = 21080);

-- Dormant Infernal SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21080);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21080, 0, 0, 1, 25, 0, 100, 1, 0, 0, 0, 0, 0, 11, 36055, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dormant Infernal - On Reset - Cast \'Stationary Infernal Ball\' (No Repeat)'),
(21080, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 36, 21080, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dormant Infernal - On Reset - Update Template To \'Dormant Infernal\' (No Repeat)'),
(21080, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 0, 36, 19759, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dormant Infernal - On Aggro - Update Template To \'Newly Crafted Infernal\''),
(21080, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36055, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dormant Infernal - On Aggro - Remove Aura \'Stationary Infernal Ball\'');

-- Refactor
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19756) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19756, 0, 0, 0, 0, 0, 100, 0, 8000, 8000, 10000, 15000, 0, 11, 37580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Smith - In Combat - Cast \'Drill Armor\''),
(19756, 0, 1, 0, 0, 0, 100, 0, 12000, 12000, 12000, 16000, 0, 11, 36225, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Smith - In Combat - Cast \'Chaos Nova\'');

-- Invis Deathforge Caster
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21210;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21210);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21210, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36384, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invis Deathforge Caster - On Reset - Cast \'Skartax Purple Beam\''),
(21210, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invis Deathforge Caster - On Data Set 1 1 - Despawn Instant');
-- GUID-Specific
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+78));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+78), 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36393, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invis Deathforge Caster - On Reset - Cast \'Deathforge Summon Visual\''),
(-(@CGUID+78), 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invis Deathforge Caster - On Data Set 1 1 - Despawn Instant');

-- Delete old SAI
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-84858,-84857,-84856,-84855,-84854);

-- Formations
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@CGUID+23,@CGUID+62,@CGUID+32,@CGUID+68,@CGUID+24,@CGUID+63,@CGUID+25,@CGUID+64,@CGUID+22,@CGUID+61,@CGUID+27,@CGUID+65);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+23, @CGUID+23, 0, 0, 3),
(@CGUID+23, @CGUID+62, 3, 90, 515),
(@CGUID+32, @CGUID+32, 0, 0, 3),
(@CGUID+32, @CGUID+68, 3, 90, 515),
(@CGUID+24, @CGUID+24, 0, 0, 3),
(@CGUID+24, @CGUID+63, 3, 90, 515),
(@CGUID+25, @CGUID+25, 0, 0, 3),
(@CGUID+25, @CGUID+64, 3, 90, 515),
(@CGUID+22, @CGUID+22, 0, 0, 3),
(@CGUID+22, @CGUID+61, 3, 90, 515),
(@CGUID+27, @CGUID+27, 0, 0, 3),
(@CGUID+27, @CGUID+65, 3, 90, 515);

-- Pathing for Deathforge Summoner Entry: 20872
SET @NPC := @CGUID+23;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3249.289,`position_y`=1934.058,`position_z`=106.556366 WHERE `guid`=@CGUID+23;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3249.289,`position_y`=1934.058,`position_z`=106.556366 WHERE `guid`=@CGUID+62;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3249.289,1934.058,106.556366,NULL,0,0,0,100,0),
(@PATH,2,-3240.7952,1940.6029,109.822235,NULL,0,0,0,100,0),
(@PATH,3,-3227.3296,1952.6995,110.57814,NULL,0,0,0,100,0),
(@PATH,4,-3217.4802,1975.721,107.65374,NULL,0,0,0,100,0),
(@PATH,5,-3212.6528,1977.6903,107.03326,NULL,0,0,0,100,0),
(@PATH,6,-3208.2712,1984.3756,106.52736,NULL,0,0,0,100,0),
(@PATH,7,-3199.6099,2005.0332,100.65568,NULL,0,0,0,100,0),
(@PATH,8,-3193.023,2012.7993,97.4439,NULL,0,0,0,100,0),
(@PATH,9,-3181.3623,2027.7971,93.296684,NULL,0,0,0,100,0),
(@PATH,10,-3193.023,2012.7993,97.4439,NULL,0,0,0,100,0),
(@PATH,11,-3199.6099,2005.0332,100.65568,NULL,0,0,0,100,0),
(@PATH,12,-3208.2712,1984.3756,106.52736,NULL,0,0,0,100,0),
(@PATH,13,-3212.646,1977.6931,107.030266,NULL,0,0,0,100,0),
(@PATH,14,-3217.4802,1975.721,107.65374,NULL,0,0,0,100,0),
(@PATH,15,-3227.3296,1952.6995,110.57814,NULL,0,0,0,100,0),
(@PATH,16,-3240.7952,1940.6029,109.822235,NULL,0,0,0,100,0);
-- 0x2030FC424014620000392800006AA0E7 .go xyz -3249.289 1934.058 106.556366

-- Pathing for Deathforge Summoner Entry: 20872
SET @NPC := @CGUID+32;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3441.2708,`position_y`=2136.4683,`position_z`=32.785088 WHERE `guid`=@CGUID+32;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3441.2708,`position_y`=2136.4683,`position_z`=32.785088 WHERE `guid`=@CGUID+68;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3441.2708,2136.4683,32.785088,NULL,0,0,0,100,0),
(@PATH,2,-3427.0508,2115.3972,34.58012,NULL,0,0,0,100,0),
(@PATH,3,-3421.247,2109.216,34.44698,NULL,0,0,0,100,0),
(@PATH,4,-3414.311,2109.6887,34.29539,NULL,0,0,0,100,0),
(@PATH,5,-3401.043,2112.6348,34.10258,NULL,0,0,0,100,0),
(@PATH,6,-3393.63,2105.9465,34.051487,NULL,0,0,0,100,0),
(@PATH,7,-3392.7725,2086.0906,34.250164,NULL,0,0,0,100,0),
(@PATH,8,-3382.6184,2065.6775,34.391132,NULL,0,0,0,100,0),
(@PATH,9,-3392.7725,2086.0906,34.250164,NULL,0,0,0,100,0),
(@PATH,10,-3393.63,2105.9465,34.051487,NULL,0,0,0,100,0),
(@PATH,11,-3401.043,2112.6348,34.10258,NULL,0,0,0,100,0),
(@PATH,12,-3414.311,2109.6887,34.29539,NULL,0,0,0,100,0),
(@PATH,13,-3421.247,2109.216,34.44698,NULL,0,0,0,100,0),
(@PATH,14,-3427.0508,2115.3972,34.58012,NULL,0,0,0,100,0);
-- 0x2030FC42401462000039280003EAA0E7 .go xyz -3441.2708 2136.4683 32.785088

-- Pathing for Deathforge Summoner Entry: 20872
SET @NPC := @CGUID+24;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3291.386,`position_y`=1982.4796,`position_z`=52.09859 WHERE `guid`=@CGUID+24;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3291.386,`position_y`=1982.4796,`position_z`=52.09859 WHERE `guid`=@CGUID+63;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3291.386,1982.4796,52.09859,NULL,0,0,0,100,0),
(@PATH,2,-3295.9385,1982.7728,51.78304,NULL,0,0,0,100,0),
(@PATH,3,-3299.0688,1990.464,49.55733,NULL,0,0,0,100,0),
(@PATH,4,-3306.1125,2009.0087,43.273743,NULL,0,0,0,100,0),
(@PATH,5,-3312.6907,2016.1764,40.107483,NULL,0,0,0,100,0),
(@PATH,6,-3341.4004,2012.4338,32.729168,NULL,0,0,0,100,0),
(@PATH,7,-3353.0286,1992.3295,29.830502,NULL,0,0,0,100,0),
(@PATH,8,-3361.1333,1987.2513,28.030022,NULL,0,0,0,100,0),
(@PATH,9,-3374.1396,1986.1565,24.836876,NULL,0,0,0,100,0),
(@PATH,10,-3394.2058,1991.6322,25.825983,NULL,0,0,0,100,0),
(@PATH,11,-3374.1396,1986.1565,24.836876,NULL,0,0,0,100,0),
(@PATH,12,-3361.1333,1987.2513,28.030022,NULL,0,0,0,100,0),
(@PATH,13,-3353.0286,1992.3295,29.830502,NULL,0,0,0,100,0),
(@PATH,14,-3341.4004,2012.4338,32.729168,NULL,0,0,0,100,0),
(@PATH,15,-3312.6907,2016.1764,40.107483,NULL,0,0,0,100,0),
(@PATH,16,-3306.1125,2009.0087,43.273743,NULL,0,0,0,100,0),
(@PATH,17,-3299.0688,1990.464,49.55733,NULL,0,0,0,100,0),
(@PATH,18,-3295.9385,1982.7728,51.78304,NULL,0,0,0,100,0);
-- 0x2030FC424014620000392800046AA0E7 .go xyz -3291.386 1982.4796 52.09859

-- Pathing for Deathforge Summoner Entry: 20872
SET @NPC := @CGUID+22;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3287.8828,`position_y`=1913.6244,`position_z`=142.81648 WHERE `guid`=@CGUID+22;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3287.8828,`position_y`=1913.6244,`position_z`=142.81648 WHERE `guid`=@CGUID+61;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3287.8828,1913.6244,142.81648,NULL,0,0,0,100,0),
(@PATH,2,-3293.4028,1928.4772,143.56796,NULL,0,0,0,100,0),
(@PATH,3,-3281.6875,1933.6029,144.61272,NULL,0,0,0,100,0),
(@PATH,4,-3270.929,1937.6763,144.4299,NULL,0,0,0,100,0),
(@PATH,5,-3257.2383,1944.8262,143.263,NULL,0,0,0,100,0),
(@PATH,6,-3244.7031,1948.7324,143.88599,NULL,0,0,0,100,0),
(@PATH,7,-3232.3496,1955.7667,145.72418,NULL,0,0,0,100,0),
(@PATH,8,-3219.4329,1965.9182,144.45306,NULL,0,0,0,100,0),
(@PATH,9,-3211.733,1981.3756,141.17262,NULL,0,0,0,100,0),
(@PATH,10,-3219.4329,1965.9182,144.45306,NULL,0,0,0,100,0),
(@PATH,11,-3232.3496,1955.7667,145.72418,NULL,0,0,0,100,0),
(@PATH,12,-3244.7031,1948.7324,143.88599,NULL,0,0,0,100,0),
(@PATH,13,-3257.2383,1944.8262,143.263,NULL,0,0,0,100,0),
(@PATH,14,-3270.929,1937.6763,144.4299,NULL,0,0,0,100,0),
(@PATH,15,-3281.6875,1933.6029,144.61272,NULL,0,0,0,100,0),
(@PATH,16,-3293.4028,1928.4772,143.56796,NULL,0,0,0,100,0);
-- 0x2030FC42401462000039280005EAA0E7 .go xyz -3287.8828 1913.6244 142.81648

-- Pathing for Deathforge Summoner Entry: 20872
SET @NPC := @CGUID+27;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3350.4548,`position_y`=2102.0413,`position_z`=6.35183 WHERE `guid`=@CGUID+27;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3350.4548,`position_y`=2102.0413,`position_z`=6.35183 WHERE `guid`=@CGUID+65;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3350.4548,2102.0413,6.35183,NULL,0,0,0,100,0),
(@PATH,2,-3371.799,2078.6301,6.4980073,NULL,0,0,0,100,0),
(@PATH,3,-3393.8728,2072.1277,10.005706,NULL,0,0,0,100,0),
(@PATH,4,-3404.8042,2054.7522,15.128708,NULL,0,0,0,100,0),
(@PATH,5,-3447.9324,2059.6836,15.746407,NULL,0,0,0,100,0),
(@PATH,6,-3406.7312,2053.7075,15.271384,NULL,0,0,0,100,0),
(@PATH,7,-3404.0933,2055.8787,15.2170315,NULL,0,0,0,100,0),
(@PATH,8,-3393.372,2075.341,9.194681,NULL,0,0,0,100,0),
(@PATH,9,-3369.0967,2079.7554,5.8863196,NULL,0,0,0,100,0),
(@PATH,10,-3348.3694,2101.9636,6.004652,NULL,0,0,0,100,0),
(@PATH,11,-3311.7373,2124.7922,8.987838,NULL,0,0,0,100,0),
(@PATH,12,-3350.4548,2102.0413,6.35183,NULL,0,0,0,100,0),
(@PATH,13,-3371.799,2078.6301,6.4980073,NULL,0,0,0,100,0),
(@PATH,14,-3393.8728,2072.1277,10.005706,NULL,0,0,0,100,0),
(@PATH,15,-3404.8042,2054.7522,15.128708,NULL,0,0,0,100,0),
(@PATH,16,-3447.9324,2059.6836,15.746407,NULL,0,0,0,100,0),
(@PATH,17,-3406.7312,2053.7075,15.271384,NULL,0,0,0,100,0),
(@PATH,18,-3395.842,2011.2098,23.021214,NULL,0,0,0,100,0),
(@PATH,19,-3404.0933,2055.8787,15.2170315,NULL,0,0,0,100,0),
(@PATH,20,-3393.372,2075.341,9.194681,NULL,0,0,0,100,0),
(@PATH,21,-3369.0967,2079.7554,5.8863196,NULL,0,0,0,100,0),
(@PATH,22,-3348.3694,2101.9636,6.004652,NULL,0,0,0,100,0),
(@PATH,23,-3311.7373,2124.7922,8.987838,NULL,0,0,0,100,0);
-- 0x2030FC424014620000392800066AA0E7 .go xyz -3350.4548 2102.0413 6.35183

-- Pathing for Deathforge Summoner Entry: 20872
SET @NPC := @CGUID+25;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3276.3625,`position_y`=2037.8624,`position_z`=66.73646 WHERE `guid`=@CGUID+25;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3276.3625,`position_y`=2037.8624,`position_z`=66.73646 WHERE `guid`=@CGUID+64;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,-3275.4268,2016.694,61.82193,NULL,0,0,0,100,0),
(@PATH,2 ,-3276.3625,2037.8624,66.73646,NULL,0,0,0,100,0),
(@PATH,3 ,-3277.2617,2044.0239,68.41358,NULL,0,0,0,100,0),
(@PATH,4 ,-3274.2263,2055.0208,71.28834,NULL,0,0,0,100,0),
(@PATH,5 ,-3260.7517,2071.1848,74.81242,NULL,0,0,0,100,0),
(@PATH,6 ,-3241.4465,2084.1897,77.30461,NULL,0,0,0,100,0),
(@PATH,7 ,-3221.2805,2093.9385,76.65476,NULL,0,0,0,100,0),
(@PATH,8 ,-3210.8396,2101.748,75.629654,NULL,0,0,0,100,0),
(@PATH,9 ,-3221.25,2093.9658,76.65476,NULL,0,0,0,100,0),
(@PATH,10,-3241.4465,2084.1897,77.30461,NULL,0,0,0,100,0),
(@PATH,11,-3260.7517,2071.1848,74.81242,NULL,0,0,0,100,0),
(@PATH,12,-3274.205,2055.045,71.29359,NULL,0,0,0,100,0),
(@PATH,13,-3277.2617,2044.0239,68.41358,NULL,0,0,0,100,0),
(@PATH,14,-3276.3625,2037.8624,66.73646,NULL,0,0,0,100,0);
-- 0x2030FC42401462000039280004EAA0E7 .go xyz -3276.3625 2037.8624 66.73646

-- Pathing for Deathforge Tinkerer Entry: 19754
SET @NPC := @CGUID+1;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3420.1304,`position_y`=2282.9092,`position_z`=33.51472 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3420.1304,2282.9092,33.51472,NULL,0,1,0,100,0),
(@PATH,2,-3417.118,2263.4177,33.64922,NULL,0,1,0,100,0),
(@PATH,3,-3416.865,2254.3262,33.69727,NULL,0,1,0,100,0),
(@PATH,4,-3428.3596,2249.196,33.632732,NULL,0,1,0,100,0),
(@PATH,5,-3435.316,2242.5996,33.767357,NULL,0,1,0,100,0),
(@PATH,6,-3439.7942,2238.186,33.723534,NULL,0,1,0,100,0),
(@PATH,7,-3446.786,2237.977,33.72885,NULL,0,1,0,100,0),
(@PATH,8,-3462.82,2227.9,33.444492,NULL,0,1,0,100,0),
(@PATH,9,-3472.9297,2229.5059,33.525303,NULL,0,1,0,100,0),
(@PATH,10,-3477.2114,2231.8064,33.52516,NULL,0,1,0,100,0),
(@PATH,11,-3462.82,2227.9,33.444492,NULL,0,1,0,100,0),
(@PATH,12,-3452.246,2235.5383,33.707893,NULL,0,1,0,100,0),
(@PATH,13,-3446.786,2237.977,33.72885,NULL,0,1,0,100,0),
(@PATH,14,-3439.7942,2238.186,33.723534,NULL,0,1,0,100,0),
(@PATH,15,-3428.3596,2249.196,33.632732,NULL,0,1,0,100,0),
(@PATH,16,-3416.865,2254.3262,33.69727,NULL,0,1,0,100,0),
(@PATH,17,-3416.4163,2272.8167,33.712013,NULL,0,1,0,100,0);
-- 0x2030FC4240134A8000392800016AA0E7 .go xyz -3420.1304 2282.9092 33.51472

-- Pathing for Deathforge Tinkerer Entry: 19754
-- 0x2030FC4240134A8000392800006AA0E7 .go xyz -3412.3855 2280.988 33.848083
SET @NPC := @CGUID+5;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3412.3855,`position_y`=2280.988,`position_z`=33.848083 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3412.3855,2280.988,33.848083,NULL,0,1,0,100,0),
(@PATH,2,-3419.7566,2260.3987,33.625275,NULL,0,1,0,100,0),
(@PATH,3,-3432.1763,2248.1692,33.655376,NULL,0,1,0,100,0),
(@PATH,4,-3439.0522,2235.8691,33.697147,NULL,0,1,0,100,0),
(@PATH,5,-3445.5662,2231.0151,33.650684,NULL,0,1,0,100,0),
(@PATH,6,-3452.4036,2231.0183,33.658176,NULL,0,1,0,100,0),
(@PATH,7,-3468.3413,2225.2063,33.525757,NULL,0,1,0,100,0),
(@PATH,8,-3475.888,2220.3936,33.526955,NULL,0,1,0,100,0),
(@PATH,9,-3480.2568,2225.0461,33.526432,NULL,0,1,0,100,0),
(@PATH,10,-3468.3413,2225.2063,33.525757,NULL,0,1,0,100,0),
(@PATH,11,-3457.4155,2230.646,33.613297,NULL,0,1,0,100,0),
(@PATH,12,-3450.227,2229.2805,33.63662,NULL,0,1,0,100,0),
(@PATH,13,-3439.0522,2235.8691,33.697147,NULL,0,1,0,100,0),
(@PATH,14,-3432.1763,2248.1692,33.655376,NULL,0,1,0,100,0),
(@PATH,15,-3426.0977,2255.3433,33.588165,NULL,0,1,0,100,0),
(@PATH,16,-3419.7566,2260.3987,33.625275,NULL,0,1,0,100,0),
(@PATH,17,-3414.0315,2270.5618,33.757763,NULL,0,1,0,100,0);
