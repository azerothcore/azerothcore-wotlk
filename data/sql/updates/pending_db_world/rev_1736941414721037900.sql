--
-- Correctly updates the MAP from `Eastern Kingdoms` to `Outland`.
UPDATE `spell_target_position` SET `MapID` = 530 WHERE `ID` = 41234 AND `EffectIndex` = 0;
