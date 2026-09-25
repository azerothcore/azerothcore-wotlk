-- DB update 2025_04_30_05 -> 2025_05_01_00

-- Add waypoints
DELETE FROM `waypoint_data` WHERE `id` IN ("12921200");
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("12921200", 1, 2212.1313, -5812.2856, 101.33683, NULL, 0, 0, 0, 100, 0),
("12921200", 2, 2204.9878, -5801.3545, 101.352875, NULL, 0, 0, 0, 100, 0),
("12921200", 3, 2183.3723, -5812.831, 101.349945, NULL, 0, 0, 0, 100, 0),
("12921200", 4, 2178.0305, -5838.2285, 101.35527, NULL, 0, 0, 0, 100, 0),
("12921200", 5, 2187.962, -5859.553, 101.332436, NULL, 0, 0, 0, 100, 0),
("12921200", 6, 2221.1243, -5861.5303, 101.47864, NULL, 0, 0, 0, 100, 0),
("12921200", 7, 2250.3555, -5834.3096, 101.25951, NULL, 0, 0, 0, 100, 0),
("12921200", 8, 2217.0012, -5826.042, 101.37887, NULL, 0, 0, 0, 100, 0),
("12921200", 9, 2191.5737, -5828.108, 101.93167, NULL, 0, 0, 0, 100, 0),
("12921200", 10, 2199.251, -5852.3496, 101.37288, NULL, 0, 0, 0, 100, 0),
("12921200", 11, 2225.122, -5850.7876, 101.233604, NULL, 0, 0, 0, 100, 0),
("12921200", 12, 2252.0554, -5834.1104, 101.232346, NULL, 0, 0, 0, 100, 0),
("12921200", 13, 2246.5051, -5829.7847, 101.24832, NULL, 0, 0, 0, 100, 0),
("12921200", 14, 2221.6838, -5823.5996, 101.55388, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN ("12921000");
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("12921000", 1, 2222.3447, -5818.2954, 101.58636, NULL, 0, 0, 0, 100, 0),
("12921000", 2, 2193.6536, -5804.279, 101.345184, NULL, 0, 0, 0, 100, 0),
("12921000", 3, 2190.4019, -5833.695, 101.39836, NULL, 0, 0, 0, 100, 0),
("12921000", 4, 2192.386, -5848.4937, 101.35042, NULL, 0, 0, 0, 100, 0),
("12921000", 5, 2202.781, -5858.187, 101.56625, NULL, 0, 0, 0, 100, 0),
("12921000", 6, 2217.3516, -5860.6836, 101.396805, NULL, 0, 0, 0, 100, 0),
("12921000", 7, 2228.4097, -5858.6533, 101.26566, NULL, 0, 0, 0, 100, 0),
("12921000", 8, 2233.331, -5851.655, 101.59271, NULL, 0, 0, 0, 100, 0);

-- Remove Wrong guids (Havenshire Stallion, Mare, Colt).
DELETE FROM `creature` WHERE (`id1` = 28605) AND (`guid` IN (129216, 129217));
DELETE FROM `creature` WHERE (`id1` = 28606) AND (`guid` IN (129237));
DELETE FROM `creature` WHERE (`id1` = 28607) AND (`guid` IN (129252));
DELETE FROM `creature_addon` WHERE (`guid` IN (129237, 129252));

-- Set MT waypoint for Pack Leader
UPDATE `creature` SET `MovementType` = 2 WHERE (`id1` = 28605) AND (`guid` IN (129212));

DELETE FROM `creature_addon` WHERE (`guid` IN (129212));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(129212, 12921200, 0, 0, 0, 0, 0, NULL);

-- Add Formation for horse's pack
DELETE FROM `creature_formations` WHERE `leaderGUID` = 129212;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(129212, 129212, 0, 0, 512, 0, 0),
(129212, 129230, 3, 220, 512, 0, 0),
(129212, 129208, 3.5, 160, 512, 0, 0),
(129212, 129243, 4, 200, 512, 0, 0),
(129212, 129234, 4.5, 180, 512, 0, 0);

-- Add comment for the single Horse
UPDATE `creature` SET `Comment` = 'has guid specific SAI' WHERE (`id1` = 28605) AND (`guid` IN (129210));

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2860500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2860500, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.6, 'Havenshire Stallion - Actionlist - Set Orientation 1.6'),
(2860500, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 5, 377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - Actionlist - Play Emote 377'),
(2860500, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 136, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - Actionlist - Set Walk Speed to 2.0'),
(2860500, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2232.89, -5840.03, 101.482, 0, 'Havenshire Stallion - Actionlist - Move To Self'),
(2860500, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 97, 10, 10, 1, 0, 0, 0, 202, 0, 0, 1, 0, 2231.45, -5828.9, 101.371, 0, 'Havenshire Stallion - Actionlist - Jump To Pos'),
(2860500, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 232, 12921000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - Actionlist - Start Path 12921000');

-- Set personal SmartAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129210);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129210, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12921000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Respawn - Start Path 12921000'),
(-129210, 0, 1, 2, 108, 0, 100, 0, 8, 12921000, 0, 0, 0, 0, 234, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Point 8 of Path 12921000 Reached - Stop Movement'),
(-129210, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2860500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Point 8 of Path 12921000 Reached - Run Script');
