-- DB update 2026_03_08_03 -> 2026_03_08_04

-- Remove Not-Selectable flag (Earthen Stoneshaper)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~33554432 WHERE (`entry` = 33620);

-- Remove SAI (Earthen Stoneshaper)
UPDATE `creature_template` SET `AIName` = '' WHERE (`entry` = 33620);

-- Delete GUID SAI (Earthen Stoneshaper, Kirin Tor Battle-Mage & Kirin Tor Mage).
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN  (-136525, -136526, -136537, -136524, -136271)) AND (`source_type` = 0);

-- Move waypoints in waypoint_data.
DELETE FROM `waypoints` WHERE `entry` IN (13627100, 13627101,33624);
DELETE FROM `waypoint_data` WHERE `id` IN (13627100, 13627101, 3362400);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(13627100, 1, -856.854, -159.629, 458.894, NULL, 0, 0, 0, 100, 0),
(13627100, 2, -815.381, -160.206, 429.841, NULL, 0, 0, 0, 100, 0),
(13627100, 3, -812.063, -160.252, 429.841, NULL, 0, 0, 0, 100, 0),
(13627100, 4, -787.449, -186.878, 429.841, NULL, 0, 0, 0, 100, 0),
(13627100, 5, -764.428, -185.599, 429.841, NULL, 0, 0, 0, 100, 0),
(13627100, 6, -756.902, -183.903, 429.824, NULL, 0, 0, 0, 100, 0),
(13627100, 7, -743.469, -190.483, 429.841, NULL, 45000, 0, 0, 100, 0),
(13627100, 8, -735.021, -155.349, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 9, -733.845, -123.15, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 10, -735.325, -104.313, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 11, -726.365, -86.0322, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 12, -710.154, -81.27, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 13, -700.494, -81.3369, 429.402, NULL, 45000, 0, 0, 100, 0),
(13627100, 14, -723.062, -81.6906, 429.842, NULL, 0, 0, 0, 100, 0),
(13627100, 15, -735.383, -98.9337, 429.842, NULL, 0, 0, 0, 100, 0),
(13627100, 16, -736.991, -134.149, 429.841, NULL, 0, 0, 0, 100, 0),
(13627100, 17, -740.398, -157.068, 429.842, NULL, 0, 0, 0, 100, 0),
(13627100, 18, -746.407, -170.483, 429.842, NULL, 0, 0, 0, 100, 0),
(13627100, 19, -748.094, -175.932, 429.801, NULL, 0, 0, 0, 100, 0),
(13627100, 20, -776.031, -186.115, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 21, -795.367, -180.787, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 22, -803.027, -151.463, 429.84, NULL, 0, 0, 0, 100, 0),
(13627100, 23, -800.079, -131.901, 429.614, NULL, 0, 0, 0, 100, 0),
(13627100, 24, -798.208, -85.7146, 429.842, NULL, 0, 0, 0, 100, 0),
(13627100, 25, -796.247, -66.4749, 429.843, NULL, 0, 0, 0, 100, 0),
(13627100, 26, -803.578, -54.884, 429.843, NULL, 0, 0, 0, 100, 0),
(13627101, 1, -759.514, -46.609, 429.84, NULL, 0, 1, 0, 100, 0),
(13627101, 2, -709.315, -26.547, 429.84, NULL, 0, 1, 0, 100, 0),
(13627101, 3, -702.395, -11.965, 429.73, NULL, 0, 1, 0, 100, 0),
(13627101, 4, -679.813, -8.959, 426.88, NULL, 0, 1, 0, 100, 0),
(3362400, 1, -696.34, -85.89, 429.24, NULL, 0, 0, 0, 100, 0),
(3362400, 2, -676.52, -84.802, 426.89, NULL, 0, 0, 0, 100, 0);

-- Edit SAI (Goran Steelbreaker & Archmage Pentarus).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (33622, 33624));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (33622,33624));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33622, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 13627100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Respawn - Start Path 13627100'),
(33622, 0, 1, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 232, 13627101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Data Set 0 1 - Start Path 13627101'),
(33624, 0, 0, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 232, 3362400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Data Set 1 1 - Start Path 3362400'),
(33624, 0, 1, 2, 109, 0, 100, 0, 0, 3362400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Path 3362400 Finished - Say Line 1'),
(33624, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 136253, 33579, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Path 3362400 Finished - Set Data 0 2');

-- Set Creature Formations.
DELETE FROM `creature_formations` WHERE (`LeaderGUID` IN (136271, 136281));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(136271, 136271, 0, 0, 515, 0, 0),
(136271, 136525, 3, 120, 515, 0, 0),
(136271, 136526, 3, 240, 515, 0, 0),
(136281, 136281, 0, 0, 515, 0, 0),
(136281, 136537, 5, 120, 515, 0, 0),
(136281, 136524, 5, 240, 515, 0, 0);
