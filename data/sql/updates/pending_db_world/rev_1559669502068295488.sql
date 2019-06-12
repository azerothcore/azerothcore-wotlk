INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559669502068295488');

UPDATE `spell_proc_event` SET `SchoolMask` = 0, `procFlags` = 1048576 WHERE `entry` IN (20185,20186);
