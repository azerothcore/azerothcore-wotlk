-- DB update 2026_03_11_02 -> 2026_03_12_00
-- .bf queue command and display strings
-- Syntax: .bf queue #battleid
-- Displays players in queue, invited, and actively in war for a given battlefield.
--
-- Output: 2 team headers + one line per player:
--   1. Header     (5120 or 5121)  — args: battleId, timerSecs
--   2. Team hdr   (5122) x2      — args: teamName, queueCount, invitedCount, warCount
--   3. Per-player (5123-5125)    — queue: name | invited: name, secsLeft | war: name

-- ----------------------------------------------------------------
-- command table
-- ----------------------------------------------------------------
DELETE FROM `command` WHERE `name` = 'bf queue';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('bf queue', 2, 'Syntax: .bf queue #battleid\r\nDisplays all players currently in queue, invited, or actively in war for the specified battlefield.\r\n#battleid: the battle ID (e.g. 1 for Wintergrasp).');

-- ----------------------------------------------------------------
-- acore_string  (entries 5120–5125)
-- ----------------------------------------------------------------
DELETE FROM `acore_string` WHERE `entry` BETWEEN 5120 AND 5125;
INSERT INTO `acore_string`
    (`entry`, `content_default`,
     `locale_koKR`, `locale_frFR`, `locale_deDE`,
     `locale_zhCN`, `locale_zhTW`,
     `locale_esES`, `locale_esMX`, `locale_ruRU`)
VALUES
-- 5120 : header – war in progress   args: battleId, timerSecs
(5120,
 'Battlefield [{}] | WAR IN PROGRESS | Timer: {}s',
 '전장 [{}] | 전투 진행 중 | 타이머: {}초',
 'Champ de bataille [{}] | GUERRE EN COURS | Minuterie : {}s',
 'Schlachtfeld [{}] | KRIEG LÄUFT | Timer: {}s',
 '战场 [{}] | 战斗进行中 | 计时器: {}秒',
 '戰場 [{}] | 戰鬥進行中 | 計時器: {}秒',
 'Campo de batalla [{}] | GUERRA EN CURSO | Temporizador: {}s',
 'Campo de batalla [{}] | GUERRA EN CURSO | Temporizador: {}s',
 'Поле боя [{}] | ВОЙНА ИДЁТ | Таймер: {}с'),

-- 5121 : header – waiting for battle   args: battleId, timerSecs
(5121,
 'Battlefield [{}] | Waiting for battle | Timer: {}s',
 '전장 [{}] | 전투 대기 중 | 타이머: {}초',
 'Champ de bataille [{}] | En attente de bataille | Minuterie : {}s',
 'Schlachtfeld [{}] | Warten auf die Schlacht | Timer: {}s',
 '战场 [{}] | 等待战斗 | 计时器: {}秒',
 '戰場 [{}] | 等待戰鬥 | 計時器: {}秒',
 'Campo de batalla [{}] | Esperando la batalla | Temporizador: {}s',
 'Campo de batalla [{}] | Esperando la batalla | Temporizador: {}s',
 'Поле боя [{}] | Ожидание битвы | Таймер: {}с'),

-- 5122 : team header   args: teamName, queueCount, invitedCount, warCount
(5122,
 '=== {} | Queue: {} | Invited: {} | War: {} ===',
 '=== {} | 대기열: {} | 초대됨: {} | 전투 중: {} ===',
 '=== {} | File : {} | Invités : {} | En guerre : {} ===',
 '=== {} | Warteschlange: {} | Eingeladen: {} | Im Krieg: {} ===',
 '=== {} | 队列: {} | 已邀请: {} | 战斗中: {} ===',
 '=== {} | 佇列: {} | 已邀請: {} | 戰鬥中: {} ===',
 '=== {} | Cola: {} | Invitados: {} | En guerra: {} ===',
 '=== {} | Cola: {} | Invitados: {} | En guerra: {} ===',
 '=== {} | Очередь: {} | Приглашённые: {} | В бою: {} ==='),

-- 5123 : player in queue   args: playerName
(5123,
 '  [Q] {}',
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

-- 5124 : player invited   args: playerName, secsLeft
(5124,
 '  [I] {} ({}s)',
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

-- 5125 : player in war   args: playerName
(5125,
 '  [W] {}',
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
