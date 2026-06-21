-- Account vault: account-bound shared stash (design slice 6, §13).
-- Account-scoped so every character on the account shares one vault (anti-alt-army funnel, §9.3).
-- Deposit friction (VaultTransferCost) is charged on deposit; capacity (VaultCanStore) caps total
-- stored units. Item rows are keyed by (account, item_entry) so stacks merge per account.
CREATE TABLE IF NOT EXISTS `account_vault`
(
    `account` INT UNSIGNED NOT NULL COMMENT 'Account id',
    `item_entry` INT UNSIGNED NOT NULL COMMENT 'Item template entry stored',
    `count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Units of item_entry held in the vault',
    PRIMARY KEY (`account`, `item_entry`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
