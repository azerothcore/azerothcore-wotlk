-- DB update 2024_12_29_01 -> 2024_12_29_02
UPDATE `conditions` SET `ConditionValue1` = 17 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` IN (35100, 35101, 35102) AND `ConditionTypeOrReference` = 13 AND `ConditionValue2` IN (1, 2, 3, 4);
