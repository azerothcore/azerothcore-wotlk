INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626116879969851100');

-- move the Groomsblood down on the ground
UPDATE `gameobject` SET `position_x` = -11810.63, `position_y` = -3047.32, `position_z` = 9.84 WHERE `id` = 142145 AND `guid` = 16527;
UPDATE `gameobject` SET `position_x` = -11685.57, `position_y` = -3211.47, `position_z` = 12.53 WHERE `id` = 142145 AND `guid` = 16504;
