CREATE TABLE IF NOT EXISTS `mod_nostrum_peak_online` (
  `id`          TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `peak_count`  INT UNSIGNED     NOT NULL DEFAULT 0,
  `achieved_at` TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `mod_nostrum_peak_online` (`id`, `peak_count`) VALUES (1, 0);
