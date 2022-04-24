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

-- Dumpar struktur för tabell acore_world.quest_mail_sender
DROP TABLE IF EXISTS `quest_mail_sender`;
CREATE TABLE IF NOT EXISTS `quest_mail_sender` (
  `QuestId` INT unsigned NOT NULL DEFAULT 0,
  `RewardMailSenderEntry` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`QuestId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell acore_world.quest_mail_sender: ~10 rows (ungefär)
DELETE FROM `quest_mail_sender`;
/*!40000 ALTER TABLE `quest_mail_sender` DISABLE KEYS */;
INSERT INTO `quest_mail_sender` (`QuestId`, `RewardMailSenderEntry`) VALUES
	(8729, 11811),
	(10588, 18166),
	(10966, 22818),
	(10967, 22817),
	(12067, 2708),
	(12085, 5885),
	(12422, 27102),
	(12711, 28930),
	(13959, 33533),
	(13960, 33532);
/*!40000 ALTER TABLE `quest_mail_sender` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
