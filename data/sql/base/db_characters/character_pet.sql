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

-- Dumpar struktur för tabell acore_characters.character_pet
DROP TABLE IF EXISTS `character_pet`;
CREATE TABLE IF NOT EXISTS `character_pet` (
  `id` INT unsigned NOT NULL DEFAULT 0,
  `entry` INT unsigned NOT NULL DEFAULT 0,
  `owner` INT unsigned NOT NULL DEFAULT 0,
  `modelid` INT unsigned DEFAULT 0,
  `CreatedBySpell` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `PetType` TINYINT unsigned NOT NULL DEFAULT 0,
  `level` SMALLINT unsigned NOT NULL DEFAULT 1,
  `exp` INT unsigned NOT NULL DEFAULT 0,
  `Reactstate` TINYINT unsigned NOT NULL DEFAULT 0,
  `name` VARCHAR(21) NOT NULL DEFAULT 'Pet',
  `renamed` TINYINT unsigned NOT NULL DEFAULT 0,
  `slot` TINYINT unsigned NOT NULL DEFAULT 0,
  `curhealth` INT unsigned NOT NULL DEFAULT 1,
  `curmana` INT unsigned NOT NULL DEFAULT 0,
  `curhappiness` INT unsigned NOT NULL DEFAULT 0,
  `savetime` INT unsigned NOT NULL DEFAULT 0,
  `abdata` text,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `idx_slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Pet System';

-- Dumpar data för tabell acore_characters.character_pet: ~0 rows (ungefär)
DELETE FROM `character_pet`;
/*!40000 ALTER TABLE `character_pet` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_pet` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
