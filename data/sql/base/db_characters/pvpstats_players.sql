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

-- Dumpar struktur för tabell acore_characters.pvpstats_players
DROP TABLE IF EXISTS `pvpstats_players`;
CREATE TABLE IF NOT EXISTS `pvpstats_players` (
  `battleground_id` BIGINT unsigned NOT NULL,
  `character_guid` INT unsigned NOT NULL,
  `winner` bit(1) NOT NULL,
  `score_killing_blows` MEDIUMINT unsigned NOT NULL,
  `score_deaths` MEDIUMINT unsigned NOT NULL,
  `score_honorable_kills` MEDIUMINT unsigned NOT NULL,
  `score_bonus_honor` MEDIUMINT unsigned NOT NULL,
  `score_damage_done` MEDIUMINT unsigned NOT NULL,
  `score_healing_done` MEDIUMINT unsigned NOT NULL,
  `attr_1` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `attr_2` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `attr_3` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `attr_4` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `attr_5` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`battleground_id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumpar data för tabell acore_characters.pvpstats_players: ~0 rows (ungefär)
DELETE FROM `pvpstats_players`;
/*!40000 ALTER TABLE `pvpstats_players` DISABLE KEYS */;
/*!40000 ALTER TABLE `pvpstats_players` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
