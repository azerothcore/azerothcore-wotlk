-- DB update 2025_05_27_00 -> 2025_05_27_01
DROP TABLE IF EXISTS `player_shapeshift_model`;
DROP TABLE IF EXISTS `player_totem_model`;

CREATE TABLE IF NOT EXISTS `player_shapeshift_model` (
  `ShapeshiftID` TINYINT unsigned NOT NULL,
  `RaceID` TINYINT unsigned NOT NULL,
  `CustomizationID` TINYINT unsigned NOT NULL,
  `GenderID` TINYINT unsigned NOT NULL,
  `ModelID` INT unsigned NOT NULL,
  PRIMARY KEY (`ShapeshiftID`, `RaceID`, `CustomizationID`, `GenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 PACK_KEYS=0;

CREATE TABLE IF NOT EXISTS `player_totem_model` (
  `TotemID` TINYINT unsigned NOT NULL,
  `RaceID` TINYINT unsigned NOT NULL,
  `ModelID` INT unsigned NOT NULL,
  PRIMARY KEY (`TotemID`, `RaceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 PACK_KEYS=0;

DELETE FROM `player_shapeshift_model`;
INSERT INTO `player_shapeshift_model` (`ShapeshiftID`, `RaceID`, `CustomizationID`, `GenderID`, `ModelID`) VALUES
-- Cat Form
-- Night Elf
(1, 4, 0, 2, 29407), -- Green
(1, 4, 1, 2, 29407), -- Light Green
(1, 4, 2, 2, 29407), -- Dark Green
(1, 4, 3, 2, 29406), -- Light Blue
(1, 4, 4, 2, 29408), -- White
(1, 4, 7, 2, 29405), -- Violet
(1, 4, 8, 2, 29405), -- Violet
(1, 4, 255, 2, 892), -- Dark Blue
-- Tauren
-- Male
(1, 6, 12, 0, 29409), -- White
(1, 6, 13, 0, 29409), -- White
(1, 6, 14, 0, 29409), -- White
(1, 6, 18, 0, 29409), -- Completely White
(1, 6, 9, 0, 29410), -- Light Brown
(1, 6, 10, 0, 29410), -- Light Brown
(1, 6, 11, 0, 29410), -- Light Brown
(1, 6, 6, 0, 29411), -- Brown
(1, 6, 7, 0, 29411), -- Brown
(1, 6, 8, 0, 29411), -- Brown
(1, 6, 0, 0, 29412), -- Dark
(1, 6, 1, 0, 29412), -- Dark
(1, 6, 2, 0, 29412), -- Dark
(1, 6, 3, 0, 29412), -- Dark Grey
(1, 6, 4, 0, 29412), -- Dark Grey
(1, 6, 5, 0, 29412), -- Dark Grey
(1, 6, 255, 0, 8571), -- Grey
-- Female
(1, 6, 10, 1, 29409), -- White
(1, 6, 6, 1, 29410), -- Light Brown
(1, 6, 7, 1, 29410), -- Light Brown
(1, 6, 4, 1, 29411), -- Brown
(1, 6, 5, 1, 29411), -- Brown
(1, 6, 0, 1, 29412), -- Dark
(1, 6, 1, 1, 29412), -- Dark
(1, 6, 2, 1, 29412), -- Dark
(1, 6, 3, 1, 29412), -- Dark
(1, 6, 255, 1, 8571), -- Grey
-- Bear Form
-- Night Elf
(5, 4, 0, 2, 29413), -- Green (29415?)
(5, 4, 1, 2, 29413), -- Light Green (29415?)
(5, 4, 2, 2, 29413), -- Dark Green (29415?)
(5, 4, 6, 2, 29414), -- Dark Blue
(5, 4, 4, 2, 29416), -- White
(5, 4, 3, 2, 29417), -- Light Blue
(5, 4, 255, 2, 2281), -- Violet
-- Dire Bear Form
(8, 4, 0, 2, 29413), -- Green (29415?)
(8, 4, 1, 2, 29413), -- Light Green (29415?)
(8, 4, 2, 2, 29413), -- Dark Green (29415?)
(8, 4, 6, 2, 29414), -- Dark Blue
(8, 4, 4, 2, 29416), -- White
(8, 4, 3, 2, 29417), -- Light Blue
(8, 4, 255, 2, 2281), -- Violet
-- Bear Form
-- Tauren
-- Male
(5, 6, 0, 0, 29418), -- Dark (Black)
(5, 6, 1, 0, 29418), -- Dark (Black)
(5, 6, 2, 0, 29418), -- Dark (Black)
(5, 6, 3, 0, 29419), -- White
(5, 6, 4, 0, 29419), -- White
(5, 6, 5, 0, 29419), -- White
(5, 6, 12, 0, 29419), -- White
(5, 6, 13, 0, 29419), -- White
(5, 6, 14, 0, 29419), -- White
(5, 6, 9, 0, 29420), -- Light Brown/Grey
(5, 6, 10, 0, 29420), -- Light Brown/Grey
(5, 6, 11, 0, 29420), -- Light Brown/Grey
(5, 6, 15, 0, 29420), -- Light Brown/Grey
(5, 6, 16, 0, 29420), -- Light Brown/Grey
(5, 6, 17, 0, 29420), -- Light Brown/Grey
(5, 6, 18, 0, 29421), -- Completely White
(5, 6, 255, 0, 2289), -- Brown
-- Dire Bear Form
(8, 6, 0, 0, 29418), -- Dark (Black)
(8, 6, 1, 0, 29418), -- Dark (Black)
(8, 6, 2, 0, 29418), -- Dark (Black)
(8, 6, 3, 0, 29419), -- White
(8, 6, 4, 0, 29419), -- White
(8, 6, 5, 0, 29419), -- White
(8, 6, 12, 0, 29419), -- White
(8, 6, 13, 0, 29419), -- White
(8, 6, 14, 0, 29419), -- White
(8, 6, 9, 0, 29420), -- Light Brown/Grey
(8, 6, 10, 0, 29420), -- Light Brown/Grey
(8, 6, 11, 0, 29420), -- Light Brown/Grey
(8, 6, 15, 0, 29420), -- Light Brown/Grey
(8, 6, 16, 0, 29420), -- Light Brown/Grey
(8, 6, 17, 0, 29420), -- Light Brown/Grey
(8, 6, 18, 0, 29421), -- Completely White
(8, 6, 255, 0, 2289), -- Brown
-- Bear Form
-- Female
(5, 6, 0, 1, 29418), -- Dark (Black)
(5, 6, 1, 1, 29418), -- Dark (Black)
(5, 6, 2, 1, 29419), -- White
(5, 6, 3, 1, 29419), -- White
(5, 6, 6, 1, 29420), -- Light Brown/Grey
(5, 6, 7, 1, 29420), -- Light Brown/Grey
(5, 6, 8, 1, 29420), -- Light Brown/Grey
(5, 6, 9, 1, 29420), -- Light Brown/Grey
(5, 6, 10, 1, 29421), -- Completely White
(5, 6, 255, 1, 2289), -- Brown
-- Dire Bear Form
(8, 6, 0, 1, 29418), -- Dark (Black)
(8, 6, 1, 1, 29418), -- Dark (Black)
(8, 6, 2, 1, 29419), -- White
(8, 6, 3, 1, 29419), -- White
(8, 6, 6, 1, 29420), -- Light Brown/Grey
(8, 6, 7, 1, 29420), -- Light Brown/Grey
(8, 6, 8, 1, 29420), -- Light Brown/Grey
(8, 6, 9, 1, 29420), -- Light Brown/Grey
(8, 6, 10, 1, 29421), -- Completely White
(8, 6, 255, 1, 2289), -- Brown
 -- Epic Flight Form
(27, 4, 255, 2, 21243),
(27, 6, 255, 2, 21244),
-- Flight Form
(29, 4, 255, 2, 20857),
(29, 6, 255, 2, 20872);

DELETE FROM `player_totem_model`;
INSERT INTO `player_totem_model` (`TotemID`, `RaceID`, `ModelID`) VALUES
-- Orc
(1, 2, 30758), -- Fire
(2, 2, 30757), -- Earth
(3, 2, 30759), -- Water
(4, 2, 30756), -- Air
-- Dwarf
(1, 3, 30754),
(2, 3, 30753),
(3, 3, 30755),
(4, 3, 30736),
-- Troll
(1, 8, 30762),
(2, 8, 30761),
(3, 8, 30763),
(4, 8, 30760),
-- Tauren
(1, 6, 4589),
(2, 6, 4588),
(3, 6, 4587),
(4, 6, 4590),
-- Draenei
(1, 11, 19074),
(2, 11, 19073),
(3, 11, 19075),
(4, 11, 19071);
