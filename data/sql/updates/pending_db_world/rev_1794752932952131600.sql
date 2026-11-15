DELETE FROM `command` WHERE `name` = 'instance bind';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('instance bind', 2, 'Syntax: .instance bind [$instanceId] [$playername]\nBinds the selected player, yourself, or the named character, online or offline, to instance $instanceId. Without an instance id, binds to the instance you are in. Fails if the character is already bound to that map and difficulty. From the console both arguments are required.');

DELETE FROM `acore_string` WHERE `entry` IN (35486, 35487, 35488);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35486, 'Instance {} not found.'),
(35487, '{} is already bound to instance {} (map {}: {}, difficulty {}).'),
(35488, '{} has been bound to instance {} (map {}: {}, difficulty {}).');

DELETE FROM `acore_string_locale` WHERE `entry` IN (35486, 35487, 35488);
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`) VALUES
(35486, 'koKR', '인스턴스 {}을(를) 찾을 수 없습니다.'),
(35486, 'frFR', 'Instance {} introuvable.'),
(35486, 'deDE', 'Instanz {} nicht gefunden.'),
(35486, 'zhCN', '未找到副本 {}。'),
(35486, 'zhTW', '找不到副本 {}。'),
(35486, 'esES', 'No se encontró la instancia {}.'),
(35486, 'esMX', 'No se encontró la instancia {}.'),
(35486, 'ruRU', 'Подземелье {} не найдено.'),
(35487, 'koKR', '{}: 이미 인스턴스 {}에 귀속되어 있습니다 (지도 {}: {}, 난이도 {}).'),
(35487, 'frFR', '{} est déjà lié à l''instance {} (carte {} : {}, difficulté {}).'),
(35487, 'deDE', '{} ist bereits an Instanz {} gebunden (Karte {}: {}, Schwierigkeitsgrad {}).'),
(35487, 'zhCN', '{} 已经绑定到副本 {}（地图 {}：{}，难度 {}）。'),
(35487, 'zhTW', '{} 已經綁定到副本 {}（地圖 {}：{}，難度 {}）。'),
(35487, 'esES', '{} ya está vinculado a la instancia {} (mapa {}: {}, dificultad {}).'),
(35487, 'esMX', '{} ya está vinculado a la instancia {} (mapa {}: {}, dificultad {}).'),
(35487, 'ruRU', '{} уже привязан к подземелью {} (карта {}: {}, сложность {}).'),
(35488, 'koKR', '{}: 인스턴스 {}에 귀속되었습니다 (지도 {}: {}, 난이도 {}).'),
(35488, 'frFR', '{} a été lié à l''instance {} (carte {} : {}, difficulté {}).'),
(35488, 'deDE', '{} wurde an Instanz {} gebunden (Karte {}: {}, Schwierigkeitsgrad {}).'),
(35488, 'zhCN', '已将 {} 绑定到副本 {}（地图 {}：{}，难度 {}）。'),
(35488, 'zhTW', '已將 {} 綁定到副本 {}（地圖 {}：{}，難度 {}）。'),
(35488, 'esES', '{} ha sido vinculado a la instancia {} (mapa {}: {}, dificultad {}).'),
(35488, 'esMX', '{} ha sido vinculado a la instancia {} (mapa {}: {}, dificultad {}).'),
(35488, 'ruRU', '{} привязан к подземелью {} (карта {}: {}, сложность {}).');
