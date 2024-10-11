-- DB update 2022_12_06_44 -> 2022_12_06_45
-- 
DELETE FROM `game_event` WHERE `eventEntry` IN (75, 76) AND `description` LIKE '%Arena Season%';
INSERT INTO `game_event` (`eventEntry`, `description`) VALUES
(75, 'Arena Season 1'),
(76, 'Arena Season 2');
DELETE FROM `game_event_arena_seasons` WHERE `eventEntry` IN (75, 76) AND `season` IN (1, 2);
INSERT INTO `game_event_arena_seasons` (`eventEntry`, `season`) VALUES
(75, 1),
(76, 2);
