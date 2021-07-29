INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627581490592719000');

-- Moved the node outside of the tree
UPDATE `gameobject` SET `position_x` = 6629.067 , `position_y` = -7382.726, `position_z` = 54.81 WHERE (`id` = 1621) AND (`guid` = 65024);

