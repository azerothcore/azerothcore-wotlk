-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `spell_group_stack_rules`
--

DROP TABLE IF EXISTS `spell_group_stack_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spell_group_stack_rules` (
  `group_id` int unsigned NOT NULL DEFAULT '0',
  `stack_rule` tinyint NOT NULL DEFAULT '0',
  `description` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_group_stack_rules`
--

LOCK TABLES `spell_group_stack_rules` WRITE;
/*!40000 ALTER TABLE `spell_group_stack_rules` DISABLE KEYS */;
INSERT INTO `spell_group_stack_rules` VALUES
(1,1,'Battle Elixir'),
(2,1,'Guardian Elixir'),
(1001,1,'Well Fed'),
(1002,4,'Blessing of Might'),
(1003,4,'Battle Shout'),
(1004,4,'Flat AP Buffs'),
(1005,4,'Blessing of Wisdom'),
(1006,1,'All Stats Percentage'),
(1007,1,'Blessing of Sanctuary'),
(1008,1,'Blessing of Protection'),
(1009,1,'Blessing of Light'),
(1010,2,'Blessings'),
(1011,2,'Warrior Shouts'),
(1015,3,'Major Armor Debuffs'),
(1016,3,'Faerie Fire'),
(1019,3,'Minor Armor Debuffs'),
(1022,3,'Melee Haste Buffs'),
(1023,4,'Leader of the Pack'),
(1024,4,'Rampage'),
(1025,3,'Physical Crit Buffs'),
(1029,1,'Percentage AP Buffs'),
(1033,1,'Bleed Debuffs'),
(1036,4,'Spell Crit Buffs'),
(1037,3,'Spell Crit Debuffs'),
(1038,3,'All Stats Percentage with Sanctuary'),
(1046,4,'Totem of Wrath'),
(1048,4,'Spell Power Buffs'),
(1051,3,'Spell Hit Debuffs'),
(1054,3,'Haste Buffs'),
(1056,3,'Damage Done Buffs'),
(1058,3,'Poisons'),
(1059,3,'Attack Speed Debuffs'),
(1060,3,'Hit Chance Debuffs'),
(1061,4,'Healing Taken Debuffs'),
(1062,4,'AP Debuffs'),
(1083,4,'Single Intellect Buffs'),
(1084,4,'Single Stamina Buffs'),
(1085,4,'Single Spirit Buffs'),
(1086,4,'Armor Buffs'),
(1087,1,'Scrolls'),
(1088,4,'Strength and Agility Buffs'),
(1089,4,'Mark of the Wild'),
(1091,0,'Commanding Shout'),
(1092,0,'Blood Pact'),
(1093,4,'Flat HP Buffs'),
(1094,3,'Healing Taken Buffs'),
(1095,4,'Physical Taken Buffs'),
(1096,4,'Cast Time Debuffs'),
(1097,1,'Frost Novals'),
(1098,4,'Shadow Protection'),
(1099,2,'Immolate and Unstable Affliction'),
(1100,1,'Dampen/Amplify Magic'),
(1101,3,'Spell Damage Taken Debuffs'),
(1104,1,'Warrior Enrages'),
(1105,3,'MP5 Buffs'),
(1106,1,'Heroic Presence'),
(1107,4,'Temporary Damage Increases'),
(1108,4,'Phys Damage Taken Debuffs'),
(1110,1,'Corporeality'),
(1111,1,'Champion\'s Pennants'),
(1112,1,'Flip Out'),
(1113,4,'Thorns'),
(1121,1,'Elemental Slave Buffs'),
(1122,3,'Temporary Haste Buffs'),
(1123,4,'Power Infusion and Arcane Power'),
(1124,3,'Intellect Buffs'),
(1125,3,'Spirit Buffs'),
(1126,3,'Stamina Buffs');
/*!40000 ALTER TABLE `spell_group_stack_rules` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:36
