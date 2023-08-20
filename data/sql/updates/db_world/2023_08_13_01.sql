-- DB update 2023_08_13_00 -> 2023_08_13_01
--
UPDATE `conditions` SET `ConditionValue2` = 1, `Comment` = 'Require incendiary bombs placed' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7499 AND `SourceEntry` = 0 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 13 AND `ConditionTarget` = 0 AND `ConditionValue1` = 0 AND `ConditionValue2` = 2 AND `ConditionValue3` = 0; 
