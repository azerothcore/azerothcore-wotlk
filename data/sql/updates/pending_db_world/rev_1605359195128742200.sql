INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605359195128742200');

UPDATE `spell_proc_event` SET `procFlags` = 0, `Cooldown` = 50000 WHERE `entry` = 67653;
