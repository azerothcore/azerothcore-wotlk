-- Mastery per-spec loadout (§14.10 point-buy / §14.11 per-talent-spec allocation, issue #28).
-- The EARNED layer (per-school level + account unlock) lives in character_mastery/account_mastery and
-- is shared across specs. This table is the ALLOCATED layer: a COLLECTION of active (school, tree)
-- mastery cells per (guid, talent-spec slot), each with its archetype and point-buy spend. Multiple
-- rows per (guid, spec) is intended -- v1 caps the active count via Branding.Mastery.MaxActive, but
-- the schema holds N cells with no future rebuild (forward-compat for multi-mastery).
CREATE TABLE IF NOT EXISTS `character_mastery_loadout`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `spec` TINYINT UNSIGNED NOT NULL COMMENT 'Talent-spec slot (0..MAX_TALENT_SPECS-1)',
    `school` TINYINT UNSIGNED NOT NULL COMMENT 'BrandId enum value (damage school of the cell)',
    `tree` TINYINT UNSIGNED NOT NULL COMMENT 'MasteryTree enum value (0=Defensive,1=Offensive,2=Support)',
    `archetype` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Selected proc archetype index (<MaxArchetypesPerCell)',
    `points_ppm` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Point-buy spend on the ppm axis',
    `points_duration` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Point-buy spend on the duration axis',
    `points_magnitude` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Point-buy spend on the magnitude axis',
    `points_reach` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Point-buy spend on the reach axis',
    PRIMARY KEY (`guid`, `spec`, `school`, `tree`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
