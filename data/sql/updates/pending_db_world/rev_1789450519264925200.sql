--
-- World DB override tables for CharSections.dbc and EmotesTextSound.dbc.
CREATE TABLE IF NOT EXISTS `charsections_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `RaceID` int NOT NULL DEFAULT '0',
  `SexID` int NOT NULL DEFAULT '0',
  `BaseSection` int NOT NULL DEFAULT '0',
  `TextureName_1` varchar(100) DEFAULT NULL,
  `TextureName_2` varchar(100) DEFAULT NULL,
  `TextureName_3` varchar(100) DEFAULT NULL,
  `Flags` int NOT NULL DEFAULT '0',
  `VariationIndex` int NOT NULL DEFAULT '0',
  `ColorIndex` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `emotestextsound_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `EmotesTextID` int NOT NULL DEFAULT '0',
  `RaceID` int NOT NULL DEFAULT '0',
  `SexID` int NOT NULL DEFAULT '0',
  `SoundID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
