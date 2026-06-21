-- Item branding state per item (design slice 7, §7.9). Keyed by item GUID; travels with the item
-- (tradeable), but is inert without the current account's Brand Knowledge (anti-P2W).
CREATE TABLE IF NOT EXISTS `item_branding`
(
    `item_guid` INT UNSIGNED NOT NULL COMMENT 'Item low GUID',
    `brand` TINYINT UNSIGNED NOT NULL COMMENT 'BrandId enum value',
    `step` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `level_in_step` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`item_guid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
