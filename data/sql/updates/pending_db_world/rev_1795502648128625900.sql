--
DELETE FROM `spell_script_names` WHERE `spell_id` = 28524 AND `ScriptName` = 'spell_sapphiron_frost_explosion';

DELETE FROM `spell_target_position` WHERE `ID` = 29318 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(29318, 0, 533, 3493.45, -5375.38, 138.168, 0, 46368);
