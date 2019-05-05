INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557057861901733700');

-- Returning the Favor (9931)
DELETE FROM `conditions` WHERE `SourceEntry`=32314 AND `SourceTypeOrReferenceId` IN (13,17);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 32314, 0, 4, 31, 0, 3, 18402, 0, 0, 0, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(13, 3, 32314, 0, 3, 31, 0, 3, 18065, 0, 0, 0, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(13, 3, 32314, 0, 2, 31, 0, 3, 18064, 0, 0, 0, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(13, 3, 32314, 0, 1, 31, 0, 3, 18037, 0, 0, 0, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(13, 3, 32314, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target must be dead to place Banner on him'),
(13, 3, 32314, 0, 0, 31, 0, 3, 17138, 0, 0, 0, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(13, 3, 32314, 0, 6, 31, 0, 3, 18064, 0, 0, 0, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(17, 0, 32314, 0, 0, 29, 0, 17138, 5, 1, 0, 12, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(17, 0, 32314, 0, 1, 29, 0, 18037, 5, 1, 0, 12, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(17, 0, 32314, 0, 2, 29, 0, 18064, 5, 1, 0, 12, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(17, 0, 32314, 0, 3, 29, 0, 18065, 5, 1, 0, 12, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(17, 0, 32314, 0, 4, 29, 0, 18402, 5, 1, 0, 12, 0, '', 'Spell Place Kil sorrow Banner can only be cast on Warmaul Ogres'),
(17, 0, 32314, 0, 0, 30, 0, 182354, 10, 0, 1, 12, 0, '', 'Spell Place Kil sorrow Banner can only be cast if no banner is present');
