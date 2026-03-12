-- DB update 2026_02_23_04 -> 2026_02_23_05
-- Remove conditions
DELETE FROM `conditions` WHERE `SourceEntry` = 12528 AND `SourceTypeOrReferenceId` = 19 AND `ConditionValue1` = 12654;
