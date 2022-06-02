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

-- Dumpar struktur för tabell acore_world.spell_proc
DROP TABLE IF EXISTS `spell_proc`;
CREATE TABLE IF NOT EXISTS `spell_proc` (
  `spellId` MEDIUMINT NOT NULL DEFAULT 0,
  `schoolMask` TINYINT NOT NULL DEFAULT 0,
  `spellFamilyName` SMALLINT unsigned NOT NULL DEFAULT 0,
  `spellFamilyMask0` INT unsigned NOT NULL DEFAULT 0,
  `spellFamilyMask1` INT unsigned NOT NULL DEFAULT 0,
  `spellFamilyMask2` INT unsigned NOT NULL DEFAULT 0,
  `typeMask` INT unsigned NOT NULL DEFAULT 0,
  `spellTypeMask` INT unsigned NOT NULL DEFAULT 0,
  `spellPhaseMask` INT NOT NULL DEFAULT 0,
  `hitMask` INT NOT NULL DEFAULT 0,
  `attributesMask` INT unsigned NOT NULL DEFAULT 0,
  `ratePerMinute` float NOT NULL DEFAULT 0,
  `chance` float NOT NULL DEFAULT 0,
  `cooldown` float NOT NULL DEFAULT 0,
  `charges` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`spellId`),
  CONSTRAINT `spell_proc_chk_1` CHECK ((`cooldown` >= 0))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.spell_proc: 0 rows
DELETE FROM `spell_proc`;
/*!40000 ALTER TABLE `spell_proc` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_proc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
