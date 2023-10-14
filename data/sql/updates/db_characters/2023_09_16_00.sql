-- DB update 2023_05_23_00 -> 2023_09_16_00
--
ALTER TABLE `profanity_name`
    CHANGE COLUMN `name` `name` VARCHAR(12) NOT NULL COLLATE 'utf8mb4_bin' FIRST;

ALTER TABLE `reserved_name`
    CHANGE COLUMN `name` `name` VARCHAR(12) NOT NULL COLLATE 'utf8mb4_bin' FIRST;
