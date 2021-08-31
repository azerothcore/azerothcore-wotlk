INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630416137992915266');

-- Move Tin Vein 63486 slightly so it is accessible to players
UPDATE `gameobject` SET `position_x` = -10483.46, `position_y` = 1969.77, `position_z` =  12.065  WHERE `id` = 1732 AND `guid` = 63486;

