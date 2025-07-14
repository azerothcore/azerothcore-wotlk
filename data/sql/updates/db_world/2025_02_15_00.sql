-- DB update 2025_02_14_00 -> 2025_02_15_00
-- Dragonflayer Invader - Set detection_range
UPDATE `creature_template` SET `detection_range` = 25 WHERE (`entry` = 24051);

-- Dragonflayer Invader - Set position, spawntimesecs, MovementType
UPDATE `creature` SET `position_x` = 762.207, `position_y` = -4894.027, `position_z` = 2.9162, `orientation` = 4.143, `spawntimesecs` = 15, `MovementType` = 2 WHERE (`guid` = 118766 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 762.207, `position_y` = -4894.027, `position_z` = 2.9162, `orientation` = 4.143, `spawntimesecs` = 37, `MovementType` = 2 WHERE (`guid` = 118770 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 766.356, `position_y` = -4971.977, `position_z` = 2.2148, `orientation` = 2.621, `spawntimesecs` = 20, `MovementType` = 2 WHERE (`guid` = 118767 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 766.356, `position_y` = -4971.977, `position_z` = 2.2148, `orientation` = 2.621, `spawntimesecs` = 24, `MovementType` = 2 WHERE (`guid` = 118771 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 803.852, `position_y` = -4963.192, `position_z` = 0.5461, `orientation` = 3.055, `spawntimesecs` = 28, `MovementType` = 2 WHERE (`guid` = 118768 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 803.852, `position_y` = -4963.192, `position_z` = 0.5461, `orientation` = 3.055, `spawntimesecs` = 32, `MovementType` = 2 WHERE (`guid` = 118772 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 789.250, `position_y` = -4909.428, `position_z` = 0.1650, `orientation` = 3.562, `spawntimesecs` = 18, `MovementType` = 2 WHERE (`guid` = 118769 AND `id1` = 24051);
UPDATE `creature` SET `position_x` = 789.250, `position_y` = -4909.428, `position_z` = 0.1650, `orientation` = 3.562, `spawntimesecs` = 44, `MovementType` = 2 WHERE (`guid` = 118773 AND `id1` = 24051);

-- Dragonflayer Invader - SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 24051);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24051);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(24051, 0, 0, 0, 9, 0, 100, 0, 5700, 11700, 5700, 11700, 8, 25, 11, 27577, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - In Combat - Cast Intercept'),
(24051, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - Corpse removed after 5s'),
(24051, 0, 2, 0, 9, 0, 100, 0, 8700, 14700, 8700, 14700, 10, 25, 11, 42870, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - In Combat - Throw Dragonflayer Harpoon'),
(24051, 0, 3, 0, 4, 0, 25, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - When AGRO - Talk');

-- Dragonflayer Invader - Set PathID and Waypoints
DELETE FROM `creature_addon` WHERE (`guid` = 118766 AND `path_id` = 1187660);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118766, 1187660, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118770 AND `path_id` = 1187700);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118770, 1187700, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118769 AND `path_id` = 1187690);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118769, 1187690, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118773 AND `path_id` = 1187730);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118773, 1187730, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118767 AND `path_id` = 1187670);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118767, 1187670, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118771 AND `path_id` = 1187710);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118771, 1187710, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118768 AND `path_id` = 1187680);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118768, 1187680, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 118772 AND `path_id` = 1187720);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (118772, 1187720, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE (`id` = 1187660);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187660, 1, 751.2, -4911.4, 2.8, NULL, 0, 1, 0, 100, 0),
(1187660, 2, 738.44, -4927.28, 5.868, NULL, 0, 1, 0, 100, 0),
(1187660, 3, 714.15, -4936.8, 6.437, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187700);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187700, 1, 751.2, -4911.4, 2.8, NULL, 0, 1, 0, 100, 0),
(1187700, 2, 738.44, -4927.28, 5.868, NULL, 0, 1, 0, 100, 0),
(1187700, 3, 714.15, -4936.8, 6.437, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187690);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187690, 1, 742.35, -4934.59, 5.643, NULL, 0, 1, 0, 100, 0),
(1187690, 2, 713.52, -4951.19, 4.560, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187730);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187730, 1, 742.35, -4934.59, 5.643, NULL, 0, 1, 0, 100, 0),
(1187730, 2, 713.52, -4951.19, 4.560, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187670);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187670, 1, 747.06, -4958.82, 2.191, NULL, 0, 1, 0, 100, 0),
(1187670, 2, 732.09, -4983.97, 4.683, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187710);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187710, 1, 747.06, -4958.82, 2.191, NULL, 0, 1, 0, 100, 0),
(1187710, 2, 732.09, -4983.97, 4.683, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187680);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187680, 1, 747.06, -4958.82, 2.191, NULL, 0, 1, 0, 100, 0),
(1187680, 2, 732.09, -4983.97, 4.683, NULL, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE (`id` = 1187720);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1187720, 1, 747.06, -4958.82, 2.191, NULL, 0, 1, 0, 100, 0),
(1187720, 2, 732.09, -4983.97, 4.683, NULL, 0, 1, 0, 100, 0);

-- Dragonflayer Worg - Set detection_range, skinloot
UPDATE `creature_template` SET `detection_range` = 25, `skinloot` = 0 WHERE (`entry` = 24063);

-- Dragonflayer Worg - Set position, spawntimesecs, MovementType
UPDATE `creature` SET `position_x` = 765.90, `position_y` = -4908.08, `position_z` = 1.91220, `orientation` = 4.45437, `spawntimesecs` = 12, `MovementType` = 2 WHERE (`guid` = 120557 AND `id1` = 24063);
UPDATE `creature` SET `position_x` = 769.99, `position_y` = -4892.57, `position_z` = 2.75514, `orientation` = 3.57080, `spawntimesecs` = 25, `MovementType` = 2 WHERE (`guid` = 120558 AND `id1` = 24063);
UPDATE `creature` SET `position_x` = 764.44, `position_y` = -4947.20, `position_z` = 2.50482, `orientation` = 1.99215, `spawntimesecs` = 15, `MovementType` = 2 WHERE (`guid` = 120559 AND `id1` = 24063);
UPDATE `creature` SET `position_x` = 779.27, `position_y` = -4960.70, `position_z` = 1.67408, `orientation` = 3.18596, `spawntimesecs` = 28, `MovementType` = 2 WHERE (`guid` = 120560 AND `id1` = 24063);
UPDATE `creature` SET `position_x` = 809.12, `position_y` = -4942.37, `position_z` = 0.99842, `orientation` = 3.28884, `spawntimesecs` = 23, `MovementType` = 2 WHERE (`guid` = 120561 AND `id1` = 24063);

-- Dragonflayer Worg - SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 24063);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24063);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(24063, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Worg - Corpse removed after 5s'),
(24063, 0, 2, 0, 0, 0, 70, 0, 5000, 10000, 5000, 10000, 0, 0, 11, 7367, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Worg - Cast Infected Bite');

-- Dragonflayer Worg - Set PathID
DELETE FROM `creature_addon` WHERE (`guid` = 120557 AND `path_id` = 1205570);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (120557, 1205570, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 120558 AND `path_id` = 1205580);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (120558, 1205580, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 120559 AND `path_id` = 1205590);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (120559, 1205590, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 120560 AND `path_id` = 1205600);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (120560, 1205600, 0, 0, 1, 0, 0, NULL);
DELETE FROM `creature_addon` WHERE (`guid` = 120561 AND `path_id` = 1205610);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES (120561, 1205610, 0, 0, 1, 0, 0, NULL);

-- Dragonflayer Worg - Set Waypoints
DELETE FROM `waypoint_data` WHERE (`id` = 1205570);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1205570, 1, 761.489, -4920.273, 2.7210, NULL, 0, 1, 0, 100, 0),
(1205570, 2, 734.507, -4943.745, 5.4293, NULL, 0, 1, 0, 100, 0),
(1205570, 3, 720.222, -4967.502, 5.9298, NULL, 0, 1, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE (`id` = 1205580);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1205580, 1, 742.317, -4907.741, 3.3050, NULL, 0, 1, 0, 100, 0),
(1205580, 2, 735.411, -4925.406, 6.1833, NULL, 0, 1, 0, 100, 0),
(1205580, 3, 716.655, -4939.511, 5.9821, NULL, 0, 1, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE (`id` = 1205590);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1205590, 1, 757.529, -4931.115, 4.1180, NULL, 0, 1, 0, 100, 0),
(1205590, 2, 733.010, -4944.042, 5.4884, NULL, 0, 1, 0, 100, 0),
(1205590, 3, 716.655, -4939.511, 5.9821, NULL, 0, 1, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE (`id` = 1205600);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1205600, 1, 718.531, -4963.948, 5.33493, 4.47765, 0, 1, 0, 100, 0),
(1205600, 2, 718.978, -4979.252, 6.09930, 4.61902, 0, 1, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE (`id` = 1205610);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1205610, 1, 809.12, -4942.37, 0.99842, NULL, 0, 1, 0, 100, 0),
(1205610, 2, 749.53, -4933.65, 5.18420, NULL, 0, 1, 0, 100, 0),
(1205610, 3, 734.90, -4979.91, 4.04356, NULL, 0, 1, 0, 100, 0),
(1205610, 4, 722.70, -4987.73, 6.33793, NULL, 0, 1, 0, 100, 0);

-- Valgarde Defender - Set Comment
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 23739) AND (`guid` IN (113665, 113664, 113644, 113663));

-- Valgarde Defender - Add 'DONT_OVERRIDE_SAI_ENTRY' Flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 23739);

-- Valgarde Defender - Set position and spawntimesecs for Defenders outside the gate
UPDATE `creature` SET `position_x` = 717.426, `position_y` = -4977.064, `position_z` = 6.1085, `orientation` = 0.9687, `spawntimesecs` = 45, `MovementType` = 0 WHERE (`guid` = 113665 AND `id1` = 23739);
UPDATE `creature` SET `position_x` = 717.615, `position_y` = -4991.929, `position_z` = 6.7516, `orientation` = 0.1786, `spawntimesecs` = 45, `MovementType` = 0 WHERE (`guid` = 113664 AND `id1` = 23739);
UPDATE `creature` SET `position_x` = 705.699, `position_y` = -4934.567, `position_z` = 6.4967, `orientation` = 0.3325, `spawntimesecs` = 45, `MovementType` = 0 WHERE (`guid` = 113644 AND `id1` = 23739);
UPDATE `creature` SET `position_x` = 709.157, `position_y` = -4947.396, `position_z` = 4.4368, `orientation` = 0.4260, `spawntimesecs` = 45, `MovementType` = 0 WHERE (`guid` = 113663 AND `id1` = 23739);

-- Valgarde Defender - SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 23739);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23739);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(23739, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - In Combat - Cast Shoot'),
(23739, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 3000, 5000, 0, 0, 11, 31827, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - In Combat - Cast Heroic Strike');

-- Valgarde Defender - Set Guid SmartAI for Defenders outside the gate
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -113665);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-113665, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - Corpse removed after 5s'),
(-113665, 0, 3, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - When AGRO - Talk'),
(-113665, 0, 4, 0, 0, 0, 100, 0, 1000, 2000, 1000, 2000, 0, 0, 39, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - In Combat - Call HELP');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -113664);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-113664, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - Corpse removed after 5s'),
(-113664, 0, 3, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - When AGRO - Talk'),
(-113664, 0, 4, 0, 0, 0, 100, 0, 1000, 2000, 1000, 2000, 0, 0, 39, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - In Combat - Call HELP');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -113644);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-113644, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - Corpse removed after 5s'),
(-113644, 0, 3, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - When AGRO - Talk'),
(-113644, 0, 4, 0, 0, 0, 100, 0, 1000, 2000, 1000, 2000, 0, 0, 39, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - In Combat - Call HELP');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -113663);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-113663, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - Corpse removed after 5s'),
(-113663, 0, 3, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - When AGRO - Talk'),
(-113663, 0, 4, 0, 0, 0, 100, 0, 1000, 2000, 1000, 2000, 0, 0, 39, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Defender - In Combat - Call HELP');

-- Valgarde Defender - Text speach
DELETE FROM `creature_text` WHERE `CreatureID` = 23739;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(23739, 0, 0, 'Don\'t let those monsters through the gate! Stand firm, soldiers!', 12, 0, 100, 0, 0, 0, 22692, 0, 'Valgarde Defender'),
(23739, 0, 1, 'FIRE! FIRE!', 12, 0, 100, 0, 0, 0, 22689, 0, 'Valgarde Defender'),
(23739, 0, 2, 'Shoot it between the eyes! Those beasts are vulnerable there!', 12, 0, 100, 0, 0, 0, 22690, 0, 'Valgarde Defender'),
(23739, 0, 3, 'Invader incoming!', 12, 0, 100, 0, 0, 0, 22691, 0, 'Valgarde Defender'),
(23739, 0, 4, 'It\'s coming right for us!', 12, 0, 100, 0, 0, 0, 22688, 0, 'Valgarde Defender');

-- Valgarde Harpoon Target - SmartAI and Template Movement (Movement values Sniffed).
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 23821);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(23821, 0, 0, 1, 1, 0, 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23821;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23821);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23821, 0, 0, 0, 8, 0, 100, 512, 61588, 0, 0, 0, 0, 0, 11, 52955, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Harpoon Target - On Spellhit \'Blazing Harpoon\' - Cast \'Torch\''),
(23821, 0, 1, 1, 1, 0, 100, 513, 1000, 1000, 1000, 1000, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Harpoon Target - Out of Combat - Disable Combat Movement (No Repeat)'),
(23821, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Harpoon Target - Out of Combat - Set Reactstate Passive (No Repeat)');
