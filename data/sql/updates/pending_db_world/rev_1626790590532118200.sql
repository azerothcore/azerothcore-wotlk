INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626790590532118200');

-- Changed the position of the spawn to match the source. Updates animprogress to 0 because its not a box
UPDATE `gameobject` SET `position_x` = -7194.81, `position_y` = -3753.68, `position_z` = 8.62923, `animprogress` = 0 WHERE (`id` = 175763) AND (`guid` = 17342);

