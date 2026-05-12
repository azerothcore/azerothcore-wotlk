-- mod-nostrum-hardcore SQL schema
-- Applied by module on OnStartup via CREATE TABLE IF NOT EXISTS
-- This file is kept for reference and manual installation if needed.

CREATE TABLE IF NOT EXISTS `mod_nostrum_hardcore` (
    `guid`           INT UNSIGNED     NOT NULL,
    `account_id`     INT UNSIGNED     NOT NULL,
    `character_name` VARCHAR(12)      NOT NULL,
    `race`           TINYINT UNSIGNED NOT NULL,
    `class`          TINYINT UNSIGNED NOT NULL,
    `mode`           TINYINT UNSIGNED NOT NULL COMMENT '1=Hardcore 2=SelfFound',
    `status`         TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '1=Active 2=Fallen 3=Removed',
    `level_reached`  TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `played_time`    INT UNSIGNED     NOT NULL DEFAULT 0,
    `enabled_at`     TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `death_at`       TIMESTAMP        NULL DEFAULT NULL,
    `death_zone`     INT UNSIGNED     NULL DEFAULT NULL,
    `death_map`      INT UNSIGNED     NULL DEFAULT NULL,
    `death_killer`   VARCHAR(128)     NULL DEFAULT NULL,
    `revived_by_gm`  TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `removed_by_gm`  TINYINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`guid`),
    INDEX `idx_hc_status_level` (`status`, `level_reached`),
    INDEX `idx_hc_mode_status_level` (`mode`, `status`, `level_reached`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `mod_nostrum_hardcore_flags` (
    `guid`                  INT UNSIGNED     NOT NULL,
    `death_count`           INT UNSIGNED     NOT NULL DEFAULT 0,
    `has_traded`            TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `has_sent_mail`         TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `has_received_mail`     TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `has_used_auction_house`TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `has_grouped`            TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `has_joined_guild`       TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `updated_at`            TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `mod_nostrum_hardcore_milestones` (
    `guid`            INT UNSIGNED     NOT NULL,
    `milestone_level` TINYINT UNSIGNED NOT NULL,
    `announced_at`    TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`guid`, `milestone_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
