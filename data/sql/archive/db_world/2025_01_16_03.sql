-- DB update 2025_01_16_02 -> 2025_01_16_03
DELETE FROM `spell_target_position` WHERE `ID` = 41234 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(41234, 0, 530, -3560.52, 583.353, 10.9431, 4.751223087310791015, 58558);
