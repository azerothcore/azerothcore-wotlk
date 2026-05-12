-- mod-nostrum-bg-xp: daily first-win tracking
-- Apply once to the characters database.

CREATE TABLE IF NOT EXISTS `character_bg_xp_daily` (
  `guid`          INT UNSIGNED NOT NULL,
  `last_win_date` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
