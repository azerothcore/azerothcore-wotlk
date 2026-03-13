-- DB update 2026_02_06_05 -> 2026_02_06_06
--
DELETE FROM `spell_target_position` WHERE `ID` = 33244 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(33244, 0, 550, 432.74, -373.645, 18.0138, 1.39626, 50791);
