DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 17798 AND `SourceEntry` = 24313 AND `ConditionTypeOrReference` = 7;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`,`ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `Comment`) VALUES
(1, 17798, 24313, 7, 197, 1, 'Pattern: Battlecast Hood requires Tailoring to drop');
