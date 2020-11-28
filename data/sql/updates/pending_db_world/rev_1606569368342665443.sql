INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606569368342665443');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~512&~256  WHERE (`entry` = 31094);
