INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627916502657250695');

-- Moves Wildthorn Stalker spawn from inside tree object
UPDATE `creature` SET `position_x` = 1591.68, `position_y` = -2539.28, `position_z` = 101.81  WHERE `id` = 3819 AND `guid` = 34832;

