/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `characters` 
(
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `account` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Account Identifier',
  `name` varchar(12) CHARACTER SET UTF8MB4 COLLATE utf8mb4_bin NOT NULL,
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
  `transguid` MEDIUMINT unsigned NOT NULL DEFAULT 0,
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
  `latency` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `talentGroupsCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `activeTalentGroup` TINYINT unsigned NOT NULL DEFAULT 0,
  `exploredZones` longtext DEFAULT NULL,
  `equipmentCache` longtext DEFAULT NULL,
  `ammoId` INT unsigned NOT NULL DEFAULT 0,
  `knownTitles` longtext DEFAULT NULL,
  `actionBars` TINYINT unsigned NOT NULL DEFAULT 0,
  `grantableLevels` TINYINT unsigned NOT NULL DEFAULT 0,
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleteInfos_Account` INT unsigned DEFAULT NULL,
  `deleteInfos_Name` varchar(12) DEFAULT NULL,
  `deleteDate` INT unsigned DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_account` (`account`),
  KEY `idx_online` (`online`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

