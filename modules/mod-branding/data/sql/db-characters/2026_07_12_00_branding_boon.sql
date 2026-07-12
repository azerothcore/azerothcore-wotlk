-- mod-branding Branding Boon (§2.7, issues #81/#83): per-character selected economy-boon axis.
-- Each character selects ONE raid-wide boon axis (0 = None, 1 = Xp, 2 = Drop, 3 = Gold); the axis
-- drives the raid-wide multiplier resolved in ScalingMgr::BoonMultiplier. Re-selection is charged
-- elsewhere (Insight, §18); this table only stores the current choice. InnoDB, 4-space, trailing
-- newline (codestyle-sql).

CREATE TABLE IF NOT EXISTS `character_branding_boon`
(
    `guid` INT UNSIGNED     NOT NULL,
    `axis` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`guid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
