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
-- Table structure for table `trainer`
--

DROP TABLE IF EXISTS `trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainer` (
  `Id` int unsigned NOT NULL DEFAULT '0',
  `Type` tinyint unsigned NOT NULL DEFAULT '2',
  `Requirement` mediumint unsigned NOT NULL DEFAULT '0',
  `Greeting` mediumtext COLLATE utf8mb4_general_ci,
  `VerifiedBuild` int DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainer`
--

LOCK TABLES `trainer` WRITE;
/*!40000 ALTER TABLE `trainer` DISABLE KEYS */;
INSERT INTO `trainer` VALUES
(1,0,1,'Hello, warrior!  Ready for some training?',0),
(2,0,1,'Hello, warrior!  Ready for some training?',0),
(3,0,2,'Hello, paladin!  Ready for some training?',0),
(4,0,2,'Hello, paladin!  Ready for some training?',0),
(5,0,2,'Hello, paladin!  Ready for some training?',0),
(6,0,2,'Hello, paladin!  Ready for some training?',0),
(7,0,3,'Hello, hunter!  Ready for some training?',0),
(8,0,3,'Hello, hunter!  Ready for some training?',0),
(9,0,4,'Hello, rogue!  Ready for some training?',0),
(10,0,4,'Hello, rogue!  Ready for some training?',0),
(11,0,5,'Hello, priest!  Ready for some training?',0),
(12,0,5,'Hello, priest!  Ready for some training?',0),
(13,0,6,'Well met, Death Knight.  Ready for some training?',0),
(14,0,7,'Hello, shaman!  Ready for some training?',0),
(15,0,7,'Hello, shaman!  Ready for some training?',0),
(16,0,8,'Hello, mage!  Ready for some training?',0),
(17,0,8,'Hello, mage!  Ready for some training?',0),
(18,0,8,'Welcome!',0),
(19,0,8,'Welcome!',0),
(20,0,8,'Welcome!',0),
(21,0,8,'Welcome!',0),
(22,0,8,'Welcome!',0),
(23,0,8,'Welcome!',0),
(24,0,8,'Welcome!',0),
(25,0,8,'Welcome!',0),
(26,0,8,'Welcome!',0),
(27,0,8,'Welcome!',0),
(28,0,8,'Welcome!',0),
(29,0,8,'Welcome!',0),
(30,0,8,'Welcome!',0),
(31,0,9,'Hello, warlock!  Ready for some training?',0),
(32,0,9,'Hello, warlock!  Ready for some training?',0),
(33,0,11,'Hello, druid!  Ready for some training?',0),
(34,0,11,'Hello, druid!  Ready for some training?',0),
(35,1,0,'Hello!  Can I teach you something?',0),
(36,1,0,'Hello!  Can I teach you something?',0),
(37,1,0,'Hello!  Can I teach you something?',0),
(38,1,0,'Hello!  Can I teach you something?',0),
(39,1,0,'Hello!  Can I teach you something?',0),
(40,1,0,'Hello!  Can I teach you something?',0),
(41,1,0,'Hello!  Can I teach you something?',0),
(42,1,0,'Hello!  Can I teach you something?',0),
(43,1,0,'Hello!  Can I teach you something?',0),
(44,1,0,'Hello!  Can I teach you something?',0),
(45,1,0,'Hello!  Can I teach you something?',0),
(46,1,0,'Hello!  Can I teach you something?',0),
(47,2,0,'Hello!  Ready for some training?',0),
(48,2,0,'Hello!  Ready for some training?',0),
(49,2,0,'Hello!  Ready for some training?',0),
(50,2,0,'Hello!  Ready for some training?',0),
(51,2,0,'Hello!  Ready for some training?',0),
(52,2,0,'Hello!  Ready for some training?',0),
(53,2,0,'Hello!  Ready for some training?',0),
(54,2,0,'Hello!  Ready for some training?',0),
(55,2,0,'Hello!  Ready for some training?',0),
(56,2,0,'Hello!  Ready for some training?',0),
(57,2,0,'Hello!  Ready for some training?',0),
(58,2,0,'Care to learn how to turn the ore that you find into weapons and metal armor?',0),
(59,2,0,'Care to learn how to turn the ore that you find into weapons and metal armor?',0),
(60,2,0,'Care to learn how to turn the ore that you find into weapons and metal armor?',0),
(61,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(62,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(63,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(64,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(65,2,0,'With alchemy you can turn found herbs into healing and other types of potions.',0),
(66,2,0,'With alchemy you can turn found herbs into healing and other types of potions.',0),
(67,2,0,'With alchemy you can turn found herbs into healing and other types of potions.',0),
(68,2,0,'With alchemy you can turn found herbs into healing and other types of potions.',0),
(69,2,0,'Searching for herbs requires both knowledge and instinct.',0),
(70,2,0,'Searching for herbs requires both knowledge and instinct.',0),
(71,2,0,'Searching for herbs requires both knowledge and instinct.',0),
(72,2,0,'Greetings!  Can I teach you how to turn found cloth into cloth armor?',0),
(73,2,0,'Greetings!  Can I teach you how to turn found cloth into cloth armor?',0),
(74,2,0,'Greetings!  Can I teach you how to turn found cloth into cloth armor?',0),
(75,2,0,'Can I teach you how to turn the meat you find on beasts into a feast?',0),
(76,2,0,'Can I teach you how to turn the meat you find on beasts into a feast?',0),
(77,2,0,'Can I teach you how to turn the meat you find on beasts into a feast?',0),
(78,2,0,'You have not lived until you have dug deep into the earth.',0),
(79,2,0,'You have not lived until you have dug deep into the earth.',0),
(80,2,0,'You have not lived until you have dug deep into the earth.',0),
(81,2,0,'Here, let me show you how to bind those wounds....',0),
(82,2,0,'Here, let me show you how to bind those wounds....',0),
(83,2,0,'Here, let me show you how to bind those wounds....',0),
(84,2,0,'Engineering is very simple once you grasp the basics.',0),
(85,2,0,'Engineering is very simple once you grasp the basics.',0),
(86,2,0,'Engineering is very simple once you grasp the basics.',0),
(87,2,0,'Engineering is very simple once you grasp the basics.',0),
(88,2,0,'Engineering is very simple once you grasp the basics.',0),
(89,2,0,'Engineering is very simple once you grasp the basics.',0),
(90,2,0,'Engineering is very simple once you grasp the basics.',0),
(91,2,0,'Engineering is very simple once you grasp the basics.',0),
(92,2,0,'Engineering is very simple once you grasp the basics.',0),
(93,2,0,'There is no treat finer than Barbecued Buzzard Wing.',0),
(94,2,0,'Enchanting is the art of improving existing items through magic.',0),
(95,2,0,'Enchanting is the art of improving existing items through magic.',0),
(96,2,0,'Enchanting is the art of improving existing items through magic.',0),
(97,2,0,'I can teach you how to use a fishing pole to catch fish.',0),
(98,2,0,'I can teach you how to use a fishing pole to catch fish.',0),
(99,2,0,'I can teach you how to use a fishing pole to catch fish.',0),
(100,2,0,'It requires a steady hand to remove the leather from a slain beast.',0),
(101,2,0,'It requires a steady hand to remove the leather from a slain beast.',0),
(102,2,0,'It requires a steady hand to remove the leather from a slain beast.',0),
(103,2,0,'Engineering is very simple once you grasp the basics.',0),
(104,2,0,'Care to learn how to turn the ore that you find into weapons and metal armor?',0),
(105,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(106,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(107,2,0,'Greetings!  Can I teach you how to turn beast hides into armor?',0),
(108,2,0,'Greetings!  Can I teach you how to turn found cloth into cloth armor?',0),
(109,2,0,'Engineering is very simple once you grasp the basics.',0),
(110,2,0,'You have not lived until you have dug deep into the earth.',0),
(111,2,0,'Greetings!  Can I teach you how to cut precious gems and craft jewelry?',0),
(112,2,0,'Greetings!  Can I teach you how to cut precious gems and craft jewelry?',0),
(113,2,0,'Greetings!  Can I teach you how to cut precious gems and craft jewelry?',0),
(114,2,0,'Enchanting is the art of improving existing items through magic.',0),
(115,2,0,'Engineering is very simple once you grasp the basics.',0),
(116,2,0,'Engineering is very simple once you grasp the basics.',0),
(117,2,0,'Can I teach you how to turn the meat you find on beasts into a feast?',0),
(118,2,0,'Engineering is very simple once you grasp the basics.',0),
(119,2,0,'Would you like to learn the intricacies of inscription?',0),
(120,2,0,'Would you like to learn the intricacies of inscription?',0),
(121,2,0,'Would you like to learn the intricacies of inscription?',0),
(122,2,0,'With alchemy you can turn found herbs into healing and other types of potions.',0),
(123,2,0,'Care to learn how to turn the ore that you find into weapons and metal armor?',0),
(124,2,0,'Care to learn how to turn the ore that you find into weapons and metal armor?',0),
(125,3,0,'',0),
(126,3,0,'Can I teach you how to turn the meat you find on beasts into a feast?',0);
/*!40000 ALTER TABLE `trainer` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:44
