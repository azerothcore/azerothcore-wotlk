INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1563566703983662300');

DELETE FROM `waypoint_data` WHERE `id`=1142920 AND `point` IN (33,34);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1142920, 33, 5761.59, 597.858, 649.707, 0, 0, 0, 0, 100, 0),
(1142920, 34, 5722.22, 624.876, 646.633, 0, 0, 0, 0, 100, 0);
