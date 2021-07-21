INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626865484901243200');

-- Changed the coords so it dont spawn inside terrain
UPDATE `creature` SET `position_x` = -5231.283, `position_y` = 1287.122, `position_z` = 55.708 WHERE (`id` = 5307) AND (`guid` = 51210);

