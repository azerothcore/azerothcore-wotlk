-- Active-school switch fee: per-character recent-switch counter for the escalating gold tuition
-- (design slice §14.13.2, issue #19). One row per character; the counter decays after
-- Branding.Selection.SwitchDecayDays (decay applied in the adapter on read).
CREATE TABLE IF NOT EXISTS `character_branding_switch`
(
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character low GUID',
    `recent_switches` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Un-decayed recent switch count (escalates tuition)',
    `last_switch_unix` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time of the last active-school switch',
    PRIMARY KEY (`guid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
