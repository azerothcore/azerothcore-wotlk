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

-- Dumpar struktur för tabell acore_characters.arena_team
DROP TABLE IF EXISTS `arena_team`;
CREATE TABLE IF NOT EXISTS `arena_team` (
  `arenaTeamId` INT unsigned NOT NULL DEFAULT 0,
  `name` VARCHAR(24) NOT NULL,
  `captainGuid` INT unsigned NOT NULL DEFAULT 0,
  `type` TINYINT unsigned NOT NULL DEFAULT 0,
  `rating` SMALLINT unsigned NOT NULL DEFAULT 0,
  `seasonGames` SMALLINT unsigned NOT NULL DEFAULT 0,
  `seasonWins` SMALLINT unsigned NOT NULL DEFAULT 0,
  `weekGames` SMALLINT unsigned NOT NULL DEFAULT 0,
  `weekWins` SMALLINT unsigned NOT NULL DEFAULT 0,
  `rank` INT unsigned NOT NULL DEFAULT 0,
  `backgroundColor` INT unsigned NOT NULL DEFAULT 0,
  `emblemStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `emblemColor` INT unsigned NOT NULL DEFAULT 0,
  `borderStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `borderColor` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`arenaTeamId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.arena_team: ~0 rows (ungefär)
DELETE FROM `arena_team`;
/*!40000 ALTER TABLE `arena_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `arena_team` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
