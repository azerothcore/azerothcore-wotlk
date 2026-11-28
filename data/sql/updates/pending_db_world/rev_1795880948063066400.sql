--
DELETE FROM `acore_string` WHERE `entry` = 35491;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35491, 'Packet logging is unavailable: PacketLogFile is empty or cannot be opened. Check worldserver.conf and restart the worldserver.');

DELETE FROM `acore_string_locale` WHERE `entry` = 35491;
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`) VALUES
(35491, 'koKR', '패킷 기록을 사용할 수 없습니다: PacketLogFile이 비어 있거나 열 수 없습니다. worldserver.conf를 확인하고 월드 서버를 다시 시작하세요.'),
(35491, 'frFR', 'L''enregistrement des paquets est indisponible : PacketLogFile est vide ou ne peut pas être ouvert. Vérifiez worldserver.conf et redémarrez le worldserver.'),
(35491, 'deDE', 'Paketprotokollierung ist nicht verfügbar: PacketLogFile ist leer oder kann nicht geöffnet werden. Prüft worldserver.conf und startet den Worldserver neu.'),
(35491, 'zhCN', '数据包记录不可用：PacketLogFile 为空或无法打开。请检查 worldserver.conf 并重启 worldserver。'),
(35491, 'zhTW', '封包記錄無法使用：PacketLogFile 為空或無法開啟。請檢查 worldserver.conf 並重新啟動 worldserver。'),
(35491, 'esES', 'El registro de paquetes no está disponible: PacketLogFile está vacío o no se puede abrir. Revisa worldserver.conf y reinicia el worldserver.'),
(35491, 'esMX', 'El registro de paquetes no está disponible: PacketLogFile está vacío o no se puede abrir. Revisa worldserver.conf y reinicia el worldserver.'),
(35491, 'ruRU', 'Запись пакетов недоступна: PacketLogFile не задан или не может быть открыт. Проверьте worldserver.conf и перезапустите worldserver.');
