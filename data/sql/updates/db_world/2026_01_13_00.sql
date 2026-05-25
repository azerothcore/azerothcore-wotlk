-- DB update 2026_01_12_01 -> 2026_01_13_00
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 20400 AND `ConditionTypeOrReference` = 12;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 27830, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Venture Co. Evacuee - Requires Hallow''s End'),
(1, 29330, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Onslaught Harbor Guard - Requires Hallow''s End'),
(1, 29722, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Rabid Cannibal - Requires Hallow''s End'),
(1, 30243, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Njorndar Spear-Sister - Requires Hallow''s End'),
(1, 30687, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Skeletal Constructor - Requires Hallow''s End'),
(1, 31738, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Cultist Corrupter - Requires Hallow''s End'),
(1, 32259, 20400, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Pumpkin Bag - Void Summoner - Requires Hallow''s End');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 21235 AND `ConditionTypeOrReference` = 12;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 11459, 21235, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', 'Winter Veil Roast - Ironbark Protector - Requires Winter Veil');
