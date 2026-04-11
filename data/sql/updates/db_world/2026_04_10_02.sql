-- DB update 2026_04_10_01 -> 2026_04_10_02

-- Update Conditions (Death Knight Initiate)
UPDATE `conditions` SET `SourceTypeOrReferenceId` = 20, `SourceGroup` = 0, `SourceEntry` = 28406 WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9765) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` IN (1, 47)) AND (`ConditionTarget` = 0) AND (`ConditionValue1` IN (12733, 54238)) AND (`ConditionValue2` IN (0, 8)) AND (`ConditionValue3` = 0);
