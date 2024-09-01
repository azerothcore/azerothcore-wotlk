--
DROP TABLE IF EXISTS `creature_sparring`;
CREATE TABLE `creature_sparring` (
  `GUID` int unsigned NOT NULL,
  `SparringPCT` float NOT NULL CHECK(SparringPct between 0 and 100),
  PRIMARY KEY (`GUID`),
  FOREIGN KEY (`GUID`) REFERENCES creature(`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
