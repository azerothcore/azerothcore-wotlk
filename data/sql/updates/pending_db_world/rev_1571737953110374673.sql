INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571737953110374673');

DELETE FROM `spell_script_names` WHERE `spell_id` = 17179;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(17179,'spell_scholomance_boon_of_life');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 10508 AND `SourceEntry` = 13626 AND `ConditionTypeOrReference` = 13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(1,10508,13626,0,0,13,0,2,1,0,0,0,0,'','Instance - Get Data - Can only loot ''Human Head of Ras Frostwhisper'' if Ras is in human form');
