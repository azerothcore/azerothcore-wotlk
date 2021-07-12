INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626116879969851100');

-- move the Groomsblood down on the ground
UPDATE `gameobject` SET `position_x` = -11745, `position_y` = -3272, `position_z` = 4.467 WHERE `id` = 142145 AND `guid` = 16527;
UPDATE `gameobject` SET `position_x` = -11865.76, `position_y` = -3065.08, `position_z` = 14.45 WHERE `id` = 142145 AND `guid` = 16504;
