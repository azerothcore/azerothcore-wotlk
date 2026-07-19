-- DB update 2026_05_16_01 -> 2026_05_16_02
-- Update Night Elf shapeshift forms
DELETE FROM `player_shapeshift_model` WHERE (`RaceID` = 4 AND `CustomizationID` IN (3, 5) AND `ShapeshiftID` IN (5, 8)) OR (`RaceID` = 4 AND `CustomizationID` = 5 AND `ShapeshiftID` = 1) OR (`RaceID` = 4 AND `CustomizationID` = 7 AND `ShapeshiftID` IN (5, 8)) OR (`RaceID` = 4 AND `CustomizationID` = 6 AND `ShapeshiftID` = 1);
INSERT INTO `player_shapeshift_model` (`ShapeshiftID`, `RaceID`, `CustomizationID`, `GenderID`, `ModelID`) VALUES
-- light blue hair, bear
(5, 4, 3, 2, 29415),
(8, 4, 3, 2, 29415),
-- blue hair, bear
(5, 4, 5, 2, 29415),
(8, 4, 5, 2, 29415),
-- blue hair, cat
(1, 4, 5, 2, 29406),
-- purple hair, red bear
(5, 4, 7, 2, 29417),
(8, 4, 7, 2, 29417),
-- darkblue hair, black cat
(1, 4, 6, 2, 892);

-- remove customization id 8
DELETE FROM `player_shapeshift_model` WHERE `ShapeshiftID`=1 AND `RaceID`=4 AND `CustomizationID`=8 AND `GenderID`=2 AND `ModelID` = 29405;
