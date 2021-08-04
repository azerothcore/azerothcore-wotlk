INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627313288997304500');

UPDATE `spell_dbc` SET `Attributes`=`Attributes`|0x20000000 WHERE `ID` IN (20252,20616,20617,25272,25275);
