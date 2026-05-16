-- DB update 2026_05_15_00 -> 2026_05_16_00
-- Remove Trok Creature Addon & set movement type to 0
UPDATE `creature` SET `MovementType` = 0 WHERE (`id1` = 14872) AND (`guid` = 13178);
DELETE FROM `creature_addon` WHERE (`guid` IN (13178));

-- Update Trok Creature Text
DELETE FROM `creature_text` WHERE (`CreatureID` = 14872);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14872, 0, 0, 'Help! I\'m being chased by a swarm of bees!', 12, 1, 100, 0, 0, 0, 10259, 0, 'Trok'),
(14872, 1, 0, 'I\'m so tired of running, but these bees won\'t leave me alone!', 12, 1, 100, 0, 0, 0, 10260, 0, 'Trok'),
(14872, 2, 0, 'I didn\'t know bees didn\'t like fire!', 12, 1, 100, 0, 0, 0, 10261, 0, 'Trok'),
(14872, 3, 0, 'Karu will you please help get these bees off of me? They sting!', 12, 1, 100, 0, 0, 0, 10262, 0, 'Trok');

-- Remove Trok old waypoint & set a new one (sniffed)
DELETE FROM `waypoint_data` WHERE (`id` IN (1487200, 131780));
INSERT INTO `waypoint_data` (`id`,  `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1487200, 1, 189.78833, -2879.407, 92.37207, NULL, 0, 1, 0, 100, 0),
(1487200, 2, 196.40193, -2887.9465, 92.602974, NULL, 0, 1, 0, 100, 0),
(1487200, 3, 199.38814, -2897.0017, 92.52111, NULL, 0, 1, 0, 100, 0),
(1487200, 4, 190.36217, -2902.3767, 92.970795, NULL, 0, 1, 0, 100, 0),
(1487200, 5, 178.31169, -2894.8164, 92.2478, NULL, 0, 1, 0, 100, 0),
(1487200, 6, 176.065, -2881.6494, 92.193565, NULL, 0, 1, 0, 100, 0),
(1487200, 7, 184.97385, -2874.0618, 92.503174, NULL, 0, 1, 0, 100, 0),
(1487200, 8, 188.64171, -2863.1707, 92.492485, NULL, 0, 1, 0, 100, 0),
(1487200, 9, 185.13179, -2849.029, 93.031105, NULL, 0, 1, 0, 100, 0),
(1487200, 10, 168.12883, -2860.272, 94.1003, NULL, 0, 1, 0, 100, 0),
(1487200, 11, 176.99593, -2874.4072, 92.65014, NULL, 0, 1, 0, 100, 0),
(1487200, 12, 186.21628, -2881.846, 92.24808, NULL, 0, 1, 0, 100, 0),
(1487200, 13, 187.90642, -2896.509, 92.76375, NULL, 0, 1, 0, 100, 0),
(1487200, 14, 197.18289, -2898.233, 92.55867, NULL, 0, 1, 0, 100, 0),
(1487200, 15, 207.84627, -2905.636, 94.00287, NULL, 0, 1, 0, 100, 0),
(1487200, 16, 203.60707, -2922.1226, 92.3786, NULL, 0, 1, 0, 100, 0),
(1487200, 17, 193.30553, -2911.048, 93.0428, NULL, 0, 1, 0, 100, 0),
(1487200, 18, 191.15102, -2890.8577, 92.592575, NULL, 0, 1, 0, 100, 0),
(1487200, 19, 194.50716, -2876.6003, 92.41312, NULL, 0, 1, 0, 100, 0),
(1487200, 20, 194.12733, -2841.4548, 91.69264, NULL, 0, 1, 0, 100, 0),
(1487200, 21, 202.89024, -2831.5098, 91.73559, NULL, 0, 1, 0, 100, 0),
(1487200, 22, 213.87476, -2826.201, 91.92801, NULL, 0, 1, 0, 100, 0),
(1487200, 23, 216.59177, -2814.8127, 93.33152, NULL, 0, 1, 0, 100, 0),
(1487200, 24, 204.67686, -2814.8518, 94.10266, NULL, 0, 1, 0, 100, 0),
(1487200, 25, 195.65343, -2824.597, 93.45117, NULL, 0, 1, 0, 100, 0),
(1487200, 26, 186.61716, -2841.0603, 92.83624, NULL, 0, 1, 0, 100, 0),
(1487200, 27, 184.85129, -2857.1006, 93.068634, NULL, 0, 1, 0, 100, 0),
(1487200, 28, 182.88713, -2868.4695, 92.82301, NULL, 0, 1, 0, 100, 0),
(1487200, 29, 181.64453, -2880.3984, 92.19401, NULL, 0, 1, 0, 100, 0),
(1487200, 30, 181.71254, -2891.7336, 92.16029, NULL, 0, 1, 0, 100, 0),
(1487200, 31, 189.57338, -2906.6575, 93.126816, NULL, 0, 1, 0, 100, 0),
(1487200, 32, 197.61906, -2899.2085, 92.558975, NULL, 0, 1, 0, 100, 0),
(1487200, 33, 191.73611, -2888.19, 92.52359, NULL, 0, 1, 0, 100, 0),
(1487200, 34, 181.22736, -2883.558, 92.098076, NULL, 0, 1, 0, 100, 0),
(1487200, 35, 175.08127, -2877.4844, 92.491455, NULL, 0, 1, 0, 100, 0),
(1487200, 36, 175.89215, -2853.4841, 94.02501, NULL, 0, 1, 0, 100, 0),
(1487200, 37, 185.5698, -2853.3835, 92.97653, NULL, 0, 1, 0, 100, 0),
(1487200, 38, 194.3255, -2843.596, 91.66923, NULL, 0, 1, 0, 100, 0),
(1487200, 39, 196.79987, -2833.0298, 91.9368, NULL, 0, 1, 0, 100, 0),
(1487200, 40, 208.51218, -2826.5408, 92.3302, NULL, 0, 1, 0, 100, 0),
(1487200, 41, 193.60387, -2826.3994, 93.32707, NULL, 0, 1, 0, 100, 0),
(1487200, 42, 186.73663, -2838.3733, 92.952095, NULL, 0, 1, 0, 100, 0),
(1487200, 43, 182.54248, -2851.9463, 93.49391, NULL, 0, 1, 0, 100, 0),
(1487200, 44, 178.72981, -2869.5015, 92.94418, NULL, 0, 1, 0, 100, 0),
(1487200, 45, 184.02534, -2878.3716, 92.30419, NULL, 0, 1, 0, 100, 0),
(1487200, 46, 186.78435, -2894.731, 92.61203, NULL, 0, 1, 0, 100, 0),
(1487200, 47, 193.1604, -2904.673, 92.885086, NULL, 0, 1, 0, 100, 0),
(1487200, 48, 200.64632, -2925.725, 92.656525, NULL, 0, 1, 0, 100, 0),
(1487200, 49, 189.18666, -2922.2874, 93.340836, NULL, 0, 1, 0, 100, 0),
(1487200, 50, 179.52534, -2911.1165, 93.13945, NULL, 0, 1, 0, 100, 0),
(1487200, 51, 180.78668, -2890.9255, 92.09399, NULL, 0, 1, 0, 100, 0),
(1487200, 52, 190.62971, -2884.829, 92.397835, NULL, 0, 1, 0, 100, 0),
(1487200, 53, 200.87985, -2882.1377, 92.45194, NULL, 0, 1, 0, 100, 0);

-- Set Trok SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14872;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14872);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14872, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1487200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - On Reset - Start Path 1487200'),
(14872, 0, 1, 0, 108, 0, 10, 0, 10, 1487200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - On Point 10 of Path 1487200 Reached - Say Line 0'),
(14872, 0, 2, 0, 108, 0, 100, 0, 20, 1487200, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - On Point 20 of Path 1487200 Reached - Say Line 1'),
(14872, 0, 3, 4, 108, 0, 100, 0, 36, 1487200, 0, 0, 0, 0, 235, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - On Point 36 of Path 1487200 Reached - Pause Movement'),
(14872, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1487201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - On Point 36 of Path 1487200 Reached - Run Script'),
(14872, 0, 5, 0, 109, 0, 100, 0, 0, 1487200, 0, 0, 0, 0, 80, 1487200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - On Path 1487200 Finished - Run Script');

-- Set Trok Action Lists
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (1487200, 1487201));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1487200, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - Actionlist - Say Line 3'),
(1487200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 209.689, -2881.05, 92.1386, 0, 'Trok - Actionlist - Move To Position'),
(1487200, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 232, 1487200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - Actionlist - Start Path 1487200'),
(1487201, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trok - Actionlist - Say Line 2');

-- Set Movement Type 0 to all Swarm of bees & remove waypoints
UPDATE `creature` SET `MovementType` = 0 WHERE (`id1` = 14894) AND (`guid` IN (13586, 13587, 13588, 13589));
DELETE FROM `creature_addon` WHERE (`guid` IN (13586, 13587, 13588, 13589));

-- Set Creature Formation (Trok & Swarm of bees)
DELETE FROM `creature_formations` WHERE (`LeaderGUID` IN (13178));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(13178, 13178, 0, 0, 512, 0, 0),
(13178, 13586, 4, 170, 512, 0, 0),
(13178, 13587, 4, 190, 512, 0, 0),
(13178, 13588, 3, 150, 512, 0, 0),
(13178, 13589, 3, 210, 512, 0, 0);

-- Set Karu Waypoints (sniffed)
DELETE FROM `waypoint_data` WHERE (`id` IN (1487400, 1487401, 1487402, 1487403, 1487404, 1487405));
INSERT INTO `waypoint_data` (`id`,  `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1487400, 1, 236.83551, -2901.6663, 98.27072, NULL, 0, 0, 0, 100, 0),
(1487400, 2, 231.1377, -2900.656, 98.36378, NULL, 0, 0, 0, 100, 0),
(1487401, 1, 219.67693, -2892.0176, 95.375305, NULL, 0, 0, 0, 100, 0),
(1487401, 2, 215.81598, -2885.1648, 93.01749, NULL, 0, 0, 0, 100, 0),
(1487401, 3, 213.4375, -2878.5742, 91.89915, NULL, 0, 0, 0, 100, 0),
(1487401, 4, 214.15646, -2874.6372, 92.180084, NULL, 0, 0, 0, 100, 0),
(1487402, 1, 207.91458, -2874.2258, 92.25248, NULL, 0, 0, 0, 100, 0),
(1487402, 2, 205.98448, -2870.8022, 91.66923, NULL, 0, 0, 0, 100, 0),
(1487402, 3, 207.36649, -2869.3914, 92.06761, NULL, 0, 0, 0, 100, 0),
(1487403, 1, 210.06313, -2874.726, 92.30663, NULL, 0, 0, 0, 100, 0),
(1487403, 2, 214.50314, -2872.4348, 92.15973, NULL, 0, 0, 0, 100, 0),
(1487403, 3, 217.36098, -2865.298, 91.65433, NULL, 0, 0, 0, 100, 0),
(1487403, 4, 217.41162, -2850.4937, 90.641594, NULL, 0, 0, 0, 100, 0),
(1487404, 1, 213.4119, -2880.7893, 92.02311, NULL, 0, 0, 0, 100, 0),
(1487404, 2, 219.35861, -2891.507, 95.20309, NULL, 0, 0, 0, 100, 0),
(1487404, 3, 226.4482, -2900.4465, 97.3964, NULL, 0, 0, 0, 100, 0),
(1487404, 4, 232.52274, -2901.0789, 98.35955, NULL, 0, 0, 0, 100, 0),
(1487404, 5, 239.77821, -2901.221, 98.15523, NULL, 0, 0, 0, 100, 0),
(1487404, 6, 240.79094, -2901.4275, 98.10327, NULL, 0, 0, 0, 100, 0),
(1487405, 1, 216.49214, -2861.2983, 91.58173, NULL, 0, 0, 0, 100, 0),
(1487405, 2, 213.4119, -2880.7893, 92.02311, NULL, 0, 0, 0, 100, 0),
(1487405, 3, 219.35861, -2891.507, 95.20309, NULL, 0, 0, 0, 100, 0),
(1487405, 4, 226.4482, -2900.4465, 97.3964, NULL, 0, 0, 0, 100, 0),
(1487405, 5, 232.52274, -2901.0789, 98.35955, NULL, 0, 0, 0, 100, 0),
(1487405, 6, 239.77821, -2901.221, 98.15523, NULL, 0, 0, 0, 100, 0),
(1487405, 7, 240.79094, -2901.4275, 98.10327, NULL, 0, 0, 0, 100, 0);

-- Set Karu SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14874;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14874);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14874, 0, 0, 1, 1, 1, 100, 0, 120000, 180000, 120000, 180000, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Out of Combat - Stop Random Movement (Phase 1)'),
(14874, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Out of Combat - Set Event Phase 2 (Phase 1)'),
(14874, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 14, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 241.109, -2908.19, 98.1005, 0, 'Karu - Out of Combat - Move To Position (Phase 1)'),
(14874, 0, 3, 0, 34, 2, 100, 0, 8, 14, 0, 0, 0, 0, 80, 1487400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Reached Point 14 - Run Script (Phase 2)'),
(14874, 0, 4, 0, 109, 2, 100, 0, 0, 1487400, 0, 0, 0, 0, 80, 1487401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487400 Finished - Run Script (Phase 2)'),
(14874, 0, 5, 0, 109, 2, 100, 0, 0, 1487401, 0, 0, 0, 0, 80, 1487402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487401 Finished - Run Script (Phase 2)'),
(14874, 0, 6, 0, 109, 2, 100, 0, 0, 1487401, 0, 0, 0, 0, 80, 1487406, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487401 Finished - Run Script (Phase 2)'),
(14874, 0, 7, 0, 109, 2, 100, 0, 0, 1487402, 0, 0, 0, 0, 80, 1487403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487402 Finished - Run Script (Phase 2)'),
(14874, 0, 8, 0, 109, 2, 100, 0, 0, 1487403, 0, 0, 0, 0, 80, 1487404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487403 Finished - Run Script (Phase 2)'),
(14874, 0, 9, 0, 34, 2, 100, 0, 8, 15, 0, 0, 0, 0, 80, 1487405, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Reached Point 15 - Run Script (Phase 2)'),
(14874, 0, 10, 12, 109, 2, 100, 0, 0, 1487404, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487404 Finished - Set Event Phase 1 (Phase 2)'),
(14874, 0, 11, 12, 109, 2, 100, 0, 0, 1487405, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487405 Finished - Set Event Phase 1 (Phase 2)'),
(14874, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Path 1487405 Finished - Start Random Movement (Phase 2)'),
(14874, 0, 13, 14, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Respawn - Set Event Phase 1'),
(14874, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Respawn - Set Run Off'),
(14874, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - On Respawn - Start Random Movement');

-- Set Action Lists (Karu)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (1487400, 1487401, 1487402, 1487403, 1487404, 1487405, 1487406));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1487400, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.89921, 'Karu - Actionlist - Set Orientation 5.89921'),
(1487400, 9, 1, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 71, 0, 0, 2196, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Change Equipment'),
(1487400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 0'),
(1487400, 9, 3, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 232, 1487400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Path 1487400'),
(1487401, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 1'),
(1487401, 9, 1, 0, 0, 0, 100, 0, 5500, 5500, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Play Emote 7'),
(1487401, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 2'),
(1487401, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Remove Equipment'),
(1487401, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 3'),
(1487401, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1487401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Path 1487401'),
(1487402, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 4'),
(1487402, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 232, 1487402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Path 1487402'),
(1487403, 9, 0, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 71, 0, 0, 12744, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Change Equipment'),
(1487403, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1487403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Path 1487403'),
(1487404, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 5'),
(1487404, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 223, 67, 0, 0, 0, 0, 0, 9, 10685, 0, 50, 0, 0, 0, 0, 0, 'Karu - Actionlist - Do Action ID 67'),
(1487404, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Random Movement'),
(1487404, 9, 3, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Stop Random Movement'),
(1487404, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 223, 68, 0, 0, 0, 0, 0, 9, 10685, 0, 50, 0, 0, 0, 0, 0, 'Karu - Actionlist - Do Action ID 68'),
(1487404, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 69, 15, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 214.149, -2854.87, 91.2582, 0, 'Karu - Actionlist - Move To Position'),
(1487405, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Remove Equipment'),
(1487405, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 6'),
(1487405, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 232, 1487405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Path 1487405'),
(1487406, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Say Line 7'),
(1487406, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 232, 1487404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karu - Actionlist - Start Path 1487404');

-- Set Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (6, 7)) AND (`SourceEntry` = 14874) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 10685) AND (`ConditionValue2` = 100) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 6, 14874, 0, 0, 29, 1, 10685, 100, 0, 0, 0, 0, '', 'Karu will start this event only if there is at least one Swine alive.'),
(22, 7, 14874, 0, 0, 29, 1, 10685, 100, 0, 1, 0, 0, '', 'Karu will start this event only if Swine are not present.');

-- Edit two Swine spawn points & add 3 new ones
DELETE FROM `creature` WHERE (`id1` = 10685) AND (`guid` IN (20181, 20186, 24323, 25789, 25790));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(20181, 10685, 0, 0, 1, 0, 0, 1, 1, 0, 207.93942, -2842.1497, 91.52266, 5.53006, 200, 5, 0, 14, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(20186, 10685, 0, 0, 1, 0, 0, 1, 1, 0, 221.12567, -2841.0894, 91.34413, 2.15169, 200, 5, 0, 14, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(24323, 10685, 0, 0, 1, 0, 0, 1, 1, 0, 225.25417, -2858.4543, 91.61024, 5.24779, 200, 5, 0, 14, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(25789, 10685, 0, 0, 1, 0, 0, 1, 1, 0, 208.33398, -2863.0215, 91.66205, 2.89705, 200, 5, 0, 14, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(25790, 10685, 0, 0, 1, 0, 0, 1, 1, 0, 208.70555, -2847.2627, 91.358574, 6.05528, 200, 5, 0, 14, 0, 1, 0, 0, 0, '', 0, 0, NULL);

-- Set Swines Personal SAIs
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 10685);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-20181, -20186, -24323, -25789, -25790));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-20181, 0, 0, 1, 72, 0, 100, 0, 67, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Random Movement'),
(-20181, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 180, 0, 0, 0, 0, 10, 13180, 14874, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Follow Closest Creature \'Karu\''),
(-20181, 0, 2, 3, 72, 0, 100, 0, 68, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-20181, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-20181, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 20, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 207.939, -2842.15, 91.5227, 0, 'Swine - On Action 68 Done - Move To Position'),
(-20181, 0, 5, 6, 34, 0, 100, 0, 8, 20, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Start Random Movement'),
(-20181, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Set Run On'),
(-20186, 0, 0, 1, 72, 0, 100, 0, 67, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Random Movement'),
(-20186, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 150, 0, 0, 0, 0, 10, 13180, 14874, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Follow Closest Creature \'Karu\''),
(-20186, 0, 2, 3, 72, 0, 100, 0, 68, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-20186, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-20186, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 20, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 221.12567, -2841.0894, 91.34413, 0, 'Swine - On Action 68 Done - Move To Position'),
(-20186, 0, 5, 6, 34, 0, 100, 0, 8, 20, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Start Random Movement'),
(-20186, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Set Run On'),
(-24323, 0, 0, 1, 72, 0, 100, 0, 67, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Random Movement'),
(-24323, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 130, 0, 0, 0, 0, 10, 13180, 14874, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Follow Closest Creature \'Karu\''),
(-24323, 0, 2, 3, 72, 0, 100, 0, 68, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-24323, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-24323, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 20, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 225.25417, -2858.4543, 91.61024, 0, 'Swine - On Action 68 Done - Move To Position'),
(-24323, 0, 5, 6, 34, 0, 100, 0, 8, 20, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Start Random Movement'),
(-24323, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Set Run On'),
(-25789, 0, 0, 1, 72, 0, 100, 0, 67, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Random Movement'),
(-25789, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 210, 0, 0, 0, 0, 10, 13180, 14874, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Follow Closest Creature \'Karu\''),
(-25789, 0, 2, 3, 72, 0, 100, 0, 68, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-25789, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-25789, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 20, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 208.33398, -2863.0215, 91.66205, 0, 'Swine - On Action 68 Done - Move To Position'),
(-25789, 0, 5, 6, 34, 0, 100, 0, 8, 20, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Start Random Movement'),
(-25789, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Set Run On'),
(-25790, 0, 0, 1, 72, 0, 100, 0, 67, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Random Movement'),
(-25790, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 230, 0, 0, 0, 0, 10, 13180, 14874, 0, 0, 0, 0, 0, 0, 'Swine - On Action 67 Done - Start Follow Closest Creature \'Karu\''),
(-25790, 0, 2, 3, 72, 0, 100, 0, 68, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-25790, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Action 68 Done - Set Run Off'),
(-25790, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 20, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 208.70555, -2847.2627, 91.358574, 0, 'Swine - On Action 68 Done - Move To Position'),
(-25790, 0, 5, 6, 34, 0, 100, 0, 8, 20, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Start Random Movement'),
(-25790, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swine - On Reached Point 20 - Set Run On');
