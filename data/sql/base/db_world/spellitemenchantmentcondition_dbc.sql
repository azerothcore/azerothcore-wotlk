/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `spellitemenchantmentcondition_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `spellitemenchantmentcondition_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Lt_OperandType_1` TINYINT unsigned NOT NULL DEFAULT 0,
  `Lt_OperandType_2` TINYINT unsigned NOT NULL DEFAULT 0,
  `Lt_OperandType_3` TINYINT unsigned NOT NULL DEFAULT 0,
  `Lt_OperandType_4` TINYINT unsigned NOT NULL DEFAULT 0,
  `Lt_OperandType_5` TINYINT unsigned NOT NULL DEFAULT 0,
  `Lt_Operand_1` INT NOT NULL DEFAULT 0,
  `Lt_Operand_2` INT NOT NULL DEFAULT 0,
  `Lt_Operand_3` INT NOT NULL DEFAULT 0,
  `Lt_Operand_4` INT NOT NULL DEFAULT 0,
  `Lt_Operand_5` INT NOT NULL DEFAULT 0,
  `Operator_1` TINYINT unsigned NOT NULL DEFAULT 0,
  `Operator_2` TINYINT unsigned NOT NULL DEFAULT 0,
  `Operator_3` TINYINT unsigned NOT NULL DEFAULT 0,
  `Operator_4` TINYINT unsigned NOT NULL DEFAULT 0,
  `Operator_5` TINYINT unsigned NOT NULL DEFAULT 0,
  `Rt_OperandType_1` TINYINT unsigned NOT NULL DEFAULT 0,
  `Rt_OperandType_2` TINYINT unsigned NOT NULL DEFAULT 0,
  `Rt_OperandType_3` TINYINT unsigned NOT NULL DEFAULT 0,
  `Rt_OperandType_4` TINYINT unsigned NOT NULL DEFAULT 0,
  `Rt_OperandType_5` TINYINT unsigned NOT NULL DEFAULT 0,
  `Rt_Operand_1` INT NOT NULL DEFAULT 0,
  `Rt_Operand_2` INT NOT NULL DEFAULT 0,
  `Rt_Operand_3` INT NOT NULL DEFAULT 0,
  `Rt_Operand_4` INT NOT NULL DEFAULT 0,
  `Rt_Operand_5` INT NOT NULL DEFAULT 0,
  `Logic_1` TINYINT unsigned NOT NULL DEFAULT 0,
  `Logic_2` TINYINT unsigned NOT NULL DEFAULT 0,
  `Logic_3` TINYINT unsigned NOT NULL DEFAULT 0,
  `Logic_4` TINYINT unsigned NOT NULL DEFAULT 0,
  `Logic_5` TINYINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `spellitemenchantmentcondition_dbc` WRITE;
/*!40000 ALTER TABLE `spellitemenchantmentcondition_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `spellitemenchantmentcondition_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

