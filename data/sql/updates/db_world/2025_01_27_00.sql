-- DB update 2025_01_26_02 -> 2025_01_27_00
--
DELETE FROM `acore_string` WHERE `entry` IN (56, 82);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_deDE`, `locale_zhCN`, `locale_esES`, `locale_esMX`) VALUES
(56, 'Current Message of the day:', 'Aktuelle Nachricht des Tages:', '当前每日信息:', 'Mensaje actual del día:', 'Mensaje actual del día:'),
(82, '{}: {}', '{}: {}', '{}: {}', '{}: {}', '{}: {}');
