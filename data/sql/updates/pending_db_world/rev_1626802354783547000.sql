INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626802354783547000');

-- Fixed the z position so now nodes are on ground level
UPDATE `gameobject` SET `position_z` = 16.463600 WHERE (`guid` IN (73680, 73681, 73682, 73683, 73684));

