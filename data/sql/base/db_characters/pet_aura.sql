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

-- Дамп структуры для таблица _acore_characters.pet_aura
DROP TABLE IF EXISTS `pet_aura`;
CREATE TABLE IF NOT EXISTS `pet_aura` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `casterGuid` BIGINT unsigned NOT NULL DEFAULT 0 COMMENT 'Full Global Unique Identifier',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `effectMask` TINYINT unsigned NOT NULL DEFAULT 0,
  `recalculateMask` TINYINT unsigned NOT NULL DEFAULT 0,
  `stackCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `amount0` mediumint(9) NOT NULL,
  `amount1` mediumint(9) NOT NULL,
  `amount2` mediumint(9) NOT NULL,
  `base_amount0` mediumint(9) NOT NULL,
  `base_amount1` mediumint(9) NOT NULL,
  `base_amount2` mediumint(9) NOT NULL,
  `maxDuration` INT NOT NULL DEFAULT 0,
  `remainTime` INT NOT NULL DEFAULT 0,
  `remainCharges` TINYINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`casterGuid`,`spell`,`effectMask`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Pet System';

-- Дамп данных таблицы _acore_characters.pet_aura: ~0 rows (приблизительно)
DELETE FROM `pet_aura`;
/*!40000 ALTER TABLE `pet_aura` DISABLE KEYS */;
/*!40000 ALTER TABLE `pet_aura` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
