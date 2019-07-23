INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1563920358511875161');

UPDATE `smart_scripts` SET `action_param2` = NOT `action_param3` WHERE `action_type` = 36;
UPDATE `smart_scripts` SET `action_param3` = 0 WHERE `action_type` = 36;
