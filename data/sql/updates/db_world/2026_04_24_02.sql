-- DB update 2026_04_24_01 -> 2026_04_24_02

-- Edit Condition.
UPDATE `conditions` SET `ConditionTarget` = 1 WHERE (`SourceTypeOrReferenceId` = 20) AND (`SourceGroup` = 0) AND (`SourceEntry` = 28406) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 106) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 0) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
