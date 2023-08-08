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
	(400, 5, 9999999, 'Forge Skills', 2018, 'Interface\\AddOns\\ForgedWoW\\UI\\spellbook_base', 5, 99),
	(401, 1, 32767, 'Arms', 9347, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\warrior-arms', 0, 98),
	(402, 1, 32767, 'Fury', 20375, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\warrior-fury', 0, 97),
	(403, 1, 32767, 'Protection', 71, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\warrior-protection', 0, 96),
	(404, 1, 32767, 'Class Specialization', 635, '""', 7, 95),
	(802, 8, 32767, 'Assassination', 8623, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\rogue-assassination', 0, 98),
	(803, 8, 32767, 'Combat', 53, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\rogue-combat', 0, 97),
	(804, 8, 32767, 'Subtlety', 1784, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\rogue-subtlety', 0, 96),
	(822, 2, 32767, 'Holy', 66112, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\paladin-holy', 0, 96),
	(823, 2, 32767, 'Protection', 53709, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\paladin-protection', 0, 97),
	(824, 2, 32767, 'Retribution', 54043, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\paladin-retribution', 0, 98),
	(825, 4, 32767, 'Beast Mastery', 58923, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\hunter-beastmastery', 0, 96),
	(826, 4, 32767, 'Marksmanship', 53620, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\hunter-marksmanship', 0, 97),
	(827, 4, 32767, 'Survival', 53301, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\hunter-survival', 0, 98),
	(831, 16, 32767, 'Holy', 47788, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\priest-holy', 0, 97),
	(832, 16, 32767, 'Discipline', 9800, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\priest-discipline', 0, 96),
	(833, 16, 32767, 'Shadow', 589, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\priest-shadow', 0, 98),
	(834, 32, 32767, 'Blood', 50689, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\deathknight-blood', 0, 96),
	(835, 32, 32767, 'Frost', 50384, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\deathknight-frost', 0, 97),
	(836, 32, 32767, 'Unholy', 50391, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\deathknight-unholy', 0, 98),
	(837, 64, 32767, 'Elemental', 54843, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\shaman-elemental', 0, 96),
	(838, 64, 32767, 'Enhancement', 51521, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\shaman-enhancement', 0, 97),
	(839, 64, 32767, 'Restoration', 41114, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\shaman-restoration', 0, 98),
	(840, 128, 32767, 'Arcane', 1459, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\mage-arcane', 0, 96),
	(841, 128, 32767, 'Fire', 42833, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\mage-fire', 0, 97),
	(842, 128, 32767, 'Frost', 116, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\mage-frost', 0, 98),
	(843, 256, 32767, 'Affliction', 47541, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\warlock-affliction', 0, 96),
	(844, 256, 32767, 'Demonology', 40506, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\warlock-demonology', 0, 97),
	(845, 256, 32767, 'Destruction', 5740, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\warlock-destruction', 0, 98),
	(846, 1024, 32767, 'Balance', 20687, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\druid-balance', 0, 96),
	(847, 1024, 32767, 'Feral Combat', 768, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\druid-feral', 0, 97),
	(848, 1024, 32767, 'Restoration', 5185, 'Interface\\AddOns\\ForgedWoW\\UI\\SpecBG\\druid-restoration', 0, 98),
	(999900, 5, 9999999, 'Racials', 6562, 'Interface\\AddOns\\ForgedWoW\\UI\\racial', 5, 0),
	(1980000, 5, 9999999, 'Prestige', 56902, 'Interface\\AddOns\\ForgedWoW\\UI\\prestige', 5, 0);
/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
