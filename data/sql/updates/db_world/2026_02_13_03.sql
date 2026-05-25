-- DB update 2026_02_13_02 -> 2026_02_13_03
DELETE FROM `acore_string` WHERE `entry` = 5058;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(5058,'Boss id {} ({}) state is {} ({}).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
