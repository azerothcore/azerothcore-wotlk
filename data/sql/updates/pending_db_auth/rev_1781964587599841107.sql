-- Brand Knowledge: account-wide brand access unlocks (design slice 1, §6).
-- Account-scoped so it gates expression on whichever account currently owns a character (anti-P2W).
CREATE TABLE IF NOT EXISTS `account_brand_knowledge`
(
    `account` INT UNSIGNED NOT NULL COMMENT 'Account id',
    `brand` TINYINT UNSIGNED NOT NULL COMMENT 'BrandId enum value',
    `unlocked_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the brand was unlocked',
    PRIMARY KEY (`account`, `brand`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
