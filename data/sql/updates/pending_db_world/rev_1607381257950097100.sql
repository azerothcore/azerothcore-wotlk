INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607381257950097100');

DELETE FROM `spell_target_position` WHERE `ID`=62501 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (62501, 0, 603, 2035.95, -202.085, 432.687, 3.16408, 0);

DELETE FROM `spell_script_names` WHERE `spell_id ` = 62501;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES ('62501', 'spell_hodir_shatter_chest');