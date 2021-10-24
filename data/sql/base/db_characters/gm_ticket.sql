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

-- Дамп структуры для таблица _acore_characters.gm_ticket
DROP TABLE IF EXISTS `gm_ticket`;
CREATE TABLE IF NOT EXISTS `gm_ticket` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT,
  `type` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '0 open, 1 closed, 2 character deleted',
  `playerGuid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier of ticket creator',
  `name` varchar(12) NOT NULL COMMENT 'Name of ticket creator',
  `description` text NOT NULL,
  `createTime` INT unsigned NOT NULL DEFAULT 0,
  `mapId` SMALLINT unsigned NOT NULL DEFAULT 0,
  `posX` float NOT NULL DEFAULT 0,
  `posY` float NOT NULL DEFAULT 0,
  `posZ` float NOT NULL DEFAULT 0,
  `lastModifiedTime` INT unsigned NOT NULL DEFAULT 0,
  `closedBy` INT NOT NULL DEFAULT 0 COMMENT '-1 Closed by Console, >0 GUID of GM',
  `assignedTo` INT unsigned NOT NULL DEFAULT 0 COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` text NOT NULL,
  `response` text NOT NULL,
  `completed` TINYINT unsigned NOT NULL DEFAULT 0,
  `escalated` TINYINT unsigned NOT NULL DEFAULT 0,
  `viewed` TINYINT unsigned NOT NULL DEFAULT 0,
  `needMoreHelp` TINYINT unsigned NOT NULL DEFAULT 0,
  `resolvedBy` INT NOT NULL DEFAULT 0 COMMENT '-1 Resolved by Console, >0 GUID of GM',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

-- Дамп данных таблицы _acore_characters.gm_ticket: ~0 rows (приблизительно)
DELETE FROM `gm_ticket`;
/*!40000 ALTER TABLE `gm_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `gm_ticket` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
