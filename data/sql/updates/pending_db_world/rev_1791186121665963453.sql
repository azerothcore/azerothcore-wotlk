--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 37236;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 37236, 0, 0, 29, 0, 21181, 100, 0, 1, 0, 0, '', 'Uttering the Words of Damnation - Cast only if no Cyrukh the Firelord is alive within 100 yards'),
(17, 0, 37236, 0, 0, 29, 0, 21685, 100, 0, 1, 0, 0, '', 'Uttering the Words of Damnation - Cast only if no Oronok Torn-heart is alive within 100 yards');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` IN (11, 14) AND `SourceEntry` = 2131000 AND `SourceId` = 9;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 11, 2131000, 9, 0, 29, 1, 21181, 100, 0, 1, 0, 0, '', 'Shadowmoon Valley Invisible Trigger (Tiny) - Summon Cyrukh the Firelord only if none is alive within 100 yards'),
(22, 14, 2131000, 9, 0, 29, 1, 21685, 100, 0, 1, 0, 0, '', 'Shadowmoon Valley Invisible Trigger (Tiny) - Summon Oronok Torn-heart and sons only if Oronok is not alive within 100 yards');
