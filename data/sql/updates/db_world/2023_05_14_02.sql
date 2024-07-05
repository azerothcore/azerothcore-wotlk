-- DB update 2023_05_14_01 -> 2023_05_14_02
DELETE FROM `conditions` WHERE `SourceEntry` = 18250 AND `SourceTypeOrReferenceId` = 1 AND `ConditionTypeOrReference` = 2;
