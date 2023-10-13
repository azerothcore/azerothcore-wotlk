DROP TABLE IF EXISTS `acore_world`.`instance_difficulty_multiplier`;

CREATE TABLE `acore_world`.`instance_difficulty_multiplier` (
  `mapId` smallint unsigned NOT NULL,
  `difficultyId` smallint unsigned NOT NULL,
  `healthMultiplier` float unsigned NOT NULL DEFAULT 1.0,
  `damageMultiplier` float unsigned NOT NULL DEFAULT 1.0,
  PRIMARY KEY (`mapId`, `difficultyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;