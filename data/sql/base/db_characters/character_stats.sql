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

-- Дамп структуры для таблица _acore_characters.character_stats
DROP TABLE IF EXISTS `character_stats`;
CREATE TABLE IF NOT EXISTS `character_stats` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier, Low part',
  `maxhealth` INT unsigned NOT NULL DEFAULT 0,
  `maxpower1` INT unsigned NOT NULL DEFAULT 0,
  `maxpower2` INT unsigned NOT NULL DEFAULT 0,
  `maxpower3` INT unsigned NOT NULL DEFAULT 0,
  `maxpower4` INT unsigned NOT NULL DEFAULT 0,
  `maxpower5` INT unsigned NOT NULL DEFAULT 0,
  `maxpower6` INT unsigned NOT NULL DEFAULT 0,
  `maxpower7` INT unsigned NOT NULL DEFAULT 0,
  `strength` INT unsigned NOT NULL DEFAULT 0,
  `agility` INT unsigned NOT NULL DEFAULT 0,
  `stamina` INT unsigned NOT NULL DEFAULT 0,
  `intellect` INT unsigned NOT NULL DEFAULT 0,
  `spirit` INT unsigned NOT NULL DEFAULT 0,
  `armor` INT unsigned NOT NULL DEFAULT 0,
  `resHoly` INT unsigned NOT NULL DEFAULT 0,
  `resFire` INT unsigned NOT NULL DEFAULT 0,
  `resNature` INT unsigned NOT NULL DEFAULT 0,
  `resFrost` INT unsigned NOT NULL DEFAULT 0,
  `resShadow` INT unsigned NOT NULL DEFAULT 0,
  `resArcane` INT unsigned NOT NULL DEFAULT 0,
  `blockPct` float NOT NULL DEFAULT 0,
  `dodgePct` float NOT NULL DEFAULT 0,
  `parryPct` float NOT NULL DEFAULT 0,
  `critPct` float NOT NULL DEFAULT 0,
  `rangedCritPct` float NOT NULL DEFAULT 0,
  `spellCritPct` float NOT NULL DEFAULT 0,
  `attackPower` INT unsigned NOT NULL DEFAULT 0,
  `rangedAttackPower` INT unsigned NOT NULL DEFAULT 0,
  `spellPower` INT unsigned NOT NULL DEFAULT 0,
  `resilience` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`),
  CHECK (`blockPct` >= 0 and `dodgePct` >= 0 and `parryPct` >= 0 and `critPct` >= 0 and `rangedCritPct` >= 0 and `spellCritPct` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_characters.character_stats: ~0 rows (приблизительно)
DELETE FROM `character_stats`;
/*!40000 ALTER TABLE `character_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_stats` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
