-- Snapshot of the character table created automatically on worldserver boot.

CREATE TABLE IF NOT EXISTS `character_challenge_modes` (
  `guid` INT UNSIGNED NOT NULL,
  `hardcore` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `semi_hardcore` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `self_crafted` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `item_quality` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `slow_xp` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `very_slow_xp` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `quest_xp` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `iron_man` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `hardcore_dead` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `picker_done` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
