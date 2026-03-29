-- DB update 2026_03_21_00 -> 2026_03_21_01
-- Add language string for pinfo online time
DELETE FROM `acore_string` WHERE `entry` = 35410;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35410, '¦ Online for: {}', '¦ 온라인 시간: {}', '¦ Online depuis : {}', '¦ Online seit: {}', '¦ 在线时长：{}', '¦ 線上時間：{}', '¦ Conectado durante: {}', '¦ Conectado durante: {}', '¦ Онлайн: {}');
