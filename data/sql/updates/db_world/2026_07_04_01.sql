-- DB update 2026_07_04_00 -> 2026_07_04_01
--
DELETE FROM `acore_string` WHERE `entry` = 35455;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35455, 'A Wintergrasp battle is in progress. The scheduled server maintenance has been postponed.', '겨울손아귀 전투가 진행 중입니다. 예정된 서버 점검이 연기되었습니다.', 'Une bataille du Joug-d''hiver est en cours. La maintenance programmée du serveur a été reportée.', 'Eine Schlacht um Tausendwinter ist im Gange. Die geplante Serverwartung wurde verschoben.', '冬拥湖战斗正在进行中。计划中的服务器维护已被推迟。', '冬擁湖戰鬥正在進行中。排定的伺服器維護已延後。', 'Hay una batalla de Templo Helado en curso. El mantenimiento programado del servidor se ha pospuesto.', 'Hay una batalla de Templo Helado en curso. El mantenimiento programado del servidor se ha pospuesto.', 'Идёт битва за Ледяную Грудь. Плановое обслуживание сервера отложено.');
