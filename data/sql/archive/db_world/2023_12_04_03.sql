-- DB update 2023_12_04_02 -> 2023_12_04_03
-- Portal Effect: Hellfire Peninsula A/H
DELETE FROM `spell_target_position` WHERE `id` IN (65728,65729);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(65728, 0, 0, -11708.4, -3168, -5.07, 3.351032, 52237),
(65729, 0, 0, -11708.4, -3168, -5.07, 3.351032, 52237);
