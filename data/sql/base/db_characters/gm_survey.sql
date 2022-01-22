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

-- Дамп структуры для таблица _acore_characters.gm_survey
DROP TABLE IF EXISTS `gm_survey`;
CREATE TABLE IF NOT EXISTS `gm_survey` (
  `surveyId` INT unsigned NOT NULL AUTO_INCREMENT,
  `guid` INT unsigned NOT NULL DEFAULT 0,
  `mainSurvey` INT unsigned NOT NULL DEFAULT 0,
  `comment` longtext NOT NULL,
  `createTime` INT unsigned NOT NULL DEFAULT 0,
  `maxMMR` SMALLINT NOT NULL,
  PRIMARY KEY (`surveyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

-- Дамп данных таблицы _acore_characters.gm_survey: ~0 rows (приблизительно)
DELETE FROM `gm_survey`;
/*!40000 ALTER TABLE `gm_survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `gm_survey` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
