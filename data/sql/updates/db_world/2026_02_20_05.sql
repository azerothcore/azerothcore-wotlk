-- DB update 2026_02_20_04 -> 2026_02_20_05
--
DELETE FROM `waypoint_data` WHERE `id` IN (244401, 244402, 244403, 244404, 244411, 244412, 244413, 244414, 244415, 244416, 244417, 244418);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- Spawn Paths
(244401, 1, 2166.0625, -3243.5933, 180.9555, NULL, 1), -- PathType: ExactPathFlying
(244401, 2, 2159.8196, -3250.0044, 180.95552, NULL, 1),
(244401, 3, 2139.9976, -3230.1494, 180.95552, NULL, 1),
(244401, 4, 2119.4285, -3219.818, 180.95552, NULL, 1),
(244401, 5, 2082.4119, -3218.6365, 180.95552, NULL, 1),
(244401, 6, 2057.2395, -3231.4038, 180.95552, NULL, 1),

(244402, 1, 2181.5571, -3264.775, 181.99797, NULL, 1), -- PathType: ExactPathFlying
(244402, 2, 2137.1206, -3261.2974, 181.99797, NULL, 1),
(244402, 3, 2090.4736, -3263.3528, 181.99797, NULL, 1),

(244403, 1, 2158.682, -3318.3374, 183.71745, NULL, 1), -- PathType: ExactPathFlying
(244403, 2, 2130.7395, -3310.8962, 183.71745, NULL, 1),
(244403, 3, 2096.0337, -3300.9407, 183.71745, NULL, 1),
(244403, 4, 2076.361, -3320.212, 177.49522, NULL, 1),
(244403, 5, 2044.6697, -3331.9944, 177.49522, NULL, 1),
(244403, 6, 1997.7017, -3316.084, 172.1619, NULL, 1),

(244404, 1, 2190.6858, -3291.0073, 174.83574, NULL, 1), -- PathType: ExactPathFlying
(244404, 2, 2177.2344, -3270.6223, 174.83574, NULL, 1),
(244404, 3, 2154.7668, -3260.519, 174.83574, NULL, 1),
(244404, 4, 2126.8496, -3260.701, 174.83574, NULL, 1),
(244404, 5, 2093.8542, -3282.568, 174.83574, NULL, 1),
(244404, 6, 2065.487, -3277.9292, 174.83574, NULL, 1),
-- Patrol Paths
-- At any point they may start another
(244411, 1, 2061.6252, -3225.8066, 110.46983, NULL, 1),
(244411, 2, 2068.5293, -3225.4172, 110.46983, NULL, 1),
(244411, 3, 2062.1475, -3222.5796, 110.46983, NULL, 1),
(244411, 4, 2050.0513, -3227.5261, 110.46983, NULL, 1),
(244411, 5, 2063.677, -3224.6401, 110.46983, NULL, 1),
(244411, 6, 2060.198, -3221.9307, 110.46983, NULL, 1),
(244411, 7, 2067.0117, -3220.79, 110.46983, NULL, 1),
(244411, 8, 2059.4438, -3225.3433, 110.46983, NULL, 1),

(244412, 1, 2046.75, -3261.8188, 113.66396, NULL, 1),
(244412, 2, 2054.3982, -3275.4526, 113.66396, NULL, 1),
(244412, 3, 2042.5363, -3264.9768, 113.66396, NULL, 1),
(244412, 4, 2037.8262, -3249.983, 113.66396, NULL, 1),
(244412, 5, 2048.1287, -3254.4248, 113.66396, NULL, 1),
(244412, 6, 2039.2755, -3256.5334, 113.66396, NULL, 1),
(244412, 7, 2042.3751, -3256.4075, 113.66396, NULL, 1),
(244412, 8, 2041.2069, -3256.7092, 113.66396, NULL, 1),

(244413, 1 , 2053.6716, -3328.2083, 128.81787, NULL, 1),
(244413, 2 , 2068.5825, -3294.51, 128.81787, NULL, 1),
(244413, 3 , 2067.4263, -3266.633, 128.81787, NULL, 1),
(244413, 4 , 2048.2356, -3230.1907, 128.81787, NULL, 1),
(244413, 5 , 2014.4576, -3245.0356, 128.81787, NULL, 1),
(244413, 6 , 2007.6554, -3291.14, 128.81787, NULL, 1),
(244413, 7 , 2010.0525, -3326.0042, 128.81787, NULL, 1),
(244413, 8 , 2040.7793, -3351.0933, 128.81787, NULL, 1),
(244413, 9 , 2063.7512, -3326.8794, 128.81787, NULL, 1),
(244413, 10, 2064.902, -3291.096, 128.81787, NULL, 1),
(244413, 11, 2025.8376, -3286.761, 128.81787, NULL, 1),

(244414, 1, 2014.2073, -3245.6626, 130.87953, NULL, 1),
(244414, 2, 2015.9786, -3242.778, 130.87953, NULL, 1),
(244414, 3, 2011.9103, -3246.2632, 130.87953, NULL, 1),
(244414, 4, 2019.221, -3242.3965, 130.87953, NULL, 1),
(244414, 5, 2017.1042, -3237.1711, 130.87953, NULL, 1),
(244414, 6, 2018.7694, -3241.8735, 130.87953, NULL, 1),
(244414, 7, 2014.6066, -3251.7986, 130.87953, NULL, 1),
(244414, 8, 2019.221, -3242.3965, 130.87953, NULL, 1),

(244415, 1 , 1996.0485, -3290.9797, 131.02751, NULL, 1),
(244415, 2 , 1997.7188, -3289.8953, 131.02751, NULL, 1),
(244415, 3 , 1995.3326, -3291.1948, 131.02751, NULL, 1),
(244415, 4 , 1993.0052, -3293.4604, 131.02751, NULL, 1),
(244415, 5 , 1987.5831, -3280.076, 131.02751, NULL, 1),
(244415, 6 , 1978.2656, -3287.1914, 131.02751, NULL, 1),
(244415, 7 , 1996.1595, -3291.0747, 131.02751, NULL, 1),
(244415, 8 , 1993.7706, -3295.9563, 131.02751, NULL, 1),
(244415, 9 , 1994.4401, -3292.1433, 131.02751, NULL, 1),
(244415, 10, 2012.1808, -3283.8916, 131.02751, NULL, 1),
(244415, 11, 1996.1595, -3291.0747, 131.02751, NULL, 1),
(244415, 12, 2050.22, -3212.1023, 131.7216, NULL, 1),

(244416, 1 , 1993.8201, -3300.897, 137.54697, NULL, 1),
(244416, 2 , 2028.6237, -3306.248, 137.54697, NULL, 1),
(244416, 3 , 2064.139, -3273.6064, 137.54697, NULL, 1),
(244416, 4 , 2066.9956, -3260.3035, 137.54697, NULL, 1),
(244416, 5 , 2053.7297, -3240.1597, 137.54697, NULL, 1),
(244416, 6 , 2019.7631, -3242.2454, 137.54697, NULL, 1),
(244416, 7 , 2010.2274, -3262.113, 137.54697, NULL, 1),
(244416, 8 , 2027.4445, -3284.7336, 137.54697, NULL, 1),
(244416, 9 , 2047.6554, -3329.7773, 137.54697, NULL, 1),
(244416, 10, 2060.7527, -3327.7354, 137.54697, NULL, 1),
(244416, 11, 2042.2126, -3308.3665, 137.54697, NULL, 1),
(244416, 12, 2029.2096, -3294.3716, 137.54697, NULL, 1),

(244417, 1 , 2080.1594, -3234.2708, 139.72156, NULL, 1),
(244417, 2 , 2093.6687, -3264.2322, 139.72156, NULL, 1),
(244417, 3 , 2092.5127, -3306.2922, 139.72156, NULL, 1),
(244417, 4 , 2090.3342, -3321.6672, 139.72156, NULL, 1),
(244417, 5 , 2063.0059, -3323.8943, 139.72156, NULL, 1),
(244417, 6 , 2017.7001, -3321.9739, 139.72156, NULL, 1),
(244417, 7 , 2018.8739, -3287.563, 139.72156, NULL, 1),
(244417, 8 , 2025.3499, -3263.1636, 139.72156, NULL, 1),
(244417, 9 , 2040.0791, -3338.9258, 139.72156, NULL, 1),
(244417, 10, 2049.0332, -3324.6628, 139.72156, NULL, 1),

(244418, 1 , 1990.0845, -3315.2732, 148.92896, NULL, 1),
(244418, 2 , 1970.158, -3320.0554, 170.51852, NULL, 1),
(244418, 3 , 1959.2545, -3302.718, 180.7407, NULL, 1),
(244418, 4 , 1956.6018, -3276.815, 185.21294, NULL, 1),
(244418, 5 , 1926.0784, -3243.9893, 185.21294, NULL, 1),
(244418, 6 , 1922.6814, -3216.9436, 185.21294, NULL, 1),
(244418, 7 , 1960.441, -3208.2822, 185.21294, NULL, 1),
(244418, 8 , 1997.6995, -3188.8447, 185.21294, NULL, 1),
(244418, 9 , 2041.0187, -3193.5137, 185.21294, NULL, 1),
(244418, 10, 2042.536, -3224.5352, 185.21294, NULL, 1),
(244418, 11, 2037.7513, -3262.2507, 185.21294, NULL, 1),
(244418, 12, 2009.8748, -3299.9492, 185.21294, NULL, 1),
(244418, 13, 2005.569, -3320.2559, 185.21294, NULL, 1);

SET @GUID := 52854;

DELETE FROM `creature` WHERE `id1` = 24440 AND `guid` IN (107082,107083,107084,107085,107086,107087,107088,107089,107090,107092,107093,107094,107095,107096,107097,107098,107099,107100,107101,107102,107111);
DELETE FROM `creature` WHERE `id1` = 24440 AND `guid` BETWEEN @GUID+0 AND @GUID+19;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID+0 , 24440, 571, 495, 3999, 2159.51, -3194.06, 143.911, 0.645772, 30, 65512, 1, NULL),
(@GUID+1 , 24440, 571, 495, 3999, 2165.4, -3172.17, 192.231, 0.767945, 30, 65512, 1, NULL),
(@GUID+2 , 24440, 571, 495, 3999, 2173.41, -3246.4, 179.519, 1.81514, 30, 65512, 1, NULL),
(@GUID+3 , 24440, 571, 495, 3999, 2227.24, -3340.07, 179.863, 2.21385, 30, 65512, 1, NULL),
(@GUID+4 , 24440, 571, 495, 3999, 2187.9, -3230.13, 197.935, 2.46091, 30, 65512, 1, NULL),
(@GUID+5 , 24440, 571, 495, 3999, 2236.79, -3287.49, 181.61, 2.57286, 30, 65512, 1, NULL),
(@GUID+6 , 24440, 571, 495, 3999, 2181.64, -3305.67, 179.903, 2.58309, 30, 65512, 1, NULL),
(@GUID+7 , 24440, 571, 495, 3999, 2228.49, -3350.64, 181.78, 2.70236, 30, 65512, 1, NULL),
(@GUID+8 , 24440, 571, 495, 3999, 2241.28, -3261.74, 194.289, 2.89489, 30, 65512, 1, NULL),
(@GUID+9 , 24440, 571, 495, 3999, 2233.01, -3313.31, 182.573, 3.22579, 30, 65512, 1, NULL),
(@GUID+10, 24440, 571, 495, 3999, 2233.08, -3313.3, 182.572, 3.22579, 30, 65512, 1, NULL),
(@GUID+11, 24440, 571, 495, 3999, 2246.25, -3261.23, 182.262, 3.36849, 30, 65512, 1, NULL),
(@GUID+12, 24440, 571, 495, 3999, 2272.47, -3310.13, 181.942, 3.45575, 30, 65512, 1, NULL),
(@GUID+13, 24440, 571, 495, 3999, 2242.6, -3271.31, 192.245, 3.55272, 30, 65512, 1, NULL),
(@GUID+14, 24440, 571, 495, 3999, 2239.75, -3238.94, 194.69, 3.99352, 30, 65512, 1, NULL),
(@GUID+15, 24440, 571, 495, 3999, 2234.81, -3215.15, 195.862, 4.09856, 30, 65512, 1, NULL),
(@GUID+16, 24440, 571, 495, 3999, 2234.78, -3215.19, 195.857, 4.09858, 30, 65512, 1, NULL),
(@GUID+17, 24440, 571, 495, 3999, 2223.47, -3241.02, 192.57, 4.90438, 30, 65512, 1, NULL),
(@GUID+18, 24440, 571, 495, 3999, 2198.84, -3173.41, 192.855, 5.09636, 30, 65512, 1, NULL),
(@GUID+19, 24440, 571, 495, 3999, 2206.77, -3329.28, 196.61, 5.63741, 30, 65512, 1, NULL);

DELETE FROM `game_event` WHERE `eventEntry` = 98;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(98, NULL, NULL, 5184000, 15, 0, 0, 'Steel Gate Gargoyle Attack', 0, 2);

DELETE FROM `game_event_creature` WHERE `eventEntry` = 98 AND `guid` BETWEEN @GUID AND @GUID+19;
INSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES
(@GUID+0 , 98),
(@GUID+1 , 98),
(@GUID+2 , 98),
(@GUID+3 , 98),
(@GUID+4 , 98),
(@GUID+5 , 98),
(@GUID+6 , 98),
(@GUID+7 , 98),
(@GUID+8 , 98),
(@GUID+9 , 98),
(@GUID+10, 98),
(@GUID+11, 98),
(@GUID+12, 98),
(@GUID+13, 98),
(@GUID+14, 98),
(@GUID+15, 98),
(@GUID+16, 98),
(@GUID+17, 98),
(@GUID+18, 98),
(@GUID+19, 98);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24440;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24440);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24440, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3000, 0, 0, 11, 43803, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gjalerbron Gargoyle - In Combat - Cast \'Gargoyle Strike\''),
(24440, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 244401, 244404, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gjalerbron Gargoyle - On Respawn - Start Random Path 244401-244404'),
(24440, 0, 3, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2444000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gjalerbron Gargoyle - On Path Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2444000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2444000, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 233, 244411, 244418, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gjalerbron Gargoyle - Actionlist - Start Random Path 244411-244418');

DELETE FROM `creature_text` WHERE (`CreatureID` = 24473);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24473, 0, 0, 'Gargoyle attack! Grab yer rifles, men!', 14, 7, 100, 0, 0, 0, 23410, 0, 'Lead Archaeologist Malzie - On Quest \'Steel Gate Patrol\' Accepted');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24473;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24473);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24473, 0, 0, 0, 68, 0, 100, 0, 98, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lead Archaeologist Malzie - On Game Event 98 Started - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24399) AND (`source_type` = 0) AND (`id` IN (6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24399, 0, 6, 0, 19, 0, 100, 0, 11391, 0, 0, 0, 0, 0, 112, 98, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steel Gate Chief Archaeologist - On Quest \'Steel Gate Patrol\' Taken - Start \'Steel Gate Gargoyle Attack\' Event');
