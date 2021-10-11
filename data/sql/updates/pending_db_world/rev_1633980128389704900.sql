INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633980128389704900');

DELETE FROM `smart_scripts` WHERE `action_type`=11 AND `action_param1` IN (1604,13496);
