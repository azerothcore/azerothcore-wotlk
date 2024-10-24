-- DB Table creation
DROP TABLE IF EXISTS `creature_sparring`;
CREATE TABLE `creature_sparring` (
  `GUID` int unsigned NOT NULL,
  `SparringPCT` float NOT NULL,
  PRIMARY KEY (`GUID`),
  FOREIGN KEY (`GUID`) REFERENCES creature(`guid`),
  CONSTRAINT `creature_sparring_chk_1` CHECK (`SparringPCT` BETWEEN 0 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Reload command
DELETE FROM `command` WHERE `name` = 'reload creature_sparring';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('creature_sparring', 3, 'Syntax: .reload creature_sparring\nReload all creatures with an entry in creature_sparring table.');