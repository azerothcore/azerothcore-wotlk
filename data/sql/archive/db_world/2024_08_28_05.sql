-- DB update 2024_08_28_04 -> 2024_08_28_05
UPDATE `waypoint_data` SET `move_type` = 0 WHERE `id` IN (1486850, 1486860, 1486870, 1486880);
