-- DB update 2025_09_03_00 -> 2025_09_03_01
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 44407);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 44407, 0, 0, 31, 1, 3, 24747, 0, 0, 0, 0, '', 'Hawk Hunting must target Fjord Hawk');

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 24747;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24747) AND (`source_type` = 0);

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_hawk_hunting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(44407, 'spell_hawk_hunting');
