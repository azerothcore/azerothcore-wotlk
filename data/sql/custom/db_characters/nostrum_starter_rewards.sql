-- mod-nostrum-starter SQL schema
-- Applied automatically on server startup via CREATE TABLE IF NOT EXISTS.
-- This file is kept for reference and manual installation if needed.

CREATE TABLE IF NOT EXISTS `nostrum_starter_rewards` (
  `guid`        INT UNSIGNED NOT NULL COMMENT 'Character GUID',
  `rewarded_at` INT UNSIGNED NOT NULL COMMENT 'Unix timestamp of when the reward was granted',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
