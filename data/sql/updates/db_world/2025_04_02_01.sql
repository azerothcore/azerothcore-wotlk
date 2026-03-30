-- DB update 2025_04_02_00 -> 2025_04_02_01
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 21004 AND `SourceEntry` = 31656);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(1, 21004, 31656, 0, 0, 1, 0, 38778, 0, 0, 0, 0, '', 'Requires Spirit Calling Aura to loot Lesser Nether Drake Spirit');
