-- DB update 2025_02_10_01 -> 2025_02_12_00
DROP TABLE IF EXISTS `arena_season_reward_group`;
CREATE TABLE `arena_season_reward_group` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `arena_season` TINYINT UNSIGNED NOT NULL,
    `criteria_type` ENUM('pct', 'abs') NOT NULL DEFAULT 'pct' COMMENT 'Determines how rankings are evaluated: "pct" - percentage-based (e.g., top 20% of the ladder), "abs" - absolute position-based (e.g., top 10 players).',
    `min_criteria` FLOAT NOT NULL,
    `max_criteria` FLOAT NOT NULL,
    `reward_mail_template_id` INT UNSIGNED,
    `reward_mail_subject` VARCHAR(255),
    `reward_mail_body` TEXT,
    `gold_reward` INT UNSIGNED
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;

-- Season 8
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `criteria_type`, `min_criteria`, `max_criteria`, `reward_mail_template_id`, `reward_mail_subject`, `reward_mail_body`, `gold_reward`) VALUES
(1, 8, 'abs', 1, 1, 0, '', '', 0),
(2, 8, 'pct', 0, 0.5, 287, '', '', 0),
(3, 8, 'pct', 0.5, 3, 0, '', '', 0),
(4, 8, 'pct', 3, 10, 0, '', '', 0),
(5, 8, 'pct', 10, 35, 0, '', '', 0),
-- Season 7
(6, 7, 'abs', 1, 1, 0, '', '', 0),
(7, 7, 'pct', 0, 0.5, 286, '', '', 0),
(8, 7, 'pct', 0.5, 3, 0, '', '', 0),
(9, 7, 'pct', 3, 10, 0, '', '', 0),
(10, 7, 'pct', 10, 35, 0, '', '', 0),
-- Season 6
(11, 6, 'abs', 1, 1, 0, '', '', 0),
(12, 6, 'pct', 0, 0.5, 267, '', '', 0),
(13, 6, 'pct', 0.5, 3, 0, '', '', 0),
(14, 6, 'pct', 3, 10, 0, '', '', 0),
(15, 6, 'pct', 10, 35, 0, '', '', 0),
-- Season 5
(16, 5, 'abs', 1, 1, 0, '', '', 0),
(17, 5, 'pct', 0, 0.5, 266, '', '', 0),
(18, 5, 'pct', 0.5, 3, 0, '', '', 0),
(19, 5, 'pct', 3, 10, 0, '', '', 0),
(20, 5, 'pct', 10, 35, 0, '', '', 0);

DROP TABLE IF EXISTS `arena_season_reward`;
CREATE TABLE `arena_season_reward` (
    `group_id` INT NOT NULL COMMENT 'id from arena_season_reward_group table',
    `type` ENUM('achievement', 'item') NOT NULL DEFAULT 'achievement',
    `entry` INT UNSIGNED NOT NULL COMMENT 'For item type - item entry, for achievement - achevement id.',
    PRIMARY KEY (`group_id`, `type`, `entry`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;

-- Season 8
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (1, 'achievement', 3336);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (2, 'item', 50435);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (2, 'achievement', 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (3, 'achievement', 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (4, 'achievement', 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (5, 'achievement', 2090);
-- Season 7
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (6, 'achievement', 3336);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (7, 'item', 47840);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (7, 'achievement', 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (8, 'achievement', 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (9, 'achievement', 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (10, 'achievement', 2090);
-- Season 6
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (11, 'achievement', 3336);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (12, 'item', 46171);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (12, 'achievement', 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (13, 'achievement', 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (14, 'achievement', 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (15, 'achievement', 2090);
-- Season 5
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (16, 'achievement', 3336);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (17, 'item', 46708);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (17, 'achievement', 2091);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (18, 'achievement', 2092);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (19, 'achievement', 2093);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES (20, 'achievement', 2090);

DELETE FROM `command` WHERE `name` IN ('arena season start', 'arena season reward', 'arena season set state', 'arena season deleteteams');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season start', 3, 'Syntax: .arena season start $season_id\nStarts a new arena season, places the correct vendors, and sets the new season state to IN PROGRESS.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season reward', 3, 'Syntax: .arena season reward $brackets\nBuilds a ladder by combining team brackets and provides rewards from the arena_season_reward table.\nExample usage:\n \n# Combine all brackets, build a ladder, and distribute rewards among them\n.arena season reward all\n \n# Build ladders separately for 2v2, 3v3, and 5v5 brackets so each bracket receives its own rewards\n.arena season reward 2\n.arena season reward 3\n.arena season reward 5\n \n# Combine 2v2 and 3v3 brackets and distribute rewards\n.arena season reward 2,3');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season deleteteams', 3, 'Syntax: .arena season deleteteams\nDeletes ALL arena teams.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena season set state', 3, 'Syntax: .arena season set state $state\nChanges the state for the current season.\nAvailable states:\n 0 - disabled. Players can\'t queue for the arena.\n 1 - in progress. Players can use arena-related functionality.');

DELETE FROM `achievement_reward` WHERE `ID` IN (3336, 2091, 2092, 2093, 2090);
INSERT INTO `achievement_reward` (`ID`, `TitleA`, `TitleH`, `ItemID`, `Sender`, `Subject`, `Body`, `MailTemplateID`) VALUES
(3336, 157, 157, 0, 0, '', '', 0),
(2091, 42, 42, 0, 0, '', '', 0),
(2092, 43, 43, 0, 0, '', '', 0),
(2093, 44, 44, 0, 0, '', '', 0),
(2090, 45, 45, 0, 0, '', '', 0);
