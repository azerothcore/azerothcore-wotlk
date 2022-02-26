INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645819759880724600');

DELETE FROM `acore_string` WHERE `entry` = 726;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(726, '|cffff0000[Arena Queue]:|r %s (skirmish %s) -- [%u-%u] [%u/%u]|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
