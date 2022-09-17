-- DB update 2022_05_12_00 -> 2022_05_16_00
-- fixed quest 12924 spell area
UPDATE `spell_area` SET `quest_start` = 12956 WHERE `spell` = 55858;

-- (Quests) Forging an Alliance require A Spark of Hope + Mending Fences
DELETE FROM `conditions` WHERE  `SourceTypeOrReferenceId` = 19 AND `SourceEntry`=12924;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(19, 0, 12924, 0, 0, 8, 0, 12956, 0, 0, 0, 0, 0, '', 'Forging an Alliance - Requires quest rewarded'),
(19, 0, 12924, 0, 0, 8, 0, 12915, 0, 0, 0, 0, 0, '', 'Forging an Alliance - Requires quest rewarded');
