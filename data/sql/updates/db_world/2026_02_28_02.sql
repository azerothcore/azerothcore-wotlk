-- DB update 2026_02_28_01 -> 2026_02_28_02
-- Add lfg cooldown command to the command table
DELETE FROM `command` WHERE `name` IN ('lfg cooldown');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('lfg cooldown', 3, 'Syntax: .lfg cooldown\nClears all LFG dungeon cooldowns for all players.');

-- Add acore_string for cooldown cleared message (English, German, Spanish)
DELETE FROM `acore_string` WHERE `entry` = 11019;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(11019, 'LFG dungeon cooldowns cleared for all players.', NULL, NULL, 'LFG-Dungeon-Abklingzeiten für alle Spieler zurückgesetzt.', NULL, NULL, 'Tiempos de reutilización de mazmorras LFG eliminados para todos los jugadores.', 'Tiempos de reutilización de mazmorras LFG eliminados para todos los jugadores.', NULL);
