-- DB update 2025_01_15_00 -> 2025_01_15_01
--
DELETE FROM `spell_target_position` WHERE `ID` = 41234 AND `EffectIndex` = 0;

INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`)
VALUES (41234, 0, 0, -3560.6572, 582.82887, 10.987, 4.768543);
