INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630408706945809100');

-- Corrected coords of Cavindra
UPDATE `creature` SET `position_x` = -1458.87, `position_y` = 2797.62, `position_z` = 93.817, `orientation` = 1.96495 WHERE (`id` = 13697) AND (`guid` IN (29063));
