-- DB update 2024_08_27_01 -> 2024_08_27_02
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` IN (41333, 41342) AND `SourceId` = 0 AND `ElseGroup` IN (0, 1, 2, 3) AND `ConditionTypeOrReference` = 31 AND `ConditionValue2` IN (22949, 22950, 22951, 22952, 23426);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 41333, 0, 1, 31, 0, 3, 22949, 0, 0, 0, 0, '', 'Spell \'Empyreal Equivalency\' can hit \'Gathios the Shatterer\''),
(13, 1, 41333, 0, 2, 31, 0, 3, 22950, 0, 0, 0, 0, '', 'Spell \'Empyreal Equivalency\' can hit \'High Nethermancer Zerevor\''),
(13, 1, 41333, 0, 3, 31, 0, 3, 22951, 0, 0, 0, 0, '', 'Spell \'Empyreal Equivalency\' can hit \'Lady Malande\''),
(13, 1, 41333, 0, 0, 31, 0, 3, 22952, 0, 0, 0, 0, '', 'Spell \'Empyreal Equivalency\' can hit \'Veras Darkshadow\''),
(13, 1, 41342, 0, 0, 31, 0, 3, 23426, 0, 0, 0, 0, '', 'Spell \'Shared Rule\' can hit \'The illidari Council\'');

DELETE FROM `spell_script_names` WHERE `spell_id` = 41333;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (41333, 'spell_illidari_council_empyreal_equivalency');
