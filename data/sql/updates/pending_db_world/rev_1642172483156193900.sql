INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642172483156193900');

UPDATE `creature_template` SET `unit_flags` = `unit_flags` |64|256|512 WHERE `entry` = 11502;
