-- DB update 2023_04_04_13 -> 2023_04_04_14
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 17798 AND `SourceEntry` = 24313 AND `ConditionTypeOrReference` = 7;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`,`ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `Comment`) VALUES
(1, 17798, 24313, 7, 197, 1, 'Pattern: Battlecast Hood requires Tailoring to drop');
UPDATE `conditions` SET `Comment` = 'Pattern: Battlecast Hood requires Tailoring to drop' WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 20633 AND `SourceEntry` = 24313 AND `ConditionTypeOrReference` = 7;
