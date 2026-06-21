-- mod-branding 8.4: per-character dedupe for world-spawned discoverables. One row per
-- (character, discovered gameobject entry); presence means the reward was already granted.
CREATE TABLE IF NOT EXISTS `character_branding_discovery`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'character low GUID',
    `object_entry` INT UNSIGNED NOT NULL COMMENT 'gameobject_template.entry of the discoverable',
    `discovered_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'unix time of first interact',
    PRIMARY KEY (`guid`, `object_entry`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'mod-branding world-discovery dedupe';
