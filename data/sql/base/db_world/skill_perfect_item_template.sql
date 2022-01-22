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

-- Дамп структуры для таблица _acore_world.skill_perfect_item_template
DROP TABLE IF EXISTS `skill_perfect_item_template`;
CREATE TABLE IF NOT EXISTS `skill_perfect_item_template` (
  `spellId` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'SpellId of the item creation spell',
  `requiredSpecialization` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Specialization spell id',
  `perfectCreateChance` float NOT NULL DEFAULT 0 COMMENT 'chance to create the perfect item instead',
  `perfectItemType` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'perfect item type to create instead',
  PRIMARY KEY (`spellId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Crafting Perfection System';

-- Дамп данных таблицы _acore_world.skill_perfect_item_template: 72 rows
DELETE FROM `skill_perfect_item_template`;
/*!40000 ALTER TABLE `skill_perfect_item_template` DISABLE KEYS */;
INSERT INTO `skill_perfect_item_template` (`spellId`, `requiredSpecialization`, `perfectCreateChance`, `perfectItemType`) VALUES
	(53831, 55534, 20, 41432),
	(53832, 55534, 20, 41434),
	(53834, 55534, 20, 41438),
	(53835, 55534, 20, 41433),
	(53843, 55534, 20, 41439),
	(53844, 55534, 20, 41435),
	(53845, 55534, 20, 41436),
	(53852, 55534, 20, 41444),
	(53853, 55534, 20, 41448),
	(53854, 55534, 20, 41447),
	(53855, 55534, 20, 41449),
	(53856, 55534, 20, 41446),
	(53857, 55534, 20, 41445),
	(53859, 55534, 20, 41461),
	(53860, 55534, 20, 41460),
	(53861, 55534, 20, 41462),
	(53862, 55534, 20, 41452),
	(53863, 55534, 20, 41457),
	(53864, 55534, 20, 41459),
	(53865, 55534, 20, 41455),
	(53866, 55534, 20, 41450),
	(53867, 55534, 20, 41454),
	(53868, 55534, 20, 41458),
	(53869, 55534, 20, 41451),
	(53870, 55534, 20, 41456),
	(53871, 55534, 20, 41453),
	(53872, 55534, 20, 41492),
	(53873, 55534, 20, 41488),
	(53874, 55534, 20, 41483),
	(53875, 55534, 20, 41499),
	(53876, 55534, 20, 41489),
	(53877, 55534, 20, 41484),
	(53878, 55534, 20, 41491),
	(53879, 55534, 20, 41493),
	(53880, 55534, 20, 41485),
	(53881, 55534, 20, 41494),
	(53882, 55534, 20, 41495),
	(53883, 55534, 20, 41502),
	(53884, 55534, 20, 41486),
	(53885, 55534, 20, 41497),
	(53886, 55534, 20, 41429),
	(53887, 55534, 20, 41496),
	(53888, 55534, 20, 41487),
	(53889, 55534, 20, 41501),
	(53890, 55534, 20, 41500),
	(53891, 55534, 20, 41490),
	(53892, 55534, 20, 41482),
	(53893, 55534, 20, 41498),
	(53894, 55534, 20, 41479),
	(53916, 55534, 20, 41468),
	(53917, 55534, 20, 41481),
	(53918, 55534, 20, 41464),
	(53919, 55534, 20, 41476),
	(53920, 55534, 20, 41466),
	(53921, 55534, 20, 41473),
	(53922, 55534, 20, 41470),
	(53923, 55534, 20, 41475),
	(53924, 55534, 20, 41480),
	(53925, 55534, 20, 41467),
	(53926, 55534, 20, 41463),
	(53927, 55534, 20, 41477),
	(53928, 55534, 20, 41469),
	(53929, 55534, 20, 41471),
	(53930, 55534, 20, 41465),
	(53931, 55534, 20, 41472),
	(53932, 55534, 20, 41478),
	(53933, 55534, 20, 41474),
	(53934, 55534, 20, 41441),
	(53940, 55534, 20, 41442),
	(53941, 55534, 20, 41440),
	(53943, 55534, 20, 41443),
	(54017, 55534, 20, 41437);
/*!40000 ALTER TABLE `skill_perfect_item_template` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
