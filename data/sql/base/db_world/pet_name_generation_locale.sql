-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.pet_name_generation_locale
DROP TABLE IF EXISTS `pet_name_generation_locale`;
CREATE TABLE IF NOT EXISTS `pet_name_generation_locale` (
  `ID` int unsigned NOT NULL,
  `Locale` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Word` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Half` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`Locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.pet_name_generation_locale: ~106 rows (approximately)
DELETE FROM `pet_name_generation_locale`;
INSERT INTO `pet_name_generation_locale` (`ID`, `Locale`, `Word`, `Entry`, `Half`) VALUES
	(261, 'esES', 'piedras', 26125, 1),
	(261, 'esMX', 'piedras', 26125, 1),
	(262, 'esES', 'rocas', 26125, 1),
	(262, 'esMX', 'rocas', 26125, 1),
	(263, 'esES', 'ojos', 26125, 1),
	(263, 'esMX', 'ojos', 26125, 1),
	(264, 'esES', 'tierra', 26125, 1),
	(264, 'esMX', 'tierra', 26125, 1),
	(265, 'esES', 'sepulcros', 26125, 1),
	(265, 'esMX', 'sepulcros', 26125, 1),
	(266, 'esES', 'murciélagos', 26125, 1),
	(266, 'esMX', 'murciélagos', 26125, 1),
	(267, 'esES', 'ratas', 26125, 1),
	(267, 'esMX', 'ratas', 26125, 1),
	(268, 'esES', 'cuerpos', 26125, 1),
	(268, 'esMX', 'cuerpos', 26125, 1),
	(269, 'esES', 'tumbas', 26125, 1),
	(269, 'esMX', 'tumbas', 26125, 1),
	(270, 'esES', 'carroña', 26125, 1),
	(270, 'esMX', 'carroña', 26125, 1),
	(271, 'esES', 'cráneos', 26125, 1),
	(271, 'esMX', 'cráneos', 26125, 1),
	(272, 'esES', 'huesos', 26125, 1),
	(272, 'esMX', 'huesos', 26125, 1),
	(273, 'esES', 'criptas', 26125, 1),
	(273, 'esMX', 'criptas', 26125, 1),
	(274, 'esES', 'costillas', 26125, 1),
	(274, 'esMX', 'costillas', 26125, 1),
	(275, 'esES', 'cerebros', 26125, 1),
	(275, 'esMX', 'cerebros', 26125, 1),
	(276, 'esES', 'sarcófagos', 26125, 1),
	(276, 'esMX', 'sarcófagos', 26125, 1),
	(277, 'esES', 'podredumbre', 26125, 1),
	(277, 'esMX', 'podredumbre', 26125, 1),
	(278, 'esES', 'gravilla', 26125, 1),
	(278, 'esMX', 'gravilla', 26125, 1),
	(279, 'esES', 'plaga', 26125, 1),
	(279, 'esMX', 'plaga', 26125, 1),
	(280, 'esES', 'ataúdes', 26125, 1),
	(280, 'esMX', 'ataúdes', 26125, 1),
	(281, 'esES', 'miembros', 26125, 1),
	(281, 'esMX', 'miembros', 26125, 1),
	(282, 'esES', 'gusanos', 26125, 1),
	(282, 'esMX', 'gusanos', 26125, 1),
	(283, 'esES', 'suelos', 26125, 1),
	(283, 'esMX', 'suelos', 26125, 1),
	(284, 'esES', 'espinas', 26125, 1),
	(284, 'esMX', 'espinas', 26125, 1),
	(285, 'esES', 'guijarros', 26125, 1),
	(285, 'esMX', 'guijarros', 26125, 1),
	(286, 'esES', 'raíces', 26125, 1),
	(286, 'esMX', 'raíces', 26125, 1),
	(287, 'esES', 'médulas', 26125, 1),
	(287, 'esMX', 'médulas', 26125, 1),
	(288, 'esES', 'martillos', 26125, 1),
	(288, 'esMX', 'martillos', 26125, 1),
	(289, 'esES', 'Devasta', 26125, 0),
	(289, 'esMX', 'Devasta', 26125, 0),
	(290, 'esES', 'Mastica', 26125, 0),
	(290, 'esMX', 'Mastica', 26125, 0),
	(291, 'esES', 'Tritura', 26125, 0),
	(291, 'esMX', 'Tritura', 26125, 0),
	(292, 'esES', 'Machaca', 26125, 0),
	(292, 'esMX', 'Machaca', 26125, 0),
	(293, 'esES', 'Salta', 26125, 0),
	(293, 'esMX', 'Salta', 26125, 0),
	(294, 'esES', 'Afila', 26125, 0),
	(294, 'esMX', 'Afila', 26125, 0),
	(295, 'esES', 'Acosa', 26125, 0),
	(295, 'esMX', 'Acosa', 26125, 0),
	(296, 'esES', 'Engulle', 26125, 0),
	(296, 'esMX', 'Engulle', 26125, 0),
	(297, 'esES', 'Come', 26125, 0),
	(297, 'esMX', 'Come', 26125, 0),
	(298, 'esES', 'Golpea', 26125, 0),
	(298, 'esMX', 'Golpea', 26125, 0),
	(299, 'esES', 'Masca', 26125, 0),
	(299, 'esMX', 'Masca', 26125, 0),
	(300, 'esES', 'Destripa', 26125, 0),
	(300, 'esMX', 'Destripa', 26125, 0),
	(301, 'esES', 'Trocea', 26125, 0),
	(301, 'esMX', 'Trocea', 26125, 0),
	(302, 'esES', 'Roe', 26125, 0),
	(302, 'esMX', 'Roe', 26125, 0),
	(303, 'esES', 'Desolla', 26125, 0),
	(303, 'esMX', 'Desolla', 26125, 0),
	(304, 'esES', 'Retumba', 26125, 0),
	(304, 'esMX', 'Retumba', 26125, 0),
	(305, 'esES', 'Muerde', 26125, 0),
	(305, 'esMX', 'Muerde', 26125, 0),
	(306, 'esES', 'Rompe', 26125, 0),
	(306, 'esMX', 'Rompe', 26125, 0),
	(307, 'esES', 'Guarda', 26125, 0),
	(307, 'esMX', 'Guarda', 26125, 0),
	(308, 'esES', 'Seca', 26125, 0),
	(308, 'esMX', 'Seca', 26125, 0),
	(309, 'esES', 'Atraca', 26125, 0),
	(309, 'esMX', 'Atraca', 26125, 0),
	(310, 'esES', 'Roba', 26125, 0),
	(310, 'esMX', 'Roba', 26125, 0),
	(311, 'esES', 'Captura', 26125, 0),
	(311, 'esMX', 'Captura', 26125, 0),
	(312, 'esES', 'Bebe', 26125, 0),
	(312, 'esMX', 'Bebe', 26125, 0),
	(313, 'esES', 'Rebana', 26125, 0),
	(313, 'esMX', 'Rebana', 26125, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
