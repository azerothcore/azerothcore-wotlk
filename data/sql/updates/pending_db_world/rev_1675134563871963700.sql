DELETE FROM `game_event_creature` WHERE `eventEntry`=13 AND `guid` IN (247200, 247205, 247210, 247215);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
-- Elemental Invasions
(13, 247200), -- Baron Charr
(13, 247205), -- The Windreaver
(13, 247210), -- Princess Tempestria
(13, 247215); -- Avalanchion
