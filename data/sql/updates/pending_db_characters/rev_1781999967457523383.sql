-- Active brand + proc loadout selection (design §7.9, issue #02): per-character active brand and
-- selected proc archetype. One row per character; validated by the module before persistence.
CREATE TABLE IF NOT EXISTS `character_brand_loadout`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `active_brand` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'BrandId enum value',
    `proc_archetype` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Selected proc archetype index',
    PRIMARY KEY (`guid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
