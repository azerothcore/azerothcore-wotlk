-- DB update 2026_06_01_00 -> 2026_06_24_00
ALTER TABLE `mail_server_template`
    ADD COLUMN `senderEntry` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entry from creature_template. 0 for default "Customer Support" sender.' AFTER `id`;
