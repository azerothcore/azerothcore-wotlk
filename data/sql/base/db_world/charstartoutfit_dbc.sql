/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `charstartoutfit_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charstartoutfit_dbc` 
(
  `ID` int(11) NOT NULL DEFAULT 0,
  `RaceID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ClassID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `SexID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `OutfitID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ItemID_1` int(11) NOT NULL DEFAULT 0,
  `ItemID_2` int(11) NOT NULL DEFAULT 0,
  `ItemID_3` int(11) NOT NULL DEFAULT 0,
  `ItemID_4` int(11) NOT NULL DEFAULT 0,
  `ItemID_5` int(11) NOT NULL DEFAULT 0,
  `ItemID_6` int(11) NOT NULL DEFAULT 0,
  `ItemID_7` int(11) NOT NULL DEFAULT 0,
  `ItemID_8` int(11) NOT NULL DEFAULT 0,
  `ItemID_9` int(11) NOT NULL DEFAULT 0,
  `ItemID_10` int(11) NOT NULL DEFAULT 0,
  `ItemID_11` int(11) NOT NULL DEFAULT 0,
  `ItemID_12` int(11) NOT NULL DEFAULT 0,
  `ItemID_13` int(11) NOT NULL DEFAULT 0,
  `ItemID_14` int(11) NOT NULL DEFAULT 0,
  `ItemID_15` int(11) NOT NULL DEFAULT 0,
  `ItemID_16` int(11) NOT NULL DEFAULT 0,
  `ItemID_17` int(11) NOT NULL DEFAULT 0,
  `ItemID_18` int(11) NOT NULL DEFAULT 0,
  `ItemID_19` int(11) NOT NULL DEFAULT 0,
  `ItemID_20` int(11) NOT NULL DEFAULT 0,
  `ItemID_21` int(11) NOT NULL DEFAULT 0,
  `ItemID_22` int(11) NOT NULL DEFAULT 0,
  `ItemID_23` int(11) NOT NULL DEFAULT 0,
  `ItemID_24` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_1` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_2` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_3` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_4` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_5` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_6` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_7` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_8` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_9` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_10` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_11` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_12` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_13` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_14` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_15` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_16` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_17` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_18` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_19` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_20` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_21` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_22` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_23` int(11) NOT NULL DEFAULT 0,
  `DisplayItemID_24` int(11) NOT NULL DEFAULT 0,
  `InventoryType_1` int(11) NOT NULL DEFAULT 0,
  `InventoryType_2` int(11) NOT NULL DEFAULT 0,
  `InventoryType_3` int(11) NOT NULL DEFAULT 0,
  `InventoryType_4` int(11) NOT NULL DEFAULT 0,
  `InventoryType_5` int(11) NOT NULL DEFAULT 0,
  `InventoryType_6` int(11) NOT NULL DEFAULT 0,
  `InventoryType_7` int(11) NOT NULL DEFAULT 0,
  `InventoryType_8` int(11) NOT NULL DEFAULT 0,
  `InventoryType_9` int(11) NOT NULL DEFAULT 0,
  `InventoryType_10` int(11) NOT NULL DEFAULT 0,
  `InventoryType_11` int(11) NOT NULL DEFAULT 0,
  `InventoryType_12` int(11) NOT NULL DEFAULT 0,
  `InventoryType_13` int(11) NOT NULL DEFAULT 0,
  `InventoryType_14` int(11) NOT NULL DEFAULT 0,
  `InventoryType_15` int(11) NOT NULL DEFAULT 0,
  `InventoryType_16` int(11) NOT NULL DEFAULT 0,
  `InventoryType_17` int(11) NOT NULL DEFAULT 0,
  `InventoryType_18` int(11) NOT NULL DEFAULT 0,
  `InventoryType_19` int(11) NOT NULL DEFAULT 0,
  `InventoryType_20` int(11) NOT NULL DEFAULT 0,
  `InventoryType_21` int(11) NOT NULL DEFAULT 0,
  `InventoryType_22` int(11) NOT NULL DEFAULT 0,
  `InventoryType_23` int(11) NOT NULL DEFAULT 0,
  `InventoryType_24` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `charstartoutfit_dbc` WRITE;
/*!40000 ALTER TABLE `charstartoutfit_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `charstartoutfit_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

