-- DB update 2026_01_01_01 -> 2026_01_01_02
--
UPDATE `conditions` SET `ConditionValue1` = 0 WHERE (`SourceTypeOrReferenceId` = 4) AND (`SourceGroup` = 24524) AND (`SourceEntry` = 52676) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 105);
