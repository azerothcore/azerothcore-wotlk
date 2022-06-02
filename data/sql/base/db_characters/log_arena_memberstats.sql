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

-- Dumpar struktur för tabell acore_characters.log_arena_memberstats
DROP TABLE IF EXISTS `log_arena_memberstats`;
CREATE TABLE IF NOT EXISTS `log_arena_memberstats` (
  `fight_id` INT unsigned NOT NULL,
  `member_id` TINYINT unsigned NOT NULL,
  `name` char(20) NOT NULL,
  `guid` INT unsigned NOT NULL,
  `team` INT unsigned NOT NULL,
  `account` INT unsigned NOT NULL,
  `ip` char(15) NOT NULL,
  `damage` INT unsigned NOT NULL,
  `heal` INT unsigned NOT NULL,
  `kblows` INT unsigned NOT NULL,
  PRIMARY KEY (`fight_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.log_arena_memberstats: 0 rows
DELETE FROM `log_arena_memberstats`;
/*!40000 ALTER TABLE `log_arena_memberstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_arena_memberstats` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
