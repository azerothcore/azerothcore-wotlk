-- DB update 2025_02_16_01 -> 2025_07_03_00
--
ALTER TABLE `autobroadcast_locale`
    CHANGE COLUMN `text` `text` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `locale`;
