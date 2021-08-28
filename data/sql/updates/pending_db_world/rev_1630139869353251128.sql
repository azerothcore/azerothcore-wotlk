INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630139869353251128');

-- Slightly changes the position of a Small Thorium Vein so it can be mined
UPDATE `gameobject` SET `position_x` = -7275, `position_y` = -788, `position_z` = 299.15 WHERE `id` = 324 AND `guid` = 154;
