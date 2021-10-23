INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634953274063126700');

UPDATE `spell_proc_event` SET `procFlags` = `procFlags`|16384 WHERE `entry` = 16164;
