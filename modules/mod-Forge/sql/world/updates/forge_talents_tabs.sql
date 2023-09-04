-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.42-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for acore_world
CREATE DATABASE IF NOT EXISTS `acore_world` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `acore_world`;

-- Dumping structure for table acore_world.forge_talent_tabs
CREATE TABLE IF NOT EXISTS `forge_talent_tabs` (
  `id` int(10) unsigned NOT NULL,
  `classMask` int(10) unsigned NOT NULL,
  `raceMask` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `spellIcon` mediumint(8) unsigned NOT NULL,
  `background` text NOT NULL,
  `tabType` int(10) unsigned NOT NULL,
  `TabIndex` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table acore_world.forge_talent_tabs: ~36 rows (approximately)
INSERT INTO `forge_talent_tabs` (`id`, `classMask`, `raceMask`, `name`, `spellIcon`, `background`, `tabType`, `TabIndex`) VALUES
	(401, 1, 32767, 'Arms', 9347, 'SpecBG\\warrior-arms', 0, 98),
	(402, 1, 32767, 'Fury', 20375, 'SpecBG\\warrior-fury', 0, 97),
	(403, 1, 32767, 'Protection', 71, 'SpecBG\\warrior-prot', 0, 96),
	(404, 1, 32767, 'Class Specialization', 635, '""', 7, 95),
	(802, 8, 32767, 'Assassination', 8623, 'SpecBG\\rogue-ass', 0, 98),
	(803, 8, 32767, 'Combat', 53, 'SpecBG\\rogue-cm', 0, 97),
	(804, 8, 32767, 'Subtlety', 1784, 'SpecBG\\rogue-sub', 0, 96),
	(822, 2, 32767, 'Holy', 66112, 'SpecBG\\paladin-holy', 0, 96),
	(823, 2, 32767, 'Protection', 53709, 'SpecBG\\paladin-protection', 0, 97),
	(824, 2, 32767, 'Retribution', 54043, 'SpecBG\\paladin-retribution', 0, 98),
	(825, 4, 32767, 'Beast Mastery', 58923, 'SpecBG\\hunter-bm', 0, 96),
	(826, 4, 32767, 'Marksmanship', 53620, 'SpecBG\\hunter-mm', 0, 97),
	(827, 4, 32767, 'Survival', 53301, 'SpecBG\\hunter-sv', 0, 98),
	(831, 16, 32767, 'Holy', 47788, 'SpecBG\\priest-holy', 0, 97),
	(832, 16, 32767, 'Discipline', 9800, 'SpecBG\\priest-disc', 0, 96),
	(833, 16, 32767, 'Shadow', 589, 'SpecBG\\priest-shadow', 0, 98),
	(834, 32, 32767, 'Blood', 50689, 'SpecBG\\deathknight-blood', 0, 96),
	(835, 32, 32767, 'Frost', 50384, 'SpecBG\\deathknight-frost', 0, 97),
	(836, 32, 32767, 'Unholy', 50391, 'SpecBG\\deathknight-unholy', 0, 98),
	(837, 64, 32767, 'Elemental', 54843, 'SpecBG\\shaman-elemental', 0, 96),
	(838, 64, 32767, 'Enhancement', 51521, 'SpecBG\\shaman-enh', 0, 97),
	(839, 64, 32767, 'Restoration', 41114, 'SpecBG\\shaman-resto', 0, 98),
	(840, 128, 32767, 'Arcane', 1459, 'SpecBG\\mage-arcane', 0, 96),
	(841, 128, 32767, 'Fire', 42833, 'SpecBG\\mage-fire', 0, 97),
	(842, 128, 32767, 'Frost', 116, 'SpecBG\\mage-frost', 0, 98),
	(843, 256, 32767, 'Affliction', 47541, 'SpecBG\\warlock-aff', 0, 96),
	(844, 256, 32767, 'Demonology', 40506, 'SpecBG\\warlock-demo', 0, 97),
	(845, 256, 32767, 'Destruction', 5740, 'SpecBG\\warlock-dest', 0, 98),
	(846, 1024, 32767, 'Balance', 20687, 'SpecBG\\druid-bal', 0, 96),
	(847, 1024, 32767, 'Feral Combat', 768, 'SpecBG\\druid-feral', 0, 97),
	(848, 1024, 32767, 'Restoration', 5185, 'SpecBG\\druid-resto', 0, 98),
	(999900, 2047, 32767, 'Racials', 6562, 'racial', 4, 0),
	(1980000, 2047, 32767, 'Prestige', 56902, 'prestige', 3, 0);
/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
