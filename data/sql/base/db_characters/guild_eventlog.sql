-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_characters.guild_eventlog
DROP TABLE IF EXISTS `guild_eventlog`;
CREATE TABLE IF NOT EXISTS `guild_eventlog` (
  `guildid` INT unsigned NOT NULL COMMENT 'Guild Identificator',
  `LogGuid` INT unsigned NOT NULL COMMENT 'Log record identificator - auxiliary column',
  `EventType` TINYINT unsigned NOT NULL COMMENT 'Event type',
  `PlayerGuid1` INT unsigned NOT NULL COMMENT 'Player 1',
  `PlayerGuid2` INT unsigned NOT NULL COMMENT 'Player 2',
  `NewRank` TINYINT unsigned NOT NULL COMMENT 'New rank(in case promotion/demotion)',
  `TimeStamp` INT unsigned NOT NULL COMMENT 'Event UNIX time',
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `Idx_PlayerGuid1` (`PlayerGuid1`),
  KEY `Idx_PlayerGuid2` (`PlayerGuid2`),
  KEY `Idx_LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Guild Eventlog';

-- Dumpar data för tabell acore_characters.guild_eventlog: ~0 rows (ungefär)
DELETE FROM `guild_eventlog`;
/*!40000 ALTER TABLE `guild_eventlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_eventlog` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
