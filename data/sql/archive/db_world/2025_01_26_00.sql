-- DB update 2025_01_25_00 -> 2025_01_26_00
--
DROP TABLE IF EXISTS `creature_sparring`;
CREATE TABLE `creature_sparring` (
  `GUID` int unsigned NOT NULL,
  `SparringPCT` float NOT NULL,
  PRIMARY KEY (`GUID`),
  FOREIGN KEY (`GUID`) REFERENCES creature(`guid`),
  CONSTRAINT `creature_sparring_chk_1` CHECK (`SparringPCT` BETWEEN 0 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
