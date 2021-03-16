INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615898302928359000');
DELETE FROM `acore_string` WHERE (`entry` = 365);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(365, 'Invalid parameter %s', NULL, 'Paramètre invalide: %s', NULL, NULL, NULL, NULL, NULL, 'Недействительный параметр: %s');
