-- Ambient event schedule (design slice 9, §9.1). Each row auto-cycles an event in a zone:
-- active for `active_seconds`, then `cooldown_seconds`, repeating. Driven by EventScheduler.
CREATE TABLE IF NOT EXISTS `branding_event_def`
(
    `zone_id` INT UNSIGNED NOT NULL,
    `event_type` TINYINT UNSIGNED NOT NULL COMMENT '0=Invasion,1=ResourceSurge,2=EliteHunt,3=ProfessionAnomaly',
    `goal` INT UNSIGNED NOT NULL DEFAULT 100 COMMENT 'Containment goal (contribution points)',
    `active_seconds` INT UNSIGNED NOT NULL DEFAULT 1800,
    `cooldown_seconds` INT UNSIGNED NOT NULL DEFAULT 3600,
    PRIMARY KEY (`zone_id`, `event_type`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DELETE FROM `branding_event_def` WHERE `zone_id` = 12 AND `event_type` = 0;
INSERT INTO `branding_event_def` (`zone_id`, `event_type`, `goal`, `active_seconds`, `cooldown_seconds`) VALUES
(12, 0, 100, 1800, 3600);
