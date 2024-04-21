-- Fireworks Spectacular
DELETE FROM `game_event` WHERE `eventEntry` = 72;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(72, '2024-07-04 06:00:00', '2030-12-31 12:00:00', 525600, 1080, 62, 0, 'Fireworks Spectacular', 0, 2);
