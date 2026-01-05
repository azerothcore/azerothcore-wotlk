-- DB update 2024_09_23_00 -> 2024_09_23_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_skyguard_blasting_charges';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(39844, 'spell_item_skyguard_blasting_charges');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 39844) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 185549) AND (`ConditionValue2` = 30) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 39844, 0, 0, 30, 0, 185549, 30, 0, 0, 0, 0, '', ' Launch a blasting charge from your flying mount at monstrous kaliri eggs.');
