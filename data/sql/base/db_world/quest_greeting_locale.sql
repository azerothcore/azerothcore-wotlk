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

-- Dumping structure for table acore_world.quest_greeting_locale
DROP TABLE IF EXISTS `quest_greeting_locale`;
CREATE TABLE IF NOT EXISTS `quest_greeting_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Greeting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`type`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.quest_greeting_locale: ~5 rows (approximately)
DELETE FROM `quest_greeting_locale`;
INSERT INTO `quest_greeting_locale` (`ID`, `type`, `locale`, `Greeting`, `VerifiedBuild`) VALUES
	(3390, 0, 'esES', 'Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.', 47014),
	(3390, 0, 'esMX', 'Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.', 47014),
	(5638, 0, 'esES', 'Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?', NULL),
	(5638, 0, 'esMX', 'Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?', NULL),
	(22292, 0, 'ruRU', 'Свет ещё не воссиял над Скеттисом.', 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
