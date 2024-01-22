-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.spell_group_stack_rules
DROP TABLE IF EXISTS `spell_group_stack_rules`;
CREATE TABLE IF NOT EXISTS `spell_group_stack_rules` (
  `group_id` int unsigned NOT NULL DEFAULT '0',
  `stack_rule` tinyint NOT NULL DEFAULT '0',
  `description` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.spell_group_stack_rules: ~37 rows (approximately)
DELETE FROM `spell_group_stack_rules`;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES
	(1, 4, 'Group of Battle / Guardian Elixirs, stacking done with exclusive flags'),
	(1001, 8, 'Group of Food (Well Fed) and similar buffs'),
	(1002, 19, 'Group of blessings, warrior shouts (with HP increasing buffs), stack for different casters, effect exclusive COMBINED GROUP'),
	(1003, 17, 'Group of major Armor reducing debuffs'),
	(1004, 18, 'Group of minor Armor reducing debuffs (with hit reduce), can stack for different casters, effect exclusive with exclusive flags COMBINED GROUP'),
	(1005, 16, 'Group of haste, contains forced stronger buff (use flagged, only 2 spells)'),
	(1006, 17, 'Group of Melee Crit chance increase, effect exclusive'),
	(1007, 17, 'Group of Percent AP increase, effect exclusive'),
	(1008, 1, 'Group of Bleed damage increasing auras'),
	(1009, 17, 'Group of Spell crit chance buffs, effect exclusive'),
	(1010, 1, 'Group of Spell crit taken increase debuffs'),
	(1011, 1, 'Group of Spell power increasing buffs'),
	(1012, 17, 'Group of Melee, Range, spell haste buffs (with raid damage done), effect exclusive COMBINED GROUP'),
	(1013, 1, 'Group of Critical chance taken debuff (all types)'),
	(1014, 18, 'Group of Melee attack time increse debufs, can stack for different casters, effect exclusive'),
	(1015, 18, 'Group of chance to hit reduce debuffs, can stack for different casters, effect exclusive'),
	(1016, 8, 'Group of healing taken reduce debuffs'),
	(1017, 17, 'Group of AP reducing debuffs, effect exclusive'),
	(1018, 17, 'Group of STR + AGI increasing buffs, effect exclusive'),
	(1019, 17, 'Group of INT and/or SPIRIT increasing buffs, effect exclusive'),
	(1020, 1, 'Group of healing recived increasing buffs'),
	(1021, 1, 'Group of physical damage taken reducing buffs'),
	(1022, 17, 'Group of casting speed decreasing debuffs, effect exclusive'),
	(1023, 25, 'Group of Armor + attributes + resistance increasing buffs'),
	(1024, 1, 'Group of STA increasing buffs, effect exclusive'),
	(1025, 1, 'Group of shadow resistance increasing buffs'),
	(1026, 2, 'Group of Immolate / Unstable Affliction - never stack for same caster'),
	(1027, 8, 'Group of amplify / dampen magic - never stack'),
	(1028, 18, 'Group of Magic damage taken increasing debuffs, effect exclusive'),
	(1029, 8, 'Group of Apexis buffs, never stack\r\nApexis buffs, never stack'),
	(1030, 1, 'Group of Draenei heroic presence (2 different auras)'),
	(1031, 16, 'Group of Death Wish and DK Hysteria, effect exclusive'),
	(1032, 17, 'Group of Spell Haste Auras'),
	(1033, 1, 'Group of Howling Rage'),
	(1034, 1, 'Group of Thorns'),
	(1112, 8, ''),
	(1113, 8, 'Ahn\'kahet - Potent Fogus and Mini');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
