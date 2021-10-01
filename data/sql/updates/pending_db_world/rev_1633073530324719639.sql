INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633073530324719639');

-- Slightly changes the position of a Copper Ore that was unreachable
UPDATE `gameobject` SET `position_x` = -5632, `position_y` = -1752, `position_z` = 357.2 WHERE `id` = 1731 AND `guid` = 73532;
