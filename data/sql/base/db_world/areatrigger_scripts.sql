-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица _acore_world.areatrigger_scripts
DROP TABLE IF EXISTS `areatrigger_scripts`;
CREATE TABLE IF NOT EXISTS `areatrigger_scripts` (
  `entry` mediumint(9) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.areatrigger_scripts: 122 rows
DELETE FROM `areatrigger_scripts`;
/*!40000 ALTER TABLE `areatrigger_scripts` DISABLE KEYS */;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
	(171, 'SmartTrigger'),
	(302, 'at_sentry_point'),
	(962, 'SmartTrigger'),
	(1447, 'SmartTrigger'),
	(1526, 'at_ring_of_law'),
	(1726, 'at_scent_larkorwi'),
	(1727, 'at_scent_larkorwi'),
	(1728, 'at_scent_larkorwi'),
	(1729, 'at_scent_larkorwi'),
	(1730, 'at_scent_larkorwi'),
	(1731, 'at_scent_larkorwi'),
	(1732, 'at_scent_larkorwi'),
	(1733, 'at_scent_larkorwi'),
	(1734, 'at_scent_larkorwi'),
	(1735, 'at_scent_larkorwi'),
	(1736, 'at_scent_larkorwi'),
	(1737, 'at_scent_larkorwi'),
	(1738, 'at_scent_larkorwi'),
	(1739, 'at_scent_larkorwi'),
	(1740, 'at_scent_larkorwi'),
	(2026, 'at_blackrock_stadium'),
	(2046, 'at_dragonspire_hall'),
	(3066, 'SmartTrigger'),
	(3546, 'at_bring_your_orphan_to'),
	(3547, 'at_bring_your_orphan_to'),
	(3548, 'at_bring_your_orphan_to'),
	(3549, 'at_bring_your_orphan_to'),
	(3551, 'at_bring_your_orphan_to'),
	(3552, 'at_bring_your_orphan_to'),
	(3587, 'at_ancient_leaf'),
	(3746, 'SmartTrigger'),
	(3766, 'SmartTrigger'),
	(4016, 'at_malfurion_stormrage'),
	(4017, 'at_twilight_grove'),
	(4113, 'at_thaddius_entrance'),
	(4356, 'at_bring_your_orphan_to'),
	(4422, 'at_area_52_entrance'),
	(4466, 'at_area_52_entrance'),
	(4471, 'at_area_52_entrance'),
	(4472, 'at_area_52_entrance'),
	(4479, 'SmartTrigger'),
	(4497, 'at_commander_dawnforge'),
	(4498, 'SmartTrigger'),
	(4524, 'at_shattered_halls_execution'),
	(4560, 'at_legion_teleporter'),
	(4575, 'SmartTrigger'),
	(4591, 'at_coilfang_waterfall'),
	(4665, 'SmartTrigger'),
	(4752, 'at_nats_landing'),
	(4820, 'at_brewfest'),
	(4829, 'at_brewfest'),
	(4838, 'SmartTrigger'),
	(4853, 'at_sunwell_madrigosa'),
	(4857, 'SmartTrigger'),
	(4858, 'SmartTrigger'),
	(4860, 'SmartTrigger'),
	(4871, 'SmartTrigger'),
	(4872, 'SmartTrigger'),
	(4873, 'SmartTrigger'),
	(4937, 'at_sunwell_eredar_twins'),
	(4951, 'SmartTrigger'),
	(4956, 'SmartTrigger'),
	(4990, 'SmartTrigger'),
	(5030, 'SmartTrigger'),
	(5046, 'at_sholazar_waygate'),
	(5047, 'at_sholazar_waygate'),
	(5056, 'SmartTrigger'),
	(5057, 'SmartTrigger'),
	(5058, 'SmartTrigger'),
	(5059, 'SmartTrigger'),
	(5060, 'SmartTrigger'),
	(5079, 'at_voltarus_middle'),
	(5080, 'SmartTrigger'),
	(5095, 'SmartTrigger'),
	(5096, 'SmartTrigger'),
	(5097, 'SmartTrigger'),
	(5098, 'SmartTrigger'),
	(5108, 'at_stormwright_shelf'),
	(5140, 'SmartTrigger'),
	(5173, 'SmartTrigger'),
	(5187, 'SmartTrigger'),
	(5190, 'SmartTrigger'),
	(5284, 'SmartTrigger'),
	(5285, 'SmartTrigger'),
	(5286, 'SmartTrigger'),
	(5287, 'SmartTrigger'),
	(5332, 'at_last_rites'),
	(5334, 'at_last_rites'),
	(5338, 'at_last_rites'),
	(5339, 'at_last_rites'),
	(5340, 'at_last_rites'),
	(5401, 'at_celestial_planetarium_enterance'),
	(5578, 'SmartTrigger'),
	(5579, 'SmartTrigger'),
	(5580, 'SmartTrigger'),
	(5589, 'SmartTrigger'),
	(5604, 'at_sindragosa_lair'),
	(5605, 'at_hor_shadow_throne'),
	(5616, 'at_icc_start_frostwing_gauntlet'),
	(5617, 'at_icc_start_frostwing_gauntlet'),
	(5618, 'at_icc_start_frostwing_gauntlet'),
	(5623, 'at_icc_gauntlet_event'),
	(5628, 'at_icc_spire_frostwyrm'),
	(5629, 'at_icc_spire_frostwyrm'),
	(5630, 'at_icc_spire_frostwyrm'),
	(5631, 'at_icc_spire_frostwyrm'),
	(5632, 'at_hor_battered_hilt_start'),
	(5633, 'at_tyrannus_event_starter'),
	(5647, 'at_icc_putricide_trap'),
	(5649, 'at_icc_shutdown_traps'),
	(5650, 'at_q24545_frostmourne_cavern'),
	(5660, 'at_hor_battered_hilt_throw'),
	(5698, 'at_icc_saurfang_portal'),
	(5703, 'SmartTrigger'),
	(5704, 'SmartTrigger'),
	(5705, 'SmartTrigger'),
	(5706, 'SmartTrigger'),
	(5709, 'at_lady_deathwhisper_entrance'),
	(5718, 'at_frozen_throne_teleport'),
	(5729, 'at_icc_start_blood_quickening'),
	(5867, 'at_baltharus_plateau'),
	(3626, 'SmartTrigger');
/*!40000 ALTER TABLE `areatrigger_scripts` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
