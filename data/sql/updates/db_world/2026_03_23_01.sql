-- DB update 2026_03_23_00 -> 2026_03_23_01
-- Add velocity and smoothTransition columns to waypoint_data
ALTER TABLE `waypoint_data`
  ADD COLUMN `velocity` FLOAT NOT NULL DEFAULT 0 AFTER `orientation`,
  ADD COLUMN `smoothTransition` TINYINT NOT NULL DEFAULT 0 AFTER `delay`;

-- Create waypoint_data_addon table for custom spline points
CREATE TABLE IF NOT EXISTS `waypoint_data_addon` (
  `PathID` INT UNSIGNED NOT NULL,
  `PointID` INT UNSIGNED NOT NULL,
  `SplinePointIndex` INT UNSIGNED NOT NULL,
  `PositionX` FLOAT NOT NULL DEFAULT 0,
  `PositionY` FLOAT NOT NULL DEFAULT 0,
  `PositionZ` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`PathID`, `PointID`, `SplinePointIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
