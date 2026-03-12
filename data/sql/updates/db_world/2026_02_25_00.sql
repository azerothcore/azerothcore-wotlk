-- DB update 2026_02_24_06 -> 2026_02_25_00
--
UPDATE `conditions` SET `ConditionValue3` = 2 WHERE `SourceGroup` = 10389 AND `SourceEntry` IN (0, 1, 2, 3, 4, 5, 6, 8) AND `SourceTypeOrReferenceId` = 15;
