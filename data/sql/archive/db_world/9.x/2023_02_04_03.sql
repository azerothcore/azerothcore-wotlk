-- DB update 2023_02_04_02 -> 2023_02_04_03
DELETE FROM `game_event_creature` WHERE `eventEntry`=13;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
-- Elemental Invasions
(13, 247200), -- Baron Charr
(13, 247201), -- Blazing Invader
(13, 247202), -- Blazing Invader
(13, 247203), -- Blazing Invader
(13, 247204), -- Blazing Invader
(13, 247205), -- The Windreaver
(13, 247206), -- Whirling Invader
(13, 247207), -- Whirling Invader
(13, 247208), -- Whirling Invader
(13, 247209), -- Whirling Invad
(13, 247210), -- Princess Tempestria
(13, 247211), -- Watery Invader
(13, 247212), -- Watery Invader
(13, 247213), -- Watery Invader
(13, 247214), -- Watery Invader
(13, 247215), -- Avalanchioner
(13, 247216), -- Thundering Invader
(13, 247217), -- Thundering Invader
(13, 247218), -- Thundering Invader
(13, 247219); -- Thundering Invader
