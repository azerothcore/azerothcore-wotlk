-- prevent 'Plagued Scavenger' from flying up to Dalaran
DELETE FROM `waypoint_data` WHERE `id` = 1006640 AND `point` = 8;
