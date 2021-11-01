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

-- Дамп структуры для таблица _acore_characters.characters
DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `account` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Account Identifier',
  `name` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `race` TINYINT unsigned NOT NULL DEFAULT 0,
  `class` TINYINT unsigned NOT NULL DEFAULT 0,
  `gender` TINYINT unsigned NOT NULL DEFAULT 0,
  `level` TINYINT unsigned NOT NULL DEFAULT 0,
  `xp` INT unsigned NOT NULL DEFAULT 0,
  `money` INT unsigned NOT NULL DEFAULT 0,
  `skin` TINYINT unsigned NOT NULL DEFAULT 0,
  `face` TINYINT unsigned NOT NULL DEFAULT 0,
  `hairStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `hairColor` TINYINT unsigned NOT NULL DEFAULT 0,
  `facialStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `bankSlots` TINYINT unsigned NOT NULL DEFAULT 0,
  `restState` TINYINT unsigned NOT NULL DEFAULT 0,
  `playerFlags` INT unsigned NOT NULL DEFAULT 0,
  `position_x` float NOT NULL DEFAULT 0,
  `position_y` float NOT NULL DEFAULT 0,
  `position_z` float NOT NULL DEFAULT 0,
  `map` SMALLINT unsigned NOT NULL DEFAULT 0 COMMENT 'Map Identifier',
  `instance_id` INT unsigned NOT NULL DEFAULT 0,
  `instance_mode_mask` TINYINT unsigned NOT NULL DEFAULT 0,
  `orientation` float NOT NULL DEFAULT 0,
  `taximask` text NOT NULL,
  `online` TINYINT unsigned NOT NULL DEFAULT 0,
  `cinematic` TINYINT unsigned NOT NULL DEFAULT 0,
  `totaltime` INT unsigned NOT NULL DEFAULT 0,
  `leveltime` INT unsigned NOT NULL DEFAULT 0,
  `logout_time` INT unsigned NOT NULL DEFAULT 0,
  `is_logout_resting` TINYINT unsigned NOT NULL DEFAULT 0,
  `rest_bonus` float NOT NULL DEFAULT 0,
  `resettalents_cost` INT unsigned NOT NULL DEFAULT 0,
  `resettalents_time` INT unsigned NOT NULL DEFAULT 0,
  `trans_x` float NOT NULL DEFAULT 0,
  `trans_y` float NOT NULL DEFAULT 0,
  `trans_z` float NOT NULL DEFAULT 0,
  `trans_o` float NOT NULL DEFAULT 0,
  `transguid` mediumint(9) NOT NULL DEFAULT 0,
  `extra_flags` SMALLINT unsigned NOT NULL DEFAULT 0,
  `stable_slots` TINYINT unsigned NOT NULL DEFAULT 0,
  `at_login` SMALLINT unsigned NOT NULL DEFAULT 0,
  `zone` SMALLINT unsigned NOT NULL DEFAULT 0,
  `death_expire_time` INT unsigned NOT NULL DEFAULT 0,
  `taxi_path` text DEFAULT NULL,
  `arenaPoints` INT unsigned NOT NULL DEFAULT 0,
  `totalHonorPoints` INT unsigned NOT NULL DEFAULT 0,
  `todayHonorPoints` INT unsigned NOT NULL DEFAULT 0,
  `yesterdayHonorPoints` INT unsigned NOT NULL DEFAULT 0,
  `totalKills` INT unsigned NOT NULL DEFAULT 0,
  `todayKills` SMALLINT unsigned NOT NULL DEFAULT 0,
  `yesterdayKills` SMALLINT unsigned NOT NULL DEFAULT 0,
  `chosenTitle` INT unsigned NOT NULL DEFAULT 0,
  `knownCurrencies` BIGINT unsigned NOT NULL DEFAULT 0,
  `watchedFaction` INT unsigned NOT NULL DEFAULT 0,
  `drunk` TINYINT unsigned NOT NULL DEFAULT 0,
  `health` INT unsigned NOT NULL DEFAULT 0,
  `power1` INT unsigned NOT NULL DEFAULT 0,
  `power2` INT unsigned NOT NULL DEFAULT 0,
  `power3` INT unsigned NOT NULL DEFAULT 0,
  `power4` INT unsigned NOT NULL DEFAULT 0,
  `power5` INT unsigned NOT NULL DEFAULT 0,
  `power6` INT unsigned NOT NULL DEFAULT 0,
  `power7` INT unsigned NOT NULL DEFAULT 0,
  `latency` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `talentGroupsCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `activeTalentGroup` TINYINT unsigned NOT NULL DEFAULT 0,
  `exploredZones` longtext DEFAULT NULL,
  `equipmentCache` longtext DEFAULT NULL,
  `ammoId` INT unsigned NOT NULL DEFAULT 0,
  `knownTitles` longtext DEFAULT NULL,
  `actionBars` TINYINT unsigned NOT NULL DEFAULT 0,
  `grantableLevels` TINYINT unsigned NOT NULL DEFAULT 0,
  `order` TINYINT DEFAULT NULL,
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleteInfos_Account` INT unsigned DEFAULT NULL,
  `deleteInfos_Name` varchar(12) DEFAULT NULL,
  `deleteDate` INT unsigned DEFAULT NULL,
  `innTriggerId` INT unsigned NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_account` (`account`),
  KEY `idx_online` (`online`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

-- Дамп данных таблицы _acore_characters.characters: ~0 rows (приблизительно)
DELETE FROM `characters`;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
