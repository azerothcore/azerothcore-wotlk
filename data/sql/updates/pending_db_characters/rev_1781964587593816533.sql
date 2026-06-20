-- Brand Proficiency: per-character earned proficiency (design slice 1, §6/§7).
CREATE TABLE IF NOT EXISTS `character_branding`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `brand` TINYINT UNSIGNED NOT NULL COMMENT 'BrandId enum value',
    `total_xp` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `recent_window` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Diminishing-returns accumulator',
    `window_start` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the DR window started',
    PRIMARY KEY (`guid`, `brand`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
