INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627383748783756100');

-- Changed the spawn point of Scarlet High Clerist to the tower south of hearthglen
UPDATE `creature` SET  `position_x` = 2703.07, `position_y` = -1951.61, `position_z` = 107.23 WHERE (`id` = 1839) AND (`guid` = 49764);

