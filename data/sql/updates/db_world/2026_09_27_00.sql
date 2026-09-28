-- DB update 2026_09_26_01 -> 2026_09_27_00
--
DELETE FROM `acore_string` WHERE `entry` IN (5057, 5058);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(5057,'Boss id {} ({}) state is now set to {} ({}).',NULL,NULL,'Boss-ID {} ({}) Status wurde auf {} ({}) gesetzt.',NULL,NULL,'Estado del jefe {} ({}) establecido a {} ({}).','Estado del jefe {} ({}) establecido a {} ({}).',NULL),
(5058,'Boss id {} ({}) state is {} ({}).',NULL,NULL,'Boss-ID {} ({}) Status ist {} ({}).',NULL,NULL,'Estado del jefe {} ({}) es {} ({}).','Estado del jefe {} ({}) es {} ({}).',NULL);
