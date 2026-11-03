-- DB update 2026_11_03_02 -> 2026_11_03_03
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE `ID` IN (1793, 1794);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` IN (1793, 1794) AND `ConditionTypeOrReference` IN (2, 47);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1793, 0, 0, 47, 0, 1649, 1, 0, 0, 0, 0, '', 'Quest The Tome of Valor (Stormwind, offer book) available if quest The Tome of Valor (book) has not been taken.'),
(19, 0, 1793, 0, 0, 2, 0, 6776, 1, 1, 1, 0, 0, '', 'Quest The Tome of Valor (Stormwind, offer book) available if player does not have 1 of Tome of Valor.'),
(19, 0, 1794, 0, 0, 47, 0, 1649, 1, 0, 0, 0, 0, '', 'Quest The Tome of Valor (Ironforge, offer book) available if quest The Tome of Valor (book) has not been taken.'),
(19, 0, 1794, 0, 0, 2, 0, 6776, 1, 1, 1, 0, 0, '', 'Quest The Tome of Valor (Ironforge, offer book) available if player does not have 1 of Tome of Valor.');
