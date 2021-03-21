/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `durabilitycosts_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `durabilitycosts_dbc` 
(
  `ID` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_1` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_2` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_3` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_4` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_5` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_6` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_7` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_8` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_9` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_10` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_11` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_12` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_13` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_14` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_15` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_16` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_17` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_18` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_19` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_20` int(11) NOT NULL DEFAULT 0,
  `WeaponSubClassCost_21` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_1` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_2` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_3` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_4` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_5` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_6` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_7` int(11) NOT NULL DEFAULT 0,
  `ArmorSubClassCost_8` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `durabilitycosts_dbc` WRITE;
/*!40000 ALTER TABLE `durabilitycosts_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `durabilitycosts_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

