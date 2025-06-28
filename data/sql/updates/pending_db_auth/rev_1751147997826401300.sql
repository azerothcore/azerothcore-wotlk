--
ALTER TABLE `autobroadcast_locale`
    CHANGE COLUMN `text` `text` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `locale`;
