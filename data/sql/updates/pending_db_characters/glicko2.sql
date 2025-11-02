CREATE TABLE `character_battleground_rating` (
  `guid` INT UNSIGNED NOT NULL COMMENT 'Character GUID',
  `rating` FLOAT NOT NULL DEFAULT 1500 COMMENT 'Glicko-2 rating',
  `rating_deviation` FLOAT NOT NULL DEFAULT 200 COMMENT 'Rating deviation (RD)',
  `volatility` FLOAT NOT NULL DEFAULT 0.06 COMMENT 'Rating volatility',
  `matches_played` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG matches',
  `wins` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG wins',
  `losses` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG losses',
  `last_update` TIMESTAMP NULL DEFAULT NULL COMMENT 'Last rating update',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Battleground MMR data for each character';

-- Create rating history table
CREATE TABLE `character_battleground_rating_history` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `guid` INT UNSIGNED NOT NULL COMMENT 'Character GUID',
  `old_rating` FLOAT NOT NULL,
  `new_rating` FLOAT NOT NULL,
  `old_rd` FLOAT NOT NULL,
  `new_rd` FLOAT NOT NULL,
  `old_volatility` FLOAT NOT NULL,
  `new_volatility` FLOAT NOT NULL,
  `match_result` TINYINT NOT NULL COMMENT '1=win, 0=loss',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_guid` (`guid`),
  KEY `idx_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tracks BG rating changes over time';
