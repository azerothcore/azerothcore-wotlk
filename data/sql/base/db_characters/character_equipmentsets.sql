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

-- Дамп структуры для таблица _acore_characters.character_equipmentsets
DROP TABLE IF EXISTS `character_equipmentsets`;
CREATE TABLE IF NOT EXISTS `character_equipmentsets` (
  `guid` INT NOT NULL DEFAULT 0,
  `setguid` BIGINT NOT NULL AUTO_INCREMENT,
  `setindex` TINYINT unsigned NOT NULL DEFAULT 0,
  `name` varchar(31) NOT NULL,
  `iconname` varchar(100) NOT NULL,
  `ignore_mask` INT unsigned NOT NULL DEFAULT 0,
  `item0` INT unsigned NOT NULL DEFAULT 0,
  `item1` INT unsigned NOT NULL DEFAULT 0,
  `item2` INT unsigned NOT NULL DEFAULT 0,
  `item3` INT unsigned NOT NULL DEFAULT 0,
  `item4` INT unsigned NOT NULL DEFAULT 0,
  `item5` INT unsigned NOT NULL DEFAULT 0,
  `item6` INT unsigned NOT NULL DEFAULT 0,
  `item7` INT unsigned NOT NULL DEFAULT 0,
  `item8` INT unsigned NOT NULL DEFAULT 0,
  `item9` INT unsigned NOT NULL DEFAULT 0,
  `item10` INT unsigned NOT NULL DEFAULT 0,
  `item11` INT unsigned NOT NULL DEFAULT 0,
  `item12` INT unsigned NOT NULL DEFAULT 0,
  `item13` INT unsigned NOT NULL DEFAULT 0,
  `item14` INT unsigned NOT NULL DEFAULT 0,
  `item15` INT unsigned NOT NULL DEFAULT 0,
  `item16` INT unsigned NOT NULL DEFAULT 0,
  `item17` INT unsigned NOT NULL DEFAULT 0,
  `item18` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`setguid`),
  UNIQUE KEY `idx_set` (`guid`,`setguid`,`setindex`),
  KEY `Idx_setindex` (`setindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_characters.character_equipmentsets: ~0 rows (приблизительно)
DELETE FROM `character_equipmentsets`;
/*!40000 ALTER TABLE `character_equipmentsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_equipmentsets` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
