-- DB update 2024_08_06_03 -> 2024_08_08_00
--
DELETE FROM `acore_string` WHERE `entry` IN (6613,6615);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(6613, '|cfff00000[GM Announcement]: {}|r', NULL, NULL, '|cfff00000[GM Ankündigung von [{}]]: {}|r', '|cfff00000[管理员公告]: {}|r', NULL, NULL, NULL, NULL),
(6615, '|cffffff00[|c1f40af20GM Announce by|r |cffff0000{}|cffffff00]:|r {}|r', NULL, NULL, '|cffffff00[|c1f40af20GM Ankündigung von|r |cffff0000{}|cffffff00]:|r {}|r', '|cffffff00[|c1f40af20管理员广播|r |cffff0000{}|cffffff00]:|r {}|r', NULL, NULL, NULL, NULL);
