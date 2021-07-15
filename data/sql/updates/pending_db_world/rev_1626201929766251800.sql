INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626201929766251800');

-- Moved Goldthorn to the ground
UPDATE `gameobject` SET `position_x` = -6859.7, `position_y` = -3335.35, `position_z` = 243.2 WHERE `id` = 2046 AND `guid` = 8985;
