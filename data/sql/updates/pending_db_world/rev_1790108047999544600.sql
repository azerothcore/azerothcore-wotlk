--
-- Add `game_event_locale` for localized game-event descriptions.
-- Mirrors the other *_locale tables. Read by GameEventMgr::LoadEventLocales(); the event-start
-- announcement (LANG_EVENTMESSAGE) is then sent to each player in their own client locale.
-- enUS uses the base `game_event`.`description` (no row required here).
--
CREATE TABLE IF NOT EXISTS `game_event_locale` (
    `eventEntry` tinyint unsigned NOT NULL DEFAULT '0',
    `locale` varchar(4) NOT NULL,
    `description` text,
    PRIMARY KEY (`eventEntry`, `locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Seed deDE game-event descriptions (real holidays).
-- German strings extracted from a 3.3.5a client's DBFilesClient\HolidayNames.dbc (locale deDE).
-- Only deDE is seeded: a WotLK client's DBCs carry strings for that client's own locale only,
-- so other locales must be extracted from a client of that locale. enUS uses the base
-- `game_event`.`description` and needs no row here.
--
DELETE FROM `game_event_locale` WHERE `eventEntry` IN (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 24, 26, 50, 51, 72) AND `locale` = 'deDE';
INSERT INTO `game_event_locale` (`eventEntry`, `locale`, `description`) VALUES
(1, 'deDE', 'Sonnenwendfest'),
(2, 'deDE', 'Winterhauchfest'),
(3, 'deDE', 'Dunkelmond-Jahrmarkt'),
(4, 'deDE', 'Dunkelmond-Jahrmarkt'),
(5, 'deDE', 'Dunkelmond-Jahrmarkt'),
(7, 'deDE', 'Mondfest'),
(8, 'deDE', 'Liebe liegt in der Luft'),
(9, 'deDE', 'Nobelgartenfest'),
(10, 'deDE', 'Kinderwoche'),
(11, 'deDE', 'Erntedankfest'),
(12, 'deDE', 'Schlotternächte'),
(24, 'deDE', 'Braufest'),
(26, 'deDE', 'Pilgerfreudenfest'),
(50, 'deDE', 'Piratentag'),
(51, 'deDE', 'Tag der Toten'),
(72, 'deDE', 'Feuerwerksspektakel');
