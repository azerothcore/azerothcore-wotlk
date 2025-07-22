--
ALTER TABLE `account`
    ADD COLUMN `flags` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `expansion`;
