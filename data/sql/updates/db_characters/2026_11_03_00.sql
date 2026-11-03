-- DB update 2026_10_31_00 -> 2026_11_03_00
--
ALTER TABLE `recovery_item`
    ADD COLUMN `ItemGuid` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'item_instance guid of the lost item' AFTER `ItemEntry`,
    ADD COLUMN `Source` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 destroyed, 1 vendored, 2 disenchanted' AFTER `Count`,
    ADD COLUMN `Money` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Copper paid by the vendor' AFTER `Source`,
    ADD COLUMN `RandomPropertyId` INT NOT NULL DEFAULT 0 AFTER `Money`,
    ADD COLUMN `Enchantments` VARCHAR(512) NOT NULL DEFAULT '' COMMENT 'Same format as item_instance.enchantments' AFTER `RandomPropertyId`,
    ADD COLUMN `CreatorGuid` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `Enchantments`,
    ADD COLUMN `Bound` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `CreatorGuid`;

DROP TABLE IF EXISTS `recovery_item_loot`;
CREATE TABLE `recovery_item_loot` (
    `RecoveryId` INT UNSIGNED NOT NULL,
    `ItemEntry` INT UNSIGNED NOT NULL,
    `Count` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`RecoveryId`, `ItemEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Materials looted from disenchanted recovery_item rows';
