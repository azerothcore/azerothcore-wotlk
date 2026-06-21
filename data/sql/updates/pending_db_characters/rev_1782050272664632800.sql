ALTER TABLE `mail_server_template`
    ADD COLUMN `senderEntry` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `id` COMMENT 'Entry from creature_template. 0 for default "Customer Support" sender.';
