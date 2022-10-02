--
DELETE FROM `waypoint_data` WHERE `id`=215000;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(215000, 1, 9921.88, 738.288, 1314.69, 2.06284, 40000, 0, 0, 100, 0),
(215000, 2, 9922.85, 737.091, 1314.9, 5.33838, 40000, 0, 0, 100, 0);

DELETE FROM `creature_template_addon` WHERE  `entry`=2150;

UPDATE `creature` SET `MovementType`='2' WHERE  `guid`=46393;
UPDATE `creature_addon` SET `path_id`='215000' WHERE  `guid`=46393;
