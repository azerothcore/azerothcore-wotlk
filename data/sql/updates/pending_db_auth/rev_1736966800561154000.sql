--
-- Changes the Length of `username` from 32 to 17 characters as it the client limit.
ALTER TABLE `account` CHANGE COLUMN `username` `username` VARCHAR(17) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci' AFTER `id`;
