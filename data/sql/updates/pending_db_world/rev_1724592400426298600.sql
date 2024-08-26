-- 
DROP TABLE IF EXISTS `creature_sparring`;
CREATE TABLE `creature_sparring` (
  `Entry` int unsigned NOT NULL,
  `SparringPct` float NOT NULL CHECK(SparringPct between 0 and 100),
  PRIMARY KEY (`Entry`,`SparringPct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
