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

-- Dumpar struktur för tabell acore_world.playercreateinfo_spell_custom
DROP TABLE IF EXISTS `playercreateinfo_spell_custom`;
CREATE TABLE IF NOT EXISTS `playercreateinfo_spell_custom` (
  `racemask` INT unsigned NOT NULL DEFAULT 0,
  `classmask` INT unsigned NOT NULL DEFAULT 0,
  `Spell` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `Note` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`racemask`,`classmask`,`Spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.playercreateinfo_spell_custom: 0 rows
DELETE FROM `playercreateinfo_spell_custom`;
/*!40000 ALTER TABLE `playercreateinfo_spell_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `playercreateinfo_spell_custom` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
