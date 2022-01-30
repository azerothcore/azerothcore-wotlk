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

-- Дамп структуры для таблица acore_world.player_factionchange_titles
DROP TABLE IF EXISTS `player_factionchange_titles`;
CREATE TABLE IF NOT EXISTS `player_factionchange_titles` (
  `alliance_id` INT NOT NULL,
  `alliance_comment` text DEFAULT NULL,
  `horde_id` INT NOT NULL,
  `horde_comment` text DEFAULT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_world.player_factionchange_titles: 22 rows
DELETE FROM `player_factionchange_titles`;
/*!40000 ALTER TABLE `player_factionchange_titles` DISABLE KEYS */;
INSERT INTO `player_factionchange_titles` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
	(1, 'Private <name>', 15, 'Scout <name>'),
	(2, 'Corporal <name>', 16, 'Grunt <name>'),
	(3, 'Sergeant <name>', 17, 'Sergeant <name>'),
	(4, 'Master Sergeant <name>', 18, 'Senior Sergeant <name>'),
	(5, 'Sergeant Major <name>', 19, 'First Sergeant <name>'),
	(6, 'Knight <name>', 20, 'Stone Guard'),
	(7, 'Knight-Lieutenant <name>', 21, 'Blood Guard <name>'),
	(8, 'Knight-Captain <name>', 22, 'Legionnaire <name>'),
	(9, 'Knight-Champion <name>', 23, 'Centurion <name>'),
	(10, 'Lieutenant Commander <name>', 24, 'Champion <name>'),
	(11, 'Commander <name>', 25, 'Lieutenant General <name>'),
	(12, 'Marshal  <name>', 26, 'General <name>'),
	(13, 'Field Marshal <name>', 27, 'Warlord <name>'),
	(14, 'Grand Marshal <name>', 28, 'High Warlord <name>'),
	(48, 'Justicar <name>', 47, 'Conqueror <name>'),
	(75, 'Flame Warden <name>', 76, 'Flame Keeper <name>'),
	(113, '<name> of Gnomeregan', 153, '<name> of Thunder Bluff'),
	(126, '<name> of the Alliance', 127, '<name> if the Horde'),
	(146, '<name> of the Exodar', 152, '<name> of Silvermoon'),
	(147, '<name> of Darnassus', 154, '<name> of the Undercity'),
	(148, '<name> of Ironforge', 151, '<name> of Sen\'jin'),
	(149, '<name> of Stormwind', 150, '<name> of Orgrimmar');
/*!40000 ALTER TABLE `player_factionchange_titles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
