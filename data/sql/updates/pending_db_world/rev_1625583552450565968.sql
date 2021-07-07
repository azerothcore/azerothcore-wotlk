INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625583552450565968');

-- Correct Ironfur Bear spawn position
UPDATE `creature` SET `position_x` = -4120.52, `position_y` = -621.2, `position_z` = -18.74 WHERE `id` = 5268 AND `guid` = 50650;

-- Correct Longtooth Runner spawn position
UPDATE `creature` SET `position_x` = -4270.84, `position_y` = 36.42,  `position_z` =  55.14 WHERE `id` = 5286 AND `guid` = 50875;
