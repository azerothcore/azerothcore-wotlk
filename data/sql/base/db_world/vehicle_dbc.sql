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

-- Dumping structure for table acore_world.vehicle_dbc
DROP TABLE IF EXISTS `vehicle_dbc`;
CREATE TABLE IF NOT EXISTS `vehicle_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `TurnSpeed` float NOT NULL DEFAULT '0',
  `PitchSpeed` float NOT NULL DEFAULT '0',
  `PitchMin` float NOT NULL DEFAULT '0',
  `PitchMax` float NOT NULL DEFAULT '0',
  `SeatID_1` int NOT NULL DEFAULT '0',
  `SeatID_2` int NOT NULL DEFAULT '0',
  `SeatID_3` int NOT NULL DEFAULT '0',
  `SeatID_4` int NOT NULL DEFAULT '0',
  `SeatID_5` int NOT NULL DEFAULT '0',
  `SeatID_6` int NOT NULL DEFAULT '0',
  `SeatID_7` int NOT NULL DEFAULT '0',
  `SeatID_8` int NOT NULL DEFAULT '0',
  `MouseLookOffsetPitch` float NOT NULL DEFAULT '0',
  `CameraFadeDistScalarMin` float NOT NULL DEFAULT '0',
  `CameraFadeDistScalarMax` float NOT NULL DEFAULT '0',
  `CameraPitchOffset` float NOT NULL DEFAULT '0',
  `FacingLimitRight` float NOT NULL DEFAULT '0',
  `FacingLimitLeft` float NOT NULL DEFAULT '0',
  `MsslTrgtTurnLingering` float NOT NULL DEFAULT '0',
  `MsslTrgtPitchLingering` float NOT NULL DEFAULT '0',
  `MsslTrgtMouseLingering` float NOT NULL DEFAULT '0',
  `MsslTrgtEndOpacity` float NOT NULL DEFAULT '0',
  `MsslTrgtArcSpeed` float NOT NULL DEFAULT '0',
  `MsslTrgtArcRepeat` float NOT NULL DEFAULT '0',
  `MsslTrgtArcWidth` float NOT NULL DEFAULT '0',
  `MsslTrgtImpactRadius_1` float NOT NULL DEFAULT '0',
  `MsslTrgtImpactRadius_2` float NOT NULL DEFAULT '0',
  `MsslTrgtArcTexture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MsslTrgtImpactTexture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MsslTrgtImpactModel_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MsslTrgtImpactModel_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CameraYawOffset` float NOT NULL DEFAULT '0',
  `UilocomotionType` int NOT NULL DEFAULT '0',
  `MsslTrgtImpactTexRadius` float NOT NULL DEFAULT '0',
  `VehicleUIIndicatorID` int NOT NULL DEFAULT '0',
  `PowerDisplayID_1` int NOT NULL DEFAULT '0',
  `PowerDisplayID_2` int NOT NULL DEFAULT '0',
  `PowerDisplayID_3` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.vehicle_dbc: ~0 rows (approximately)
DELETE FROM `vehicle_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
