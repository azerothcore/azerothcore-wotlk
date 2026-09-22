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
