--
UPDATE `creature_template_movement` SET `Flight` = 2 WHERE `CreatureId` = 14517;

DELETE FROM `waypoint_data` WHERE `id` = 14517;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(14517, 1, -12281.58, -1392.84, 146.1, 5.27, 0, 2, 0, 100, 0),
(14517, 2, -12280.8, -1406.8, 130.6, 5.41, 0, 2, 0, 100, 0);
