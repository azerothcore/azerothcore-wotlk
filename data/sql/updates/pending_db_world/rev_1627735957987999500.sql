INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627735957987999500');

-- Change the spawn points of Heavy War Golem (5854) so they spawn in the bridge
UPDATE `creature` SET `position_x` = -6681.53, `position_y` = -1352.86, `position_z` = 210.77  WHERE (`id` = 5854) AND (`guid` = 5608);
UPDATE `creature` SET `position_x` = -6663.55, `position_y` = -1317.16, `position_z` = 208.48  WHERE (`id` = 5854) AND (`guid` = 5687);

