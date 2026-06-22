-- Insight: the Knowledge-unlock currency (design slice §14.13.1, issue #18).
-- Per-(account, school) NON-tradeable fractional DB point counter -- the deliberate exception to
-- §16.3 (it is not an item, so it can never be traded/mailed/bought; the §1 anti-P2W guarantee holds).
-- Account-scoped with an account-wide DR window (the window_* columns carry the same account-wide
-- snapshot on every row) so the counter cannot be farmed across alts or schools. Reaching the
-- configured unlock threshold writes the permanent `account_brand_knowledge` row via the existing
-- unlock path. One row per (account, school).
CREATE TABLE IF NOT EXISTS `account_insight`
(
    `account` INT UNSIGNED NOT NULL COMMENT 'Account id',
    `school` TINYINT UNSIGNED NOT NULL COMMENT 'BrandId enum value (the branded school)',
    `points` DOUBLE NOT NULL DEFAULT 0 COMMENT 'Fractional Insight toward the unlock threshold',
    `window_start` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the account-wide DR window started (0 = none)',
    `window_units` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'DR-counted kills in the current account-wide window',
    PRIMARY KEY (`account`, `school`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
