-- DB update 2026_03_03_01 -> 2026_03_03_02
-- Add acore_string entries for reset all honor/arena messages
DELETE FROM `acore_string` WHERE `entry` IN (5118, 5119);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(5118, 'Honor points have been reset for all players.', NULL, NULL, 'Ehrenpunkte wurden für alle Spieler zurückgesetzt.', '所有玩家的荣誉点数已被重置。', NULL, 'Los puntos de honor se han restablecido para todos los jugadores.', 'Los puntos de honor se han restablecido para todos los jugadores.', NULL),
(5119, 'Arena points have been reset for all players.', NULL, NULL, 'Arenapunkte wurden für alle Spieler zurückgesetzt.', '所有玩家的竞技场点数已被重置。', NULL, 'Los puntos de arena se han restablecido para todos los jugadores.', 'Los puntos de arena se han restablecido para todos los jugadores.', NULL);

-- Update reset all command description to include honor and arena
UPDATE `command` SET `help` = 'Syntax: .reset all spells\r\n\r\nSyntax: .reset all talents\r\n\r\nSyntax: .reset all honor\r\n\r\nSyntax: .reset all arena\r\n\r\nRequests a reset of spells or talents (including talents for all of a character\'s pets, if any) at the next login for each existing character, or immediately resets honor points or arena points for all characters.' WHERE `name` = 'reset all';
