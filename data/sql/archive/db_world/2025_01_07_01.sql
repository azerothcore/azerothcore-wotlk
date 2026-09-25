-- DB update 2025_01_07_00 -> 2025_01_07_01

-- Delete Wrong Amani'shi Medicine Man
DELETE FROM `creature` WHERE (`id1` = 23581) AND (`guid` IN (89310));
DELETE FROM `creature_addon` WHERE (`guid` IN (89310));
DELETE FROM `linked_respawn` WHERE (`guid` IN (89310));

-- Set WD and MT for Amani'shi Medicine Man
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` IN (86209) AND `id1` = 23581;

-- Waypoint
DELETE FROM `waypoint_data` WHERE `id` IN (8621000);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(8621000, 1, 97.787, 1411.9034, -3.8629317, NULL, 0, 0, 0, 100, 0),
(8621000, 2, 118.593, 1404.9677, -7.3945456, NULL, 0, 0, 0, 100, 0),
(8621000, 3, 140.44618, 1412.8431, -0.6880279, NULL, 0, 0, 0, 100, 0),
(8621000, 4, 160.95193, 1408.474, 4.5122232, NULL, 0, 0, 0, 100, 0),
(8621000, 5, 148.4082, 1422.7607, 2.8240137, NULL, 0, 0, 0, 100, 0),
(8621000, 6, 132.07227, 1418.0293, -1.9425232, NULL, 0, 0, 0, 100, 0),
(8621000, 7, 99.87826, 1421.7754, 0.6053877, NULL, 0, 0, 0, 100, 0),
(8621000, 8, 69.989365, 1421.9194, 0.8218676, NULL, 0, 0, 0, 100, 0),
(8621000, 9, 63.964302, 1410.9033, 0.8689089, NULL, 0, 0, 0, 100, 0),
(8621000, 10, 97.787, 1411.9034, -3.8629317, NULL, 0, 0, 0, 100, 0);

-- Set WD and MT and add creature addon for Amani'shi Wind Walker (I would have preferred to put the path in the guid smartai, just to prevent the delay).
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` IN (86210) AND `id1` = 24179;
DELETE FROM `creature_addon` WHERE (`guid` IN (86210));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(86210, 8621000, 0, 0, 0, 0, 0, NULL);

-- Add Creature Formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 86210;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(86210, 86210, 0, 0, 515, 0, 0),
(86210, 86209, 3, 270, 515, 0, 0);

-- Remove other two Wrong Npcs (and set WD and MT for another).
DELETE FROM `creature` WHERE (`id1` = 24059) AND (`guid` IN (86211));
DELETE FROM `creature` WHERE (`id1` = 23596) AND (`guid` IN (86212));
DELETE FROM `creature_addon` WHERE (`guid` IN (86211 ,86212));
DELETE FROM `linked_respawn` WHERE (`guid` IN (86211 ,86212));

-- This npc and an Amani'shi Flame Caster should be in formation and one of them have a waypoint, but I cannot sniff it (it was changed during cataclysm).
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` IN (89326) AND `id1` = 24059;
