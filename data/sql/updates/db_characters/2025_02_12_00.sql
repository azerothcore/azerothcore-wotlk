-- DB update 2025_01_31_00 -> 2025_02_12_00
DROP TABLE IF EXISTS `active_arena_season`;
CREATE TABLE `active_arena_season` (
    `season_id` TINYINT UNSIGNED NOT NULL,
    `season_state` TINYINT UNSIGNED NOT NULL COMMENT 'Supported 2 states: 0 - disabled; 1 - in progress.'
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;

INSERT INTO `active_arena_season` (`season_id`, `season_state`) VALUES (8, 1);
