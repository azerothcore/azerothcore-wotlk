--
-- https://www.wowhead.com/wotlk/npc=2150/zenn-foulhoof
UPDATE `creature` SET `position_x`=9923.96, `position_y`=739.216, `position_z`=1315.44, `orientation`=3.6112 WHERE  `guid`=46393;

DELETE FROM `waypoint_data` WHERE `id`=21500;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(21500, 1, 9923.96, 739.216, 1315.44, 2.9860, 29000, 0, 0, 100, 0),
(21500, 2, 9923.96, 739.216, 1315.44, 4.8646, 22000, 0, 0, 100, 0),
(21500, 3, 9921.12, 736.491, 1314.25, 3.5710, 12000, 0, 0, 100, 0),
(21500, 4, 9921.12, 736.491, 1314.25, 2.9646, 29000, 0, 0, 100, 0),
(21500, 5, 9921.12, 736.491, 1314.25, 4.4380, 22000, 0, 0, 100, 0),
(21500, 6, 9924.50, 739.539, 1315.63, 0.2951, 12000, 0, 0, 100, 0),
(21500, 7, 9924.50, 739.539, 1315.63, 5.9594, 29000, 0, 0, 100, 0),
(21500, 8, 9927.28, 740.915, 1316.50, 0.8543, 22000, 0, 0, 100, 0),
(21500, 9, 9923.96, 739.216, 1315.44, 3.6112, 29000, 0, 0, 100, 0);

DELETE FROM `creature_template_addon` WHERE  `entry`=2150;

UPDATE `creature` SET `MovementType`='2' WHERE  `guid`=46393;
UPDATE `creature_addon` SET `path_id`='21500' WHERE  `guid`=46393;
