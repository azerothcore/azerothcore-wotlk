-- DB update 2026_05_24_01 -> 2026_05_24_02
-- acore_string entries for .pet rename command.
DELETE FROM `acore_string` WHERE `entry` IN (35453, 35454);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35453, 'Invalid pet name: {}.', '잘못된 펫 이름입니다: {}.', 'Nom de familier invalide : {}.', 'Ungültiger Begleitername: {}.', '无效的宠物名称: {}。', '無效的寵物名稱：{}。', 'Nombre de mascota no válido: {}.', 'Nombre de mascota no válido: {}.', 'Недопустимое имя питомца: {}.'),
(35454, 'Renamed pet {0} ({1} -> {2}) for player {3} ({4}).', '플레이어 {3} ({4})의 펫 {0}의 이름을 {1}에서 {2}(으)로 변경했습니다.', 'Familier {0} renommé ({1} -> {2}) pour le joueur {3} ({4}).', 'Begleiter {0} umbenannt ({1} -> {2}) für Spieler {3} ({4}).', '已将玩家 {3} ({4}) 的宠物 {0} 重命名 ({1} -> {2})。', '已將玩家 {3} ({4}) 的寵物 {0} 重新命名（{1} -> {2}）。', 'Mascota {0} renombrada ({1} -> {2}) para el jugador {3} ({4}).', 'Mascota {0} renombrada ({1} -> {2}) para el jugador {3} ({4}).', 'Питомец {0} переименован ({1} -> {2}) у игрока {3} ({4}).');
