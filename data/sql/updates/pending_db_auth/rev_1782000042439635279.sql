-- Account economy ledger: account-wide soft ceiling on economy outputs (crafting mats, currency)
-- per period (§9.3#5 HYBRID decision, §10.3). Account-scoped so an alt-army cannot multiply mat or
-- currency throughput, and the ceiling survives a relog. One row per account.
CREATE TABLE IF NOT EXISTS `account_economy_ledger`
(
    `account` INT UNSIGNED NOT NULL COMMENT 'Account id',
    `materials_this_period` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Crafting mats granted in the current period',
    `currency_this_period` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Currency granted in the current period',
    `period_start` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the ceiling period started (0 = none)',
    PRIMARY KEY (`account`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
