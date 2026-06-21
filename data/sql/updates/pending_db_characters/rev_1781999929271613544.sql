-- Mastery character earned-skill layer (design slice 6, §14).
-- Per-character earned level; the other dual key, effective only when paired with account_mastery.
CREATE TABLE IF NOT EXISTS `character_mastery`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `mastery_id` TINYINT UNSIGNED NOT NULL COMMENT 'MasterySystem enum value (0=Gathering,1=Crafting)',
    `level` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Earned mastery level (0..Branding.Mastery.MaxLevel)',
    PRIMARY KEY (`guid`, `mastery_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
