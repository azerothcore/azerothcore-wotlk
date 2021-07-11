INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625958180512949700');

-- move ore node above to a nearby hill
UPDATE `gameobject` SET `position_x` = -781.1, `position_y` = 185.2, `position_z` = 59.6  WHERE `id` = 103711 AND `guid` = 75523;
