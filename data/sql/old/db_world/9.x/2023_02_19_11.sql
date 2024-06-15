-- DB update 2023_02_19_10 -> 2023_02_19_11
--
UPDATE `conditions` SET `ConditionValue2`=100 WHERE `SourceGroup`=7868 AND `SourceTypeOrReferenceId` IN (14, 15);
