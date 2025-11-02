DROP TABLE IF EXISTS `character_battleground_rating`;
CREATE TABLE `character_battleground_rating` (
  `Guid` INT UNSIGNED NOT NULL COMMENT 'Character GUID',
  `Rating` FLOAT NOT NULL DEFAULT 1500 COMMENT 'Glicko-2 rating',
  `RatingDeviation` FLOAT NOT NULL DEFAULT 200 COMMENT 'Rating deviation (RD)',
  `Volatility` FLOAT NOT NULL DEFAULT 0.06 COMMENT 'Rating volatility',
  `MatchesPlayed` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG matches',
  `Wins` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG wins',
  `Losses` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total BG losses',
  `LastUpdate` TIMESTAMP NULL DEFAULT NULL COMMENT 'Last rating update',
  PRIMARY KEY (`Guid`),
  CONSTRAINT `character_battleground_rating_chk_1` CHECK (`Guid` >= 0),
  CONSTRAINT `character_battleground_rating_chk_2` CHECK (`MatchesPlayed` >= 0),
  CONSTRAINT `character_battleground_rating_chk_3` CHECK (`Wins` >= 0),
  CONSTRAINT `character_battleground_rating_chk_4` CHECK (`Losses` >= 0)
)
COMMENT = 'Battleground MMR data for each character'
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
ROW_FORMAT = DEFAULT
;

DROP TABLE IF EXISTS `character_battleground_rating_history`;
CREATE TABLE `character_battleground_rating_history` (
  `Id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Guid` INT UNSIGNED NOT NULL COMMENT 'Character GUID',
  `OldRating` FLOAT NOT NULL,
  `NewRating` FLOAT NOT NULL,
  `OldRatingDeviation` FLOAT NOT NULL,
  `NewRatingDeviation` FLOAT NOT NULL,
  `OldVolatility` FLOAT NOT NULL,
  `NewVolatility` FLOAT NOT NULL,
  `MatchResult` TINYINT NOT NULL COMMENT '1=win, 0=loss',
  `Timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `idx_guid` (`Guid`),
  KEY `idx_timestamp` (`Timestamp`),
  CONSTRAINT `character_battleground_rating_history_chk_1` CHECK (`Id` >= 0),
  CONSTRAINT `character_battleground_rating_history_chk_2` CHECK (`Guid` >= 0),
  CONSTRAINT `character_battleground_rating_history_chk_3` CHECK (`MatchResult` IN (0, 1))
)
COMMENT = 'Tracks BG rating changes over time'
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
ROW_FORMAT = DEFAULT
;
