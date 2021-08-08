INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628018690377094600');

UPDATE `spell_proc_event` SET `procFlags`=`procFlags`|0x00040000 WHERE `entry` IN (15257,15331,15332);
