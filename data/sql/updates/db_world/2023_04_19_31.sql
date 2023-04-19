-- DB update 2023_04_19_30 -> 2023_04_19_31
-- Costume Scraps
DELETE FROM `conditions` WHERE `SourceGroup` IN (21383,21382,21492,21810,22308,21809,21637) AND `SourceEntry` = 31121 AND `SourceTypeOrReferenceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 21383, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.'),
(1, 21382, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.'),
(1, 21492, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.'),
(1, 21810, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.'),
(1, 22308, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.'),
(1, 21809, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.'),
(1, 21637, 31121, 0, 0, 47, 0, 10722, 74, 0, 0, 0, 0, '', 'Allow obtaining Costume Scraps only if quest \'Meeting at the Blackwing Coven\' is complete, in progress or have been rewarded.');
