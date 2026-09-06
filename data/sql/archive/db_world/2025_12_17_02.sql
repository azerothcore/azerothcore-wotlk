-- DB update 2025_12_17_01 -> 2025_12_17_02
-- prevent 'Plagued Scavenger' from flying up to Dalaran
DELETE FROM `waypoint_data` WHERE `id` = 1006640 AND `point` = 8;
