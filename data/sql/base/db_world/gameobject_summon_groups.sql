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
-- Table structure for table `gameobject_summon_groups`
--

DROP TABLE IF EXISTS `gameobject_summon_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameobject_summon_groups` (
  `summonerId` int unsigned NOT NULL DEFAULT '0',
  `summonerType` tinyint unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint unsigned NOT NULL DEFAULT '0',
  `entry` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `rotation0` float NOT NULL DEFAULT '0',
  `rotation1` float NOT NULL DEFAULT '0',
  `rotation2` float NOT NULL DEFAULT '0',
  `rotation3` float NOT NULL DEFAULT '0',
  `respawnTime` int unsigned NOT NULL DEFAULT '120',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_summon_groups`
--

LOCK TABLES `gameobject_summon_groups` WRITE;
/*!40000 ALTER TABLE `gameobject_summon_groups` DISABLE KEYS */;
INSERT INTO `gameobject_summon_groups` VALUES
(2289,1,0,2332,-14652.4,146.512,3.50118,0.349065,0,0,0.173648,0.984808,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14652.9,146.867,2.50691,2.9496,0,0,0.995396,0.0958512,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14653,146.524,2.35559,6.00393,0,0,-0.139173,0.990268,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14653,145.138,2.65327,5.84685,0,0,-0.216439,0.976296,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14654,147.306,2.46731,0.942477,0,0,0.45399,0.891007,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14654.5,147.324,2.45636,1.81514,0,0,0.788011,0.615662,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14654.7,146.142,2.08906,2.37364,0,0,0.927183,0.374608,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14654.9,147.278,2.42524,5.88176,0,0,-0.199368,0.979925,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14655.1,146.671,2.23095,2.65289,0,0,0.970295,0.241925,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14655.3,147.802,2.63972,6.16101,0,0,-0.0610485,0.998135,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14656.2,147.096,2.38777,0.174532,0,0,0.0871553,0.996195,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2332,-14656.8,148.893,3.28866,5.09636,0,0,-0.559193,0.829038,120,'Enticing Negolash - Barbequed Buzzard Wings'),
(2289,1,0,2333,-14653,145.389,2.852,4.85202,0,0,-0.656058,0.75471,120,'Enticing Negolash - Stranglevine Wine'),
(2289,1,0,2333,-14655.7,148.978,4.0564,3.47321,0,0,-0.986285,0.16505,120,'Enticing Negolash - Stranglevine Wine'),
(2289,1,0,2333,-14656.4,147.595,3.12908,1.58825,0,0,0.71325,0.70091,120,'Enticing Negolash - Stranglevine Wine'),
(2289,1,0,2333,-14656.8,147.434,3.10207,3.01941,0,0,0.998135,0.0610518,120,'Enticing Negolash - Stranglevine Wine'),
(2289,1,0,2333,-14657.2,148.228,2.88632,1.53589,0,0,0.694658,0.71934,120,'Enticing Negolash - Stranglevine Wine'),
(2289,1,0,2562,-14652.4,145.753,3.25464,2.93214,0,0,0.994521,0.104536,120,'Enticing Negolash - Baked Bread'),
(2289,1,0,2562,-14653.8,146.204,2.14631,4.88692,0,0,-0.642787,0.766045,120,'Enticing Negolash - Baked Bread'),
(2289,1,0,2562,-14656.1,148.367,3.51564,5.63741,0,0,-0.317305,0.948324,120,'Enticing Negolash - Baked Bread'),
(30871,0,0,192946,571.367,-322.152,110.503,2.96704,0,0,0.996194,0.087165,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192946,571.532,-321.752,110.711,5.044,0,0,-0.580703,0.814116,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192946,572.012,-321.806,110.51,0.977383,0,0,0.469471,0.882948,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192947,571.228,-322.263,110.315,5.49779,0,0,-0.382683,0.92388,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192947,571.474,-322.023,110.322,2.35619,0,0,0.92388,0.382683,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192947,571.649,-321.839,110.531,5.65487,0,0,-0.309016,0.951057,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192947,571.791,-321.695,110.336,5.49779,0,0,-0.382683,0.92388,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192948,571.728,-321.827,110.732,6.26573,0,0,-0.00872612,0.999962,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192949,571.046,-322.154,110.6,0.994837,0,0,0.477159,0.878817,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192949,571.21,-321.93,110.489,1.41372,0,0,0.649447,0.760406,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192949,571.363,-322.444,110.497,0.0698117,0,0,0.0348988,0.999391,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192949,571.591,-322.228,110.587,0.523598,0,0,0.258819,0.965926,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192949,571.678,-321.49,110.48,0.645772,0,0,0.317305,0.948324,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192949,571.842,-321.624,110.564,4.69494,0,0,-0.71325,0.70091,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.137,-322.173,110.517,4.39823,0,0,-0.809016,0.587786,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.265,-322.012,110.711,4.90438,0,0,-0.636078,0.771625,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.327,-322.26,110.565,1.8675,0,0,0.803857,0.594823,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.371,-322.319,110.642,1.18682,0,0,0.559193,0.829038,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.498,-321.629,110.731,1.95477,0,0,0.829038,0.559193,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.552,-322.062,110.53,0.95993,0,0,0.461748,0.887011,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(30871,0,0,192950,571.88,-321.668,110.502,1.18682,0,0,0.559193,0.829038,7200,'Brigg Smallshanks - Quest Junk In My Trunk'),
(1557,1,0,1558,2485.39,22.1752,27.5909,4.20625,0,0,-0.861629,0.507539,120,'Lillith\'s Dinner Table - Candle of Beckoning'),
(3737,1,0,3743,-1271.31,-3013.2,71.9223,0.488691,0,0,0.241921,0.970296,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1272.33,-3010.5,71.3295,5.60251,0,0,-0.333807,0.942641,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1272.46,-3016.28,72.8214,0.59341,0,0,0.292371,0.956305,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1273.74,-3017.27,73.0493,3.78737,0,0,-0.948323,0.317306,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1274.77,-3008.18,71.5097,0,0,0,0,1,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1275.6,-3016.53,72.6837,3.50812,0,0,-0.983254,0.182238,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1277.43,-3009.51,71.5239,0,0,0,0,1,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1278.46,-3015.85,72.2563,0,0,0,0,1,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1279.01,-3010.59,71.5588,2.07694,0,0,0.861629,0.507539,120,'Bubbling Fissure - Fissure Plant'),
(3737,1,0,3743,-1279.74,-3013.78,71.5814,3.80482,0,0,-0.945518,0.325568,120,'Bubbling Fissure - Fissure Plant');
/*!40000 ALTER TABLE `gameobject_summon_groups` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15 20:38:39
