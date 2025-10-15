-- Add MMR columns to characters table
ALTER TABLE `characters` 
ADD COLUMN `bg_rating` FLOAT NOT NULL DEFAULT 1500 COMMENT 'Glicko-2 rating',
ADD COLUMN `bg_rating_deviation` FLOAT NOT NULL DEFAULT 200 COMMENT 'Rating deviation (RD)',
ADD COLUMN `bg_volatility` FLOAT NOT NULL DEFAULT 0.06 COMMENT 'Rating volatility',
ADD COLUMN `bg_gear_score` FLOAT NOT NULL DEFAULT 0 COMMENT 'Cached average item level',
ADD COLUMN `bg_matches_played` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG matches',
ADD COLUMN `bg_wins` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG wins',
ADD COLUMN `bg_losses` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG losses',
ADD COLUMN `bg_last_update` TIMESTAMP NULL DEFAULT NULL COMMENT 'Last rating update';

-- Add index for performance
ALTER TABLE `characters` 
ADD INDEX `idx_bg_rating` (`bg_rating`);

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
COMMENT='Tracks BG rating changes';
