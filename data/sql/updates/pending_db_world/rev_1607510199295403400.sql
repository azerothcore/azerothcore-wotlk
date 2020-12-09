INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607510199295403400');

DELETE FROM `game_tele` WHERE `id`=1435;
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES (1435, -8779.900391, 834.348816, 94.680130, 0.653013, 0, 'TheStockade');
