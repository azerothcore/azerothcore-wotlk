INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630930325081449726');

-- Move Ashenvale Elder Bear spawn slightly
UPDATE `creature` SET `position_x` = 2240, `position_y` = -1842.7, `position_z` = 81.7 WHERE `id` = 3810 AND `guid` = 34360;

