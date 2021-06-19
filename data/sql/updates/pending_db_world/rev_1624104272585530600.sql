INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624104272585530600');

-- Correct position for Magister Duskwither
UPDATE `creature` SET `position_x` = 9026.383789, `position_y` = -7457.562988, `position_z` = 103.274475, `orientation` = 4.869936 WHERE (`id` = 15951) AND (`guid` IN (56398));
