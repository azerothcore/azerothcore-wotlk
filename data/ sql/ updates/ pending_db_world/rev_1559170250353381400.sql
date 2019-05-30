INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559170250353381400');

UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE (entry = 18374);
