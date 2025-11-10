--
-- Writhing Choker
UPDATE `conditions` SET `Comment` = 'must have completed quest \'Cleansing Drak\'Tharon\'' WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 28519) AND (`SourceEntry` = 38673) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12238) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
-- Unliving Choker
UPDATE `conditions` SET `ConditionTypeOrReference` = 8, `NegativeCondition` = 1, `Comment` = 'must not have completed quest \'Cleansing Drak\'Tharon\'' WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 28519) AND (`SourceEntry` = 38660) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 14) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12238) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
