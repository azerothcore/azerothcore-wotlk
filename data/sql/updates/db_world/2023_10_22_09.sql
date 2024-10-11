-- DB update 2023_10_22_08 -> 2023_10_22_09
-- You need to kill Skartax
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 37285) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 21207) AND (`ConditionValue2` = 30) AND (`ConditionValue3` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 37285, 0, 0, 29, 0, 21207, 30, 1, 0, 0, 0, '', 'Disrupt the summoning of infernal souls within the summoning chamber of the Deathforge.');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_disrupt_summoning_ritual';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(37285, 'spell_disrupt_summoning_ritual');
