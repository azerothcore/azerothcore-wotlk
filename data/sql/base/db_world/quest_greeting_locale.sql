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

-- Dumpar struktur för tabell acore_world.quest_greeting_locale
DROP TABLE IF EXISTS `quest_greeting_locale`;
CREATE TABLE IF NOT EXISTS `quest_greeting_locale` (
  `ID` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `type` TINYINT unsigned NOT NULL DEFAULT 0,
  `locale` VARCHAR(4) NOT NULL,
  `Greeting` text,
  `VerifiedBuild` SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`,`type`,`locale`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.quest_greeting_locale: 1 rows
DELETE FROM `quest_greeting_locale`;
/*!40000 ALTER TABLE `quest_greeting_locale` DISABLE KEYS */;
INSERT INTO `quest_greeting_locale` (`ID`, `type`, `locale`, `Greeting`, `VerifiedBuild`) VALUES
	(22292, 0, 'ruRU', 'Свет ещё не воссиял над Скеттисом.', 0);
/*!40000 ALTER TABLE `quest_greeting_locale` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
