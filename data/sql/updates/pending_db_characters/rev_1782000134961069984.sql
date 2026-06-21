-- Allegiance: per-character soft ideological allegiance (§12). Influences reward efficiency, not access.
CREATE TABLE IF NOT EXISTS `character_allegiance`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `allegiance` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Allegiance enum value (0 = None)',
    PRIMARY KEY (`guid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
