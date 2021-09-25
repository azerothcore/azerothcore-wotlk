INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632549631170638798');

-- Move Zhevra Runner 18658 spawn out from inside tree
UPDATE `creature` SET `position_x` = -831.5, `position_y` = -2614.1, `position_z` = 91.9, `orientation` = 3 WHERE `id` = 3242 AND `guid` = 18658;

