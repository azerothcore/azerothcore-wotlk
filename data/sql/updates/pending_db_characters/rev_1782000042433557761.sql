-- Event participation: per-character contribution pacing (§9.3 / §9.3#5). Persists the hourly cap
-- window, daily boundary, and per-EventType daily diminishing-returns counters so pacing survives a
-- relog. One row per character.
CREATE TABLE IF NOT EXISTS `character_event_participation`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `total_points` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Lifetime contribution points (current event scaffold)',
    `points_this_hour` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Points credited in the current hourly cap window',
    `hour_window_start` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the hourly cap window started (0 = none)',
    `day_start` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the daily DR window started (0 = none)',
    `daily_invasion` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'EventType Invasion daily DR counter',
    `daily_resource_surge` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'EventType ResourceSurge daily DR counter',
    `daily_elite_hunt` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'EventType EliteHunt daily DR counter',
    `daily_profession_anomaly` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'EventType ProfessionAnomaly daily DR counter',
    PRIMARY KEY (`guid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
