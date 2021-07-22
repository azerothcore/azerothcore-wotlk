INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626479953231614600');

-- Moves the herbs outside of buildings
UPDATE `gameobject` SET `position_x` = -9376.65, `position_y` = -3034.396, `position_z` = 136.69 WHERE `guid` = 85462;
UPDATE `gameobject` SET `position_x` = 690.697, `position_y` = -903.77, `position_z` = 164.29 WHERE `guid` = 3564;
