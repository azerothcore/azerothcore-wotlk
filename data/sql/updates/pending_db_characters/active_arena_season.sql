DROP TABLE IF EXISTS `active_arena_season`;
CREATE TABLE `active_arena_season` (
    `season_id` TINYINT UNSIGNED NOT NULL,
    `season_state` TINYINT UNSIGNED NOT NULL COMMENT 'Supported 2 states: 0 - disabled; 1 - in progress.'
);

INSERT INTO `active_arena_season` (`season_id`, `season_state`) VALUES (8, 1);
