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

-- Дамп структуры для таблица _acore_world.mail_loot_template
DROP TABLE IF EXISTS `mail_loot_template`;
CREATE TABLE IF NOT EXISTS `mail_loot_template` (
  `Entry` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Item` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Reference` mediumint(9) NOT NULL DEFAULT 0,
  `Chance` float NOT NULL DEFAULT 100,
  `QuestRequired` TINYINT NOT NULL DEFAULT 0,
  `LootMode` SMALLINT unsigned NOT NULL DEFAULT 1,
  `GroupId` TINYINT unsigned NOT NULL DEFAULT 0,
  `MinCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `MaxCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `Comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Loot System';

-- Дамп данных таблицы _acore_world.mail_loot_template: 105 rows
DELETE FROM `mail_loot_template`;
/*!40000 ALTER TABLE `mail_loot_template` DISABLE KEYS */;
INSERT INTO `mail_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
	(84, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(85, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(86, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(87, 6529, 0, 100, 0, 1, 0, 1, 1, 'Shiny Bauble'),
	(88, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(89, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(90, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(91, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(92, 20469, 0, 100, 0, 1, 0, 1, 1, 'Decoded True Believer Clippings'),
	(92, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(93, 20469, 0, 100, 0, 1, 0, 1, 1, 'Decoded True Believer Clippings'),
	(95, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(96, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(97, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(98, 13158, 0, 100, 0, 1, 0, 1, 1, 'Words of the High Chief'),
	(99, 11423, 0, 100, 0, 1, 0, 1, 1, 'Gnome Engineer\'s Renewal Gift'),
	(100, 11423, 0, 100, 0, 1, 0, 1, 1, 'Gnome Engineer\'s Renewal Gift'),
	(102, 17685, 0, 100, 0, 1, 0, 1, 1, 'Smokywood Pastures Sampler'),
	(103, 11422, 0, 100, 0, 1, 0, 1, 1, 'Goblin Engineer\'s Renewal Gift'),
	(104, 11422, 0, 100, 0, 1, 0, 1, 1, 'Goblin Engineer\'s Renewal Gift'),
	(108, 17712, 0, 100, 0, 1, 0, 1, 1, 'Winter Veil Disguise Kit'),
	(109, 19858, 0, 100, 0, 1, 0, 1, 1, 'Zandalar Honor Token'),
	(111, 19697, 0, 100, 0, 1, 0, 1, 1, 'Bounty of the Harvest'),
	(113, 19697, 0, 100, 0, 1, 0, 1, 1, 'Bounty of the Harvest'),
	(117, 17712, 0, 100, 0, 1, 0, 1, 1, 'Winter Veil Disguise Kit'),
	(118, 17685, 0, 100, 0, 1, 0, 1, 1, 'Smokywood Pastures Sampler'),
	(119, 15564, 0, 100, 0, 1, 0, 1, 1, 'Rugged Armor Kit'),
	(120, 15564, 0, 100, 0, 1, 0, 1, 1, 'Rugged Armor Kit'),
	(121, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(122, 21216, 0, 100, 0, 1, 0, 1, 1, 'Smokywood Pastures Extra-Special Gift'),
	(124, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(125, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(126, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(127, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(128, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(129, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(130, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(131, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(132, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(133, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(134, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(135, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(136, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(137, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(138, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(139, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(140, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(141, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(142, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(143, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(144, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(145, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(146, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(147, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(148, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(149, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(150, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(151, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(152, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(153, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(154, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(155, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(156, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(157, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(158, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(159, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(160, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(161, 21216, 0, 100, 0, 1, 0, 1, 1, 'Smokywood Pastures Extra-Special Gift'),
	(168, 21746, 0, 100, 0, 1, 0, 1, 1, 'Lucky Red Envelope'),
	(180, 24132, 0, 100, 0, 1, 0, 1, 1, 'A Letter from the Admiral'),
	(183, 31698, 0, 100, 0, 1, 0, 1, 1, 'Letter from Shattrath'),
	(211, 37676, 0, 100, 0, 1, 0, 1, 1, 'Vengeful Nether Drake'),
	(212, 37898, 0, 100, 0, 1, 0, 1, 1, 'Wild Winter Pilsner'),
	(213, 37489, 0, 100, 0, 1, 0, 1, 1, 'Izzard\'s Ever Flavor'),
	(214, 37900, 0, 100, 0, 1, 0, 1, 1, 'Aromatic Honey Brew'),
	(215, 37901, 0, 100, 0, 1, 0, 1, 1, 'Metok\'s Bubble Bock'),
	(216, 37902, 0, 100, 0, 1, 0, 1, 1, 'Springtime Stout'),
	(217, 37903, 0, 100, 0, 1, 0, 1, 1, 'Blackrock Lager'),
	(218, 37904, 0, 100, 0, 1, 0, 1, 1, 'Stranglethorn Brew'),
	(219, 37905, 0, 100, 0, 1, 0, 1, 1, 'Draenic Pale Ale'),
	(220, 37906, 0, 100, 0, 1, 0, 1, 1, 'Binary Brew'),
	(221, 37907, 0, 100, 0, 1, 0, 1, 1, 'Autumnal Acorn Ale'),
	(222, 37908, 0, 100, 0, 1, 0, 1, 1, 'Bartlett\'s Bitter Brew'),
	(223, 37909, 0, 100, 0, 1, 0, 1, 1, 'Lord of Frost\'s Private Label'),
	(224, 46875, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(225, 46876, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(226, 46877, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(227, 46879, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(228, 46878, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(229, 46884, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(230, 46883, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(231, 46880, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(232, 46882, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(233, 46881, 0, 100, 0, 1, 0, 1, 1, 'Riding Training Pamphlet'),
	(236, 39317, 0, 100, 0, 1, 0, 1, 1, 'News From The North'),
	(262, 43516, 0, 100, 0, 1, 0, 1, 1, 'Brutal Nether Drake'),
	(264, 44817, 0, 100, 0, 1, 0, 1, 1, 'The Mischief Maker'),
	(266, 46708, 0, 100, 0, 1, 0, 1, 1, 'Deadly Gladiator\'s Frost Wyrm'),
	(267, 46171, 0, 100, 0, 1, 0, 1, 1, 'Furious Gladiator\'s Frost Wyrm'),
	(269, 46545, 0, 100, 0, 1, 0, 1, 1, 'Curious Oracle Hatchling'),
	(270, 46544, 0, 100, 0, 1, 0, 1, 1, 'Curious Wolvar Pup'),
	(270, 46545, 0, 100, 0, 1, 0, 1, 1, 'Curious Oracle Hatchling'),
	(271, 46544, 0, 100, 0, 1, 0, 1, 1, 'Curious Wolvar Pup'),
	(286, 47840, 0, 100, 0, 1, 0, 1, 1, 'Relentless Gladiator\'s Frost Wyrm'),
	(287, 50435, 0, 100, 0, 1, 0, 1, 1, 'Wrathful Gladiator\'s Frost Wyrm');
/*!40000 ALTER TABLE `mail_loot_template` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
