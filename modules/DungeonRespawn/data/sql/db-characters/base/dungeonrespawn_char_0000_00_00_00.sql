CREATE TABLE IF NOT EXISTS `dungeonrespawn_playerinfo` (
  `guid` bigint(20) unsigned DEFAULT NULL,
  `map` int(11) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `o` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;