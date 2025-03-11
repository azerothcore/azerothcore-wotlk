-- DB update 2023_08_19_02 -> 2023_08_20_00
--
UPDATE `conditions` SET `ConditionValue1` = 1, `ConditionValue1` = 3, `ConditionValue3` = 2, `Comment` = 'Require Lt. Drake encounter complete' WHERE `ConditionValue2` = 2 AND `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 7499 AND `SourceEntry` = 9090;
