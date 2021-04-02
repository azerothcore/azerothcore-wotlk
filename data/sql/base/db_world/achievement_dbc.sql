/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `achievement_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `achievement_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Faction` INT NOT NULL DEFAULT 0,
  `Instance_Id` INT NOT NULL DEFAULT 0,
  `Supercedes` INT NOT NULL DEFAULT 0,
  `Title_Lang_enUS` varchar(100) DEFAULT NULL,
  `Title_Lang_enGB` varchar(100) DEFAULT NULL,
  `Title_Lang_koKR` varchar(100) DEFAULT NULL,
  `Title_Lang_frFR` varchar(100) DEFAULT NULL,
  `Title_Lang_deDE` varchar(100) DEFAULT NULL,
  `Title_Lang_enCN` varchar(100) DEFAULT NULL,
  `Title_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Title_Lang_enTW` varchar(100) DEFAULT NULL,
  `Title_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Title_Lang_esES` varchar(100) DEFAULT NULL,
  `Title_Lang_esMX` varchar(100) DEFAULT NULL,
  `Title_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Title_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Title_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Title_Lang_itIT` varchar(100) DEFAULT NULL,
  `Title_Lang_Unk` varchar(100) DEFAULT NULL,
  `Title_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Description_Lang_enUS` varchar(200) DEFAULT NULL,
  `Description_Lang_enGB` varchar(200) DEFAULT NULL,
  `Description_Lang_koKR` varchar(200) DEFAULT NULL,
  `Description_Lang_frFR` varchar(200) DEFAULT NULL,
  `Description_Lang_deDE` varchar(200) DEFAULT NULL,
  `Description_Lang_enCN` varchar(200) DEFAULT NULL,
  `Description_Lang_zhCN` varchar(200) DEFAULT NULL,
  `Description_Lang_enTW` varchar(200) DEFAULT NULL,
  `Description_Lang_zhTW` varchar(200) DEFAULT NULL,
  `Description_Lang_esES` varchar(200) DEFAULT NULL,
  `Description_Lang_esMX` varchar(200) DEFAULT NULL,
  `Description_Lang_ruRU` varchar(200) DEFAULT NULL,
  `Description_Lang_ptPT` varchar(200) DEFAULT NULL,
  `Description_Lang_ptBR` varchar(200) DEFAULT NULL,
  `Description_Lang_itIT` varchar(200) DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) DEFAULT NULL,
  `Description_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Category` INT NOT NULL DEFAULT 0,
  `Points` INT NOT NULL DEFAULT 0,
  `Ui_Order` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `IconID` INT NOT NULL DEFAULT 0,
  `Reward_Lang_enUS` varchar(100) DEFAULT NULL,
  `Reward_Lang_enGB` varchar(100) DEFAULT NULL,
  `Reward_Lang_koKR` varchar(100) DEFAULT NULL,
  `Reward_Lang_frFR` varchar(100) DEFAULT NULL,
  `Reward_Lang_deDE` varchar(100) DEFAULT NULL,
  `Reward_Lang_enCN` varchar(100) DEFAULT NULL,
  `Reward_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Reward_Lang_enTW` varchar(100) DEFAULT NULL,
  `Reward_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Reward_Lang_esES` varchar(100) DEFAULT NULL,
  `Reward_Lang_esMX` varchar(100) DEFAULT NULL,
  `Reward_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Reward_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Reward_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Reward_Lang_itIT` varchar(100) DEFAULT NULL,
  `Reward_Lang_Unk` varchar(100) DEFAULT NULL,
  `Reward_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Minimum_Criteria` INT NOT NULL DEFAULT 0,
  `Shares_Criteria` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `achievement_dbc` WRITE;
/*!40000 ALTER TABLE `achievement_dbc` DISABLE KEYS */;
INSERT INTO `achievement_dbc` VALUES 
(3696,-1,-1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,2,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0),
(4788,-1,-1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,2,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0),
(4789,-1,-1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,2,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0);
/*!40000 ALTER TABLE `achievement_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

