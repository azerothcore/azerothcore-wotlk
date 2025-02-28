-- DB update 2025_02_27_00 -> 2025_02_28_00

-- Add Waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (14154200);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(14154200, 1, 1760.6979, 573.85925, 85.1191, NULL, 0, 0, 0, 100, 0),
(14154200, 2, 1756.0143, 568.31, 85.123055, NULL, 0, 0, 0, 100, 0),
(14154200, 3, 1752.3616, 564.8392, 85.12352, NULL, 0, 0, 0, 100, 0),
(14154200, 4, 1756.0143, 568.31, 85.123055, NULL, 0, 0, 0, 100, 0),
(14154200, 5, 1760.6979, 573.85925, 85.1191, NULL, 0, 0, 0, 100, 0),
(14154200, 6, 1764.0201, 578.5973, 85.11262, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (4376900);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4376900, 1, 1598.7472, 584.1803, 84.95168, NULL, 0, 0, 0, 100, 0),
(4376900, 2, 1604.4705, 571.67554, 80.41126, NULL, 0, 0, 0, 100, 0),
(4376900, 3, 1614.62, 557.94464, 72.1739, NULL, 0, 0, 0, 100, 0),
(4376900, 4, 1630.1543, 541.5376, 62.263496, NULL, 0, 0, 0, 100, 0),
(4376900, 5, 1648.82, 527.84894, 52.854412, NULL, 0, 0, 0, 100, 0),
(4376900, 6, 1630.1543, 541.5376, 62.263496, NULL, 0, 0, 0, 100, 0),
(4376900, 7, 1614.62, 557.94464, 72.1739, NULL, 0, 0, 0, 100, 0),
(4376900, 8, 1604.4705, 571.67554, 80.41126, NULL, 0, 0, 0, 100, 0),
(4376900, 9, 1598.7472, 584.1803, 84.95168, NULL, 0, 0, 0, 100, 0),
(4376900, 10, 1594.0377, 597.88556, 85.11365, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (4374100);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4374100, 1, 1660.8033, 507.39877, 50.56238, NULL, 0, 0, 0, 100, 0),
(4374100, 2, 1662.8678, 524.444, 50.562378, NULL, 0, 0, 0, 100, 0),
(4374100, 3, 1660.8033, 507.39877, 50.56238, NULL, 0, 0, 0, 100, 0),
(4374100, 4, 1655.2913, 495.21875, 50.562378, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (4402100);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4402100, 1, 1770.5005, 498.57526, 74.143776, NULL, 0, 0, 0, 100, 0),
(4402100, 2, 1761.895, 511.81027, 80.350655, NULL, 0, 0, 0, 100, 0),
(4402100, 3, 1756.6216, 520.43225, 85.26244, NULL, 0, 0, 0, 100, 0),
(4402100, 4, 1747.6699, 535.4413, 85.2586, NULL, 0, 0, 0, 100, 0),
(4402100, 5, 1756.6216, 520.43225, 85.26244, NULL, 0, 0, 0, 100, 0),
(4402100, 6, 1761.895, 511.81027, 80.350655, NULL, 0, 0, 0, 100, 0),
(4402100, 7, 1770.5005, 498.57526, 74.143776, NULL, 0, 0, 0, 100, 0),
(4402100, 8, 1782.6758, 498.85693, 74.130875, NULL, 0, 0, 0, 100, 0),
(4402100, 9, 1790.207, 509.90317, 74.15089, NULL, 0, 0, 0, 100, 0),
(4402100, 10, 1783.75, 522.1627, 69.57731, NULL, 0, 0, 0, 100, 0),
(4402100, 11, 1774.7915, 537.0277, 62.078495, NULL, 0, 0, 0, 100, 0),
(4402100, 12, 1772.6086, 545.96106, 62.07849, NULL, 0, 0, 0, 100, 0),
(4402100, 13, 1781.791, 556.1232, 59.427723, NULL, 0, 0, 0, 100, 0),
(4402100, 14, 1792.0605, 567.6834, 53.94507, NULL, 0, 0, 0, 100, 0),
(4402100, 15, 1781.791, 556.1232, 59.427723, NULL, 0, 0, 0, 100, 0),
(4402100, 16, 1772.6086, 545.96106, 62.07849, NULL, 0, 0, 0, 100, 0),
(4402100, 17, 1774.7915, 537.0277, 62.078495, NULL, 0, 0, 0, 100, 0),
(4402100, 18, 1783.75, 522.1627, 69.57731, NULL, 0, 0, 0, 100, 0),
(4402100, 19, 1790.207, 509.90317, 74.15089, NULL, 0, 0, 0, 100, 0),
(4402100, 20, 1782.6758, 498.85693, 74.130875, NULL, 0, 0, 0, 100, 0);

-- Remove Wrong npcs
DELETE FROM `creature` WHERE (`id1` = 25486) AND (`guid` IN (44464, 44948));
DELETE FROM `creature` WHERE (`id1` = 25373) AND (`guid` IN (43740));

-- Remove deleted npcs from linked respawn
DELETE FROM `linked_respawn` WHERE (`guid` IN (43740, 44464));

-- Add new Npcs
DELETE FROM `creature` WHERE (`id1` = 25506) AND (`guid` IN (44948));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(44948, 25506, 0, 0, 580, 0, 0, 1, 1, 1, 1759.415, 579.98596, 85.16913, 5.3494, 604800, 0, 0, 227630, 16155, 0, 0, 0, 0, '', 0);

DELETE FROM `creature` WHERE (`id1` = 25837) AND (`guid` IN (141542));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(141542, 25837, 0, 0, 580, 0, 0, 1, 1, 1, 1764.0201, 578.5973, 85.11262, 4.0692, 604800, 0, 0, 175935, 0, 2, 0, 0, 0, '', 0);

-- Add new npcs in linked respawn
DELETE FROM `linked_respawn` WHERE (`guid` IN (44948, 141542));
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(44948, 53668, 0),
(141542, 53668, 0);

-- Update various NPCs positions and movement type
UPDATE `creature` SET `MovementType` = 2, `position_x` = 1655.2913, `position_y` = 495.21875, `position_z` = 50.562378, `orientation` = 1.2064  WHERE (`id1` = 25373) AND (`guid` IN (43741));
UPDATE `creature` SET `MovementType` = 2, `position_x` = 1594.0377, `position_y` = 597.88556, `position_z` = 85.11365, `orientation` = 5.2748  WHERE (`id1` = 25373) AND (`guid` IN (43769));
UPDATE `creature` SET `position_x` = 1560.3777, `position_y` = 561.6525, `position_z` = 50.655094, `orientation` = 5.1609  WHERE (`id1` = 25373) AND (`guid` IN (43772));
UPDATE `creature` SET `position_x` = 1752.6904, `position_y` = 574.16266, `position_z` = 85.1591, `orientation` = 5.5261  WHERE (`id1` = 25486) AND (`guid` IN (44458));
UPDATE `creature` SET `position_x` = 1762.0695, `position_y` = 562.6295, `position_z` = 85.28138, `orientation` = 2.3099  WHERE (`id1` = 25486) AND (`guid` IN (44421));
UPDATE `creature` SET `position_x` = 1770.9169, `position_y` = 574.36676, `position_z` = 85.26621, `orientation` = 3.0639  WHERE (`id1` = 25483) AND (`guid` IN (44024));
UPDATE `creature` SET `MovementType` = 2 WHERE (`id1` = 25483) AND (`guid` IN (44021));

-- Add creature_addon rows
DELETE FROM `creature_addon` WHERE (`guid` IN (43741, 43769, 44024, 141542, 44948, 44021));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(43741, 4374100, 0, 0, 0, 0, 0, NULL),
(43769, 4376900, 0, 0, 0, 0, 0, NULL),
(141542, 14154200, 0, 0, 0, 0, 0, NULL),
(44024, 0, 0, 1, 0, 0, 0, NULL),
(44948, 0, 0, 1, 0, 0, 0, NULL),
(44021, 4402100, 0, 0, 0, 0, 0, NULL);

-- Add Creature Formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 44021;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(44021, 44021, 0, 0, 515, 0, 0),
(44021, 45516, 2, 270, 515, 0, 0);

-- Add don't override sai (Shadowsword Commander)
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` IN (25837));

-- Add Comment (Shadowsword Commander)
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 25837) AND (`guid` IN (247107));

-- Update General sai (Shadowsword Commander)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25837;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25837) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25837, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 0, 0, 11, 46763, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Commander - In Combat - Cast \'Battle Shout\''),
(25837, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 20000, 0, 0, 11, 46762, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Commander - In Combat - Cast \'Shield Slam\'');

-- Update personal SmartAI (Shadowsword Commander)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -247107) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-247107, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25848, 200, 0, 0, 0, 0, 0, 0, 'Shadowsword Commander - On Just Died - Despawn Instant');
