-- DB update 2026_02_22_03 -> 2026_02_22_04
--
UPDATE `conditions` SET `ConditionTypeOrReference` = 25 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` IN (1260002) AND `SourceEntry` IN (42172,42173,42175,42176,42177,42178) AND `ConditionTypeOrReference` = 1 AND `ConditionValue1` IN (55993,55994,55996,55998,55997,55999);
