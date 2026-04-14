-- Update reserved_name and profanity_name table structure
ALTER TABLE `reserved_name`
    DROP PRIMARY KEY,
    ADD COLUMN `id` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
    ADD COLUMN `flags` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `name`,
    ADD COLUMN `security` TINYINT NOT NULL DEFAULT 0 AFTER `flags`,
    ADD COLUMN `comment` VARCHAR(255) NOT NULL DEFAULT '' AFTER `security`,
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `uk_reserved_name` (`name`, `flags`, `security`);

ALTER TABLE `profanity_name`
    DROP PRIMARY KEY,
    ADD COLUMN `id` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
    ADD COLUMN `flags` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `name`,
    ADD COLUMN `locale` TINYINT NOT NULL DEFAULT -1 AFTER `flags`,
    ADD COLUMN `comment` VARCHAR(255) NOT NULL DEFAULT '' AFTER `locale`,
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `uk_profanity_name` (`name`, `flags`, `locale`);
