-- DB update 2025_12_05_00 -> 2025_12_05_01

-- Add sniffed Waypoints
DELETE FROM `waypoint_data` WHERE (`id` IN (12641600, 12641900, 12642000, 12640000, 12639700));
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12641600, 1, 3122.1736, 532.6602, 88.01989, NULL, 0, 0, 0, 100, 0),
(12641600, 2, 3125.966, 508.25412, 88.542816, NULL, 0, 0, 0, 100, 0),
(12641600, 3, 3146.3586, 476.755, 78.63365, NULL, 0, 0, 0, 100, 0),
(12641600, 4, 3176.8057, 466.12268, 63.954556, NULL, 0, 0, 0, 100, 0),
(12641600, 5, 3186.5317, 454.58585, 62.529587, NULL, 0, 0, 0, 100, 0),
(12641600, 6, 3203.792, 452.24567, 60.55202, NULL, 2000, 0, 0, 100, 0),
(12641600, 7, 3186.5317, 454.58585, 62.529587, NULL, 0, 0, 0, 100, 0),
(12641600, 8, 3176.8057, 466.12268, 63.954556, NULL, 0, 0, 0, 100, 0),
(12641600, 9, 3146.3586, 476.755, 78.63365, NULL, 0, 0, 0, 100, 0),
(12641600, 10, 3125.966, 508.25412, 88.542816, NULL, 0, 0, 0, 100, 0),
(12641600, 11, 3127.8643, 505.31055, 87.93867, NULL, 0, 0, 0, 100, 0),
(12641600, 12, 3121.3276, 554.1918, 89.05305, NULL, 0, 0, 0, 100, 0),
(12641600, 13, 3122.1736, 532.6602, 88.01989, NULL, 0, 0, 0, 100, 0),
(12641600, 14, 3121.3276, 554.1918, 89.05305, NULL, 0, 0, 0, 100, 0),
(12641900, 1, 3169.1216, 650.4629, 73.140945, NULL, 0, 0, 0, 100, 0),
(12641900, 2, 3174.4927, 671.8068, 80.675766, NULL, 0, 0, 0, 100, 0),
(12641900, 3, 3192.1406, 689.416, 89.47004, NULL, 0, 0, 0, 100, 0),
(12641900, 4, 3217.8877, 703.09235, 93.65135, NULL, 0, 0, 0, 100, 0),
(12641900, 5, 3264.109, 700.6325, 92.4675, NULL, 0, 0, 0, 100, 0),
(12641900, 6, 3288.6113, 691.9492, 90.03599, NULL, 0, 0, 0, 100, 0),
(12641900, 7, 3296.816, 667.01575, 83.845055, NULL, 0, 0, 0, 100, 0),
(12641900, 8, 3294.3733, 646.39856, 78.13237, NULL, 0, 0, 0, 100, 0),
(12641900, 9, 3299.9355, 631.39844, 74.52907, NULL, 0, 0, 0, 100, 0),
(12641900, 10, 3292.5527, 608.5703, 64.710144, NULL, 2000, 0, 0, 100, 0),
(12641900, 11, 3299.9355, 631.39844, 74.52907, NULL, 0, 0, 0, 100, 0),
(12641900, 12, 3294.3733, 646.39856, 78.13237, NULL, 0, 0, 0, 100, 0),
(12641900, 13, 3296.816, 667.01575, 83.845055, NULL, 0, 0, 0, 100, 0),
(12641900, 14, 3288.6113, 691.9492, 90.03599, NULL, 0, 0, 0, 100, 0),
(12641900, 15, 3264.109, 700.6325, 92.4675, NULL, 0, 0, 0, 100, 0),
(12641900, 16, 3217.8877, 703.09235, 93.65135, NULL, 0, 0, 0, 100, 0),
(12641900, 17, 3192.1406, 689.416, 89.47004, NULL, 0, 0, 0, 100, 0),
(12641900, 18, 3174.4927, 671.8068, 80.675766, NULL, 0, 0, 0, 100, 0),
(12641900, 19, 3169.1216, 650.4629, 73.140945, NULL, 0, 0, 0, 100, 0),
(12641900, 20, 3166.53, 627.90375, 68.15999, NULL, 0, 0, 0, 100, 0),
(12641900, 21, 3176.731, 609.7736, 62.805485, NULL, 0, 0, 0, 100, 0),
(12641900, 22, 3166.53, 627.90375, 68.15999, NULL, 0, 0, 0, 100, 0),
(12642000, 1, 3386.952, 502.5323, 95.89945, NULL, 0, 0, 0, 100, 0),
(12642000, 2, 3375.5227, 476.80362, 91.18758, NULL, 0, 0, 0, 100, 0),
(12642000, 3, 3358.9795, 465.80887, 87.52131, NULL, 0, 0, 0, 100, 0),
(12642000, 4, 3339.3208, 447.99405, 84.71066, NULL, 0, 0, 0, 100, 0),
(12642000, 5, 3328.7197, 425.91498, 76.79626, NULL, 0, 0, 0, 100, 0),
(12642000, 6, 3318.7969, 413.56195, 70.89054, NULL, 0, 0, 0, 100, 0),
(12642000, 7, 3299.4473, 435.4253, 64.41885, NULL, 0, 0, 0, 100, 0),
(12642000, 8, 3289.706, 451.7539, 63.35991, NULL, 0, 0, 0, 100, 0),
(12642000, 9, 3276.5793, 458.35553, 61.149826, NULL, 0, 0, 0, 100, 0),
(12642000, 10, 3261.4954, 463.6344, 58.083496, NULL, 2000, 0, 0, 100, 0),
(12642000, 11, 3276.5793, 458.35553, 61.149826, NULL, 0, 0, 0, 100, 0),
(12642000, 12, 3289.706, 451.7539, 63.35991, NULL, 0, 0, 0, 100, 0),
(12642000, 13, 3299.4473, 435.4253, 64.41885, NULL, 0, 0, 0, 100, 0),
(12642000, 14, 3318.7969, 413.56195, 70.89054, NULL, 0, 0, 0, 100, 0),
(12642000, 15, 3328.7197, 425.91498, 76.79626, NULL, 0, 0, 0, 100, 0),
(12642000, 16, 3339.3208, 447.99405, 84.71066, NULL, 0, 0, 0, 100, 0),
(12642000, 17, 3358.9795, 465.80887, 87.52131, NULL, 0, 0, 0, 100, 0),
(12642000, 18, 3375.5227, 476.80362, 91.18758, NULL, 0, 0, 0, 100, 0),
(12642000, 19, 3386.952, 502.5323, 95.89945, NULL, 0, 0, 0, 100, 0),
(12642000, 20, 3388.6235, 530.1738, 97.31077, NULL, 0, 0, 0, 100, 0),
(12642000, 21, 3390.374, 550.4353, 95.18623, NULL, 0, 0, 0, 100, 0),
(12642000, 22, 3388.6235, 530.1738, 97.31077, NULL, 0, 0, 0, 100, 0),
(12640000, 1, 3112.822, 652.9017, 79.580154, NULL, 0, 0, 0, 100, 0),
(12640000, 2, 3106.8435, 626.3539, 77.43082, NULL, 0, 0, 0, 100, 0),
(12640000, 3, 3092.7388, 610.93243, 77.23309, NULL, 0, 0, 0, 100, 0),
(12640000, 4, 3100.2705, 593.8865, 78.54593, NULL, 0, 0, 0, 100, 0),
(12640000, 5, 3119.237, 590.99493, 75.144455, NULL, 0, 0, 0, 100, 0),
(12640000, 6, 3142.236, 594.5618, 69.939224, NULL, 0, 0, 0, 100, 0),
(12640000, 7, 3151.5881, 617.27466, 68.80421, NULL, 0, 0, 0, 100, 0),
(12640000, 8, 3149.7422, 647.2168, 74.23805, NULL, 0, 0, 0, 100, 0),
(12640000, 9, 3154.8203, 666.55273, 77.53181, NULL, 0, 0, 0, 100, 0),
(12640000, 10, 3143.1262, 667.666, 79.811264, NULL, 0, 0, 0, 100, 0),
(12640000, 11, 3130.7563, 662.6465, 80.169395, NULL, 0, 0, 0, 100, 0),
(12639700, 1, 3314.8162, 664.1162, 84.00654, NULL, 0, 0, 0, 100, 0),
(12639700, 2, 3308.4458, 649.0255, 81.44372, NULL, 0, 0, 0, 100, 0),
(12639700, 3, 3314.9888, 625.7648, 76.64586, NULL, 0, 0, 0, 100, 0),
(12639700, 4, 3334.93, 617.82074, 80.46573, NULL, 0, 0, 0, 100, 0),
(12639700, 5, 3355.2317, 616.2408, 84.47163, NULL, 0, 0, 0, 100, 0),
(12639700, 6, 3348.8887, 616.72656, 82.99916, NULL, 0, 0, 0, 100, 0),
(12639700, 7, 3347.2444, 636.7253, 85.3196, NULL, 0, 0, 0, 100, 0),
(12639700, 8, 3331.8745, 656.21674, 85.11536, NULL, 0, 0, 0, 100, 0);

-- Add Spell Difficulty (Devotion Aura)
DELETE FROM `spelldifficulty_dbc` WHERE (`ID` IN (57740));
INSERT INTO `spelldifficulty_dbc` (`ID`,`DifficultySpellID_1`,`DifficultySpellID_2`,`DifficultySpellID_3`,`DifficultySpellID_4`) VALUES
(57740, 57740, 58944, 0, 0);

-- Remove auras from Onyx Brood General
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` IN (30680, 30999));

-- Update SP, MT and WD (sniffed values)
UPDATE `creature` SET `position_x` = 3123.9624, `position_y` = 563.4905, `position_z` = 89.08344, `orientation` = 4.43663, `MovementType` = 2, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30453) AND `guid` = 126416;
UPDATE `creature` SET `position_x` = 3125.977, `position_y` = 574.3518, `position_z` = 86.13242, `orientation` = 5.34753, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30453) AND `guid` = 126417;
UPDATE `creature` SET `position_x` = 3181.6206, `position_y` = 604.76, `position_z` = 60.37278, `orientation` = 5.04935, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30453) AND `guid` = 126418;
UPDATE `creature` SET `position_x` = 3177.7805, `position_y` = 616.0001, `position_z` = 64.20651, `orientation` = 4.54553, `MovementType` = 2, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30453) AND `guid` = 126419;
UPDATE `creature` SET `position_x` = 3391.5247, `position_y` = 554.5057, `position_z` = 94.93257, `orientation` = 4.43663, `MovementType` = 2, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30453) AND `guid` = 126420;
UPDATE `creature` SET `position_x` = 3393.2766, `position_y` = 567.3406, `position_z` = 91.24738, `orientation` = 4.13784, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30453) AND `guid` = 126421;
UPDATE `creature` SET `position_x` = 3149.0312, `position_y` = 668.306, `position_z` = 79.01899, `orientation` = 3.24923, `MovementType` = 2, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30680) AND `guid` = 126400;
UPDATE `creature` SET `position_x` = 3351.0344, `position_y` = 636.5978, `position_z` = 85.80331, `orientation` = 3.10852, `MovementType` = 2, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30680) AND `guid` = 126397;
UPDATE `creature` SET `position_x` = 3361.3906, `position_y` = 625.84937, `position_z` = 87.20121, `orientation` = 3.07296, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30682) AND `guid` = 126407;
UPDATE `creature` SET `position_x` = 3149.0798, `position_y` = 677.131, `position_z` = 81.535164, `orientation` = 4.61926, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30682) AND `guid` = 126412;
UPDATE `creature` SET `position_x` = 3157.8823, `position_y` = 666.0498, `position_z` = 77.16373, `orientation` = 3.85403, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30682) AND `guid` = 126408;
UPDATE `creature` SET `position_x` = 3351.464, `position_y` = 627.4477, `position_z` = 85.05361, `orientation` = 2.89519, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30681) AND `guid` = 126401;
UPDATE `creature` SET `position_x` = 3160.2383, `position_y` = 676.69977, `position_z` = 80.68675, `orientation` = 4.17643, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30681) AND `guid` = 126405;
UPDATE `creature` SET `position_x` = 3361.7314, `position_y` = 635.8682, `position_z` = 87.79267, `orientation` = 3.46105, `MovementType` = 0, `wander_distance` = 0, `VerifiedBuild` = 64481 WHERE (`id1` = 30681) AND `guid` = 126406;

-- Set creature formations
DELETE FROM `creature_formations` WHERE (`leaderGUID` IN (126416, 126419, 126420, 126397, 126400));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(126416, 126416, 0, 0, 515, 0, 0),
(126416, 126417, 10, 180, 515, 0, 0),
(126420, 126420, 0, 0, 515, 0, 0),
(126420, 126421, 10, 180, 515, 0, 0),
(126419, 126419, 0, 0, 515, 0, 0),
(126419, 126418, 10, 180, 515, 0, 0),
(126397, 126397, 0, 0, 515, 0, 0),
(126397, 126406, 10, 240, 515, 0, 0),
(126397, 126401, 10, 120, 515, 0, 0),
(126397, 126407, 15, 180, 515, 0, 0),
(126400, 126400, 0, 0, 515, 0, 0),
(126400, 126412, 10, 240, 515, 0, 0),
(126400, 126408, 10, 120, 515, 0, 0),
(126400, 126405, 15, 180, 515, 0, 0);

-- Set Waypoints
DELETE FROM `creature_addon` WHERE (`guid` IN (126416, 126419, 126420, 126400, 126397));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(126416, 12641600, 0, 0, 1, 0, 0, NULL),
(126419, 12641900, 0, 0, 1, 0, 0, NULL),
(126420, 12642000, 0, 0, 1, 0, 0, NULL),
(126400, 12640000, 0, 0, 1, 0, 0, NULL),
(126397, 12639700, 0, 0, 1, 0, 0, NULL);

-- Update SmartAI (Onyx Sanctum Guardian & Onyx Brood General)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (30453, 30680));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (30453, 30680));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30453, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 17000, 18000, 0, 0, 11, 57728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - In Combat - Cast \'Shockwave\''),
(30453, 0, 1, 0, 0, 0, 100, 0, 13000, 13000, 30000, 30000, 0, 0, 11, 39647, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - In Combat - Cast \'Curse of Mending\''),
(30453, 0, 2, 0, 12, 0, 100, 0, 25, 30, 5000, 5000, 0, 0, 11, 53801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - Target Between 25-30% Health - Cast \'Frenzy\''),
(30680, 0, 0, 0, 60, 0, 100, 0, 0, 0, 600000, 600000, 0, 0, 11, 57740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - On Update - Cast \'Devotion Aura\''),
(30680, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 0, 0, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - In Combat - Cast \'Mortal Strike\''),
(30680, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 40000, 40000, 0, 0, 11, 57733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - In Combat - Cast \'Draconic Rage\''),
(30680, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57742, 2, 0, 0, 0, 0, 26, 10, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - On Just Died - Cast \'Avenging Fury\'');
