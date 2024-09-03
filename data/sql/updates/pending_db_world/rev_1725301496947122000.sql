DROP TABLE IF EXISTS `arena_season_reward_group`;
CREATE TABLE `arena_season_reward_group` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `arena_season` TINYINT UNSIGNED NOT NULL,
    `min_pct_criteria` FLOAT NOT NULL,
    `max_pct_criteria` FLOAT NOT NULL,
    `reward_mail_template_id` INT UNSIGNED NOT NULL
);

-- Season 8
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (1, 8, 0, 0.5, 287);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (2, 8, 0.5, 3, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (3, 8, 3, 10, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (4, 8, 10, 35, 0);
-- Season 7
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (5, 7, 0, 0.5, 286);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (6, 7, 0.5, 3, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (7, 7, 3, 10, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (8, 7, 10, 35, 0);
-- Season 6
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (9, 6, 0, 0.5, 267);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (10, 6, 0.5, 3, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (11, 6, 3, 10, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (12, 6, 10, 35, 0);
-- Season 5
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (13, 5, 0, 0.5, 266);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (14, 5, 0.5, 3, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (15, 5, 3, 10, 0);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `min_pct_criteria`, `max_pct_criteria`, `reward_mail_template_id`) VALUES (16, 5, 10, 35, 0);

DROP TABLE IF EXISTS `arena_season_reward`;
CREATE TABLE `arena_season_reward` (
    `group_id` INT NOT NULL COMMENT 'id from arena_season_reward_group table',
    `type` TINYINT UNSIGNED COMMENT 'Supported 2 types: 1 - item; 2 - achievement.',
    `entry` INT UNSIGNED NOT NULL COMMENT 'For item type - item entry, for achievement - achevement id.',
    PRIMARY KEY (`group_id`, `type`, `entry`)
);

-- Season 8
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (1, 1, 50435);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (1, 2, 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (2, 2, 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (3, 2, 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (4, 2, 2090);
-- Season 7
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (5, 1, 47840);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (5, 2, 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (6, 2, 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (7, 2, 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (8, 2, 2090);
-- Season 6
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (9, 1, 46171);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (9, 2, 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (10, 2, 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (11, 2, 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (12, 2, 2090);
-- Season 5
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (13, 1, 46708);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (13, 2, 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (14, 2, 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (15, 2, 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (16, 2, 2090);


INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season start', 3, 'Syntax: .arena season start $season_id\nStarts a new arena season, places the correct vendors, and sets the new season state to IN PROGRESS.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season complete', 3, 'Syntax: .arena season complete\nCompletes the current arena season by giving rewards to the arena teams and DELETING ALL arena teams.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season set state', 3, 'Syntax: .arena season set state $state\nChanges the state for the current season.\nAvailable states:\n 0 - disabled. Players can\'t queue for the arena.\n 1 - in progress. Players can use arena-related functionality.');
