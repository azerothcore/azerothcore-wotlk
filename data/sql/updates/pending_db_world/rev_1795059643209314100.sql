--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 66379;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 66379, 0, 0, 31, 0, 3, 34607, 0, 0, 0, 0, '', 'Target for Anub\'arak Shadow Strike'),
(13, 1, 66379, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak Shadow Strike'),
(13, 1, 66379, 0, 0, 1, 0, 66311, 0, 0, 1, 0, 0, '', 'Target for Anub\'arak Shadow Strike: not Recently Awakened');

DELETE FROM `spell_script_names` WHERE `spell_id` = 66135;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66135, 'spell_anubarak_shadow_strike');
