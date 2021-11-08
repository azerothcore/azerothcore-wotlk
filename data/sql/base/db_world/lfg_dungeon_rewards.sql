-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица _acore_world.lfg_dungeon_rewards
DROP TABLE IF EXISTS `lfg_dungeon_rewards`;
CREATE TABLE IF NOT EXISTS `lfg_dungeon_rewards` (
  `dungeonId` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Dungeon entry from dbc',
  `maxLevel` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT 'Max level at which this reward is rewarded',
  `firstQuestId` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Quest id with rewards for first dungeon this day',
  `otherQuestId` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Quest id with rewards for Nth dungeon this day',
  PRIMARY KEY (`dungeonId`,`maxLevel`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.lfg_dungeon_rewards: 15 rows
DELETE FROM `lfg_dungeon_rewards`;
/*!40000 ALTER TABLE `lfg_dungeon_rewards` DISABLE KEYS */;
INSERT INTO `lfg_dungeon_rewards` (`dungeonId`, `maxLevel`, `firstQuestId`, `otherQuestId`) VALUES
	(258, 15, 24881, 24889),
	(258, 25, 24882, 24890),
	(258, 34, 24883, 24891),
	(258, 45, 24884, 24892),
	(258, 55, 24885, 24893),
	(258, 60, 24886, 24894),
	(259, 64, 24887, 24895),
	(259, 70, 24888, 24896),
	(260, 70, 24922, 24923),
	(261, 80, 24790, 24791),
	(262, 80, 24788, 24789),
	(285, 80, 25482, 0),
	(286, 80, 25484, 0),
	(287, 80, 25483, 0),
	(288, 80, 25485, 0);
/*!40000 ALTER TABLE `lfg_dungeon_rewards` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
