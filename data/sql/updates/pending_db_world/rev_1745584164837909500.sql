-- sync darkmoon faire starting times with in-game calendar
-- Darkmoon Faire (Terokkar Forest)
UPDATE `game_event` SET `start_time` = '2025-05-04 00:01:00' WHERE `eventEntry` = 3;
-- Darkmoon Faire (Elwynn Forest)
UPDATE `game_event` SET `start_time` = '2025-06-01 00:01:00' WHERE `eventEntry` = 4;
-- Darkmoon Faire (Mulgore)
UPDATE `game_event` SET `start_time` = '2025-07-06 00:01:00' WHERE `eventEntry` = 5;
