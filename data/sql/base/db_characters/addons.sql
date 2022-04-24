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

-- Dumpar struktur för tabell acore_characters.addons
DROP TABLE IF EXISTS `addons`;
CREATE TABLE IF NOT EXISTS `addons` (
  `name` VARCHAR(120) NOT NULL DEFAULT '',
  `crc` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Addons';

-- Dumpar data för tabell acore_characters.addons: ~23 rows (ungefär)
DELETE FROM `addons`;
/*!40000 ALTER TABLE `addons` DISABLE KEYS */;
INSERT INTO `addons` (`name`, `crc`) VALUES
	('Blizzard_AchievementUI', 1276933997),
	('Blizzard_ArenaUI', 1276933997),
	('Blizzard_AuctionUI', 1276933997),
	('Blizzard_BarbershopUI', 1276933997),
	('Blizzard_BattlefieldMinimap', 1276933997),
	('Blizzard_BindingUI', 1276933997),
	('Blizzard_Calendar', 1276933997),
	('Blizzard_CombatLog', 1276933997),
	('Blizzard_CombatText', 1276933997),
	('Blizzard_DebugTools', 1276933997),
	('Blizzard_GlyphUI', 1276933997),
	('Blizzard_GMChatUI', 1276933997),
	('Blizzard_GMSurveyUI', 1276933997),
	('Blizzard_GuildBankUI', 1276933997),
	('Blizzard_InspectUI', 1276933997),
	('Blizzard_ItemSocketingUI', 1276933997),
	('Blizzard_MacroUI', 1276933997),
	('Blizzard_RaidUI', 1276933997),
	('Blizzard_TalentUI', 1276933997),
	('Blizzard_TimeManager', 1276933997),
	('Blizzard_TokenUI', 1276933997),
	('Blizzard_TradeSkillUI', 1276933997),
	('Blizzard_TrainerUI', 1276933997);
/*!40000 ALTER TABLE `addons` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
