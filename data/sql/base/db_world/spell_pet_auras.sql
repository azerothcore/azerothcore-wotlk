-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_world.spell_pet_auras
DROP TABLE IF EXISTS `spell_pet_auras`;
CREATE TABLE IF NOT EXISTS `spell_pet_auras` (
  `spell` mediumint unsigned NOT NULL COMMENT 'dummy spell id',
  `effectId` tinyint unsigned NOT NULL DEFAULT '0',
  `pet` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'pet id; 0 = all',
  `aura` mediumint unsigned NOT NULL COMMENT 'pet aura id',
  PRIMARY KEY (`spell`,`effectId`,`pet`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.spell_pet_auras: 49 rows
DELETE FROM `spell_pet_auras`;
/*!40000 ALTER TABLE `spell_pet_auras` DISABLE KEYS */;
INSERT INTO `spell_pet_auras` (`spell`, `effectId`, `pet`, `aura`) VALUES
	(19028, 0, 0, 25228),
	(19578, 0, 0, 19579),
	(20895, 0, 0, 24529),
	(23785, 0, 416, 23759),
	(23785, 0, 417, 23762),
	(23785, 0, 1860, 23760),
	(23785, 0, 1863, 23761),
	(23785, 0, 17252, 35702),
	(23822, 0, 416, 23826),
	(23822, 0, 417, 23837),
	(23822, 0, 1860, 23841),
	(23822, 0, 1863, 23833),
	(23822, 0, 17252, 35703),
	(23823, 0, 416, 23827),
	(23823, 0, 417, 23838),
	(23823, 0, 1860, 23842),
	(23823, 0, 1863, 23834),
	(23823, 0, 17252, 35704),
	(23824, 0, 416, 23828),
	(23824, 0, 417, 23839),
	(23824, 0, 1860, 23843),
	(23824, 0, 1863, 23835),
	(23824, 0, 17252, 35705),
	(23825, 0, 416, 23829),
	(23825, 0, 417, 23840),
	(23825, 0, 1860, 23844),
	(23825, 0, 1863, 23836),
	(23825, 0, 17252, 35706),
	(28757, 0, 0, 28758),
	(34453, 1, 0, 68361),
	(34454, 1, 0, 68361),
	(34455, 0, 0, 75593),
	(34459, 0, 0, 75446),
	(34460, 0, 0, 75447),
	(35029, 0, 0, 35060),
	(35030, 0, 0, 35061),
	(35691, 0, 0, 35696),
	(35692, 0, 0, 35696),
	(35693, 0, 0, 35696),
	(56314, 0, 0, 57447),
	(56314, 1, 0, 57485),
	(56315, 0, 0, 57452),
	(56315, 1, 0, 57484),
	(56316, 0, 0, 57453),
	(56316, 1, 0, 57483),
	(56317, 0, 0, 57457),
	(56317, 1, 0, 57482),
	(56318, 0, 0, 57458),
	(56318, 1, 0, 57475);
/*!40000 ALTER TABLE `spell_pet_auras` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
