-- DB update 2023_10_22_02 -> 2023_10_22_03
-- AB_Effect_000 28441 spell effect only works on NPCs related to Ashbringers in "Scarlet Monastery"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=28441 AND `SourceId`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 28441, 0, 0, 31, 0, 3, 3976, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Commander Mograine'),
(13, 1, 28441, 0, 1, 31, 0, 3, 4294, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Sorcerer'),
(13, 1, 28441, 0, 2, 31, 0, 3, 4295, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Myrmidon'),
(13, 1, 28441, 0, 3, 31, 0, 3, 4298, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Defender'),
(13, 1, 28441, 0, 4, 31, 0, 3, 4299, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Chaplain'),
(13, 1, 28441, 0, 5, 31, 0, 3, 4300, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Wizard'),
(13, 1, 28441, 0, 6, 31, 0, 3, 4301, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Centurion'),
(13, 1, 28441, 0, 7, 31, 0, 3, 4302, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Champion'),
(13, 1, 28441, 0, 8, 31, 0, 3, 4303, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Abbot'),
(13, 1, 28441, 0, 9, 31, 0, 3, 4540, 0, 0, 0, 0, '', 'AB_Effect_000 target Scarlet Monk'),
(13, 1, 28441, 0, 10, 31, 0, 3, 4542, 0, 0, 0, 0, '', 'AB_Effect_000 target High Inquisitor Fairbanks');

-- Forgiveness 28697 adds comments
UPDATE `conditions` SET `Comment`='Forgiveness target Scarlet Commander Mograine' WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=28697 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=3976 AND `ConditionValue3`=0;

