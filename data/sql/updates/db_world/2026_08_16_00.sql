-- DB update 2026_08_15_13 -> 2026_08_16_00
DELETE FROM `command` WHERE `name` = 'account info';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('account info', 2, 'Syntax: .account info [$account]\nDisplays account level information for $account, given either as an account name or an account id. Defaults to the account of the selected player, or your own account when nothing is selected.');

DELETE FROM `acore_string` WHERE `entry` IN (35471, 35472, 35473, 35474, 35475, 35476, 35477, 35478, 35479);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35471, '| Created: {}', '| 생성일: {}', '| Créé le: {}', '| Erstellt: {}', '| 创建时间: {}', '| 建立時間: {}', '| Creada: {}', '| Creada: {}', '| Создан: {}'),
(35472, '| Expansion: {}', '| 확장팩: {}', '| Extension: {}', '| Erweiterung: {}', '| 资料片: {}', '| 資料片: {}', '| Expansión: {}', '| Expansión: {}', '| Дополнение: {}'),
(35473, '| Locked to country: {}', '| 국가 잠금: {}', '| Verrouillé au pays: {}', '| Gesperrt auf Land: {}', '| 锁定国家: {}', '| 鎖定國家: {}', '| Bloqueada al país: {}', '| Bloqueada al país: {}', '| Привязан к стране: {}'),
(35474, '|-- Banned: (Reason: {}, Time: {}, By: {})', '|-- 차단됨: (사유: {}, 기간: {}, 처리자: {})', '|-- Banni: (Raison: {}, Temps: {}, Par: {})', '|-- Gesperrt: (Grund: {}, Zeit: {}, Von: {})', '|-- 封禁: (原因: {}, 时间: {}, 操作者: {})', '|-- 封禁: (原因: {}, 時間: {}, 操作者: {})', '|-- Baneado: (Razón: {}, Tiempo: {}, Por: {})', '|-- Baneado: (Razón: {}, Tiempo: {}, Por: {})', '|-- Заблокирован: (Причина: {}, Время: {}, Кем: {})'),
(35475, '| Characters on this realm: {}', '| 이 서버의 캐릭터: {}', '| Personnages sur ce royaume: {}', '| Charaktere auf diesem Realm: {}', '| 该服务器上的角色: {}', '| 該伺服器上的角色: {}', '| Personajes en este reino: {}', '| Personajes en este reino: {}', '| Персонажи в этом мире: {}'),
(35476, '|-- {}{} (GUID: {}) - Level {} {} {}', '|-- {}{} (GUID: {}) - 레벨 {} {} {}', '|-- {}{} (GUID: {}) - Niveau {} {} {}', '|-- {}{} (GUID: {}) - Level {} {} {}', '|-- {}{} (GUID: {}) - 等级 {} {} {}', '|-- {}{} (GUID: {}) - 等級 {} {} {}', '|-- {}{} (GUID: {}) - Nivel {} {} {}', '|-- {}{} (GUID: {}) - Nivel {} {} {}', '|-- {}{} (GUID: {}) - Уровень {} {} {}'),
(35477, '| No characters on this realm.', '| 이 서버에 캐릭터가 없습니다.', '| Aucun personnage sur ce royaume.', '| Keine Charaktere auf diesem Realm.', '| 该服务器上没有角色。', '| 該伺服器上沒有角色。', '| Sin personajes en este reino.', '| Sin personajes en este reino.', '| Нет персонажей в этом мире.'),
(35478, '| Current IP: {}', '| 현재 IP: {}', '| IP actuelle: {}', '| Aktuelle IP: {}', '| 当前 IP: {}', '| 目前 IP: {}', '| IP actual: {}', '| IP actual: {}', '| Текущий IP: {}'),
(35479, ' (offline)', ' (오프라인)', ' (hors ligne)', ' (offline)', ' (离线)', ' (離線)', ' (sin conexión)', ' (sin conexión)', ' (не в сети)');
