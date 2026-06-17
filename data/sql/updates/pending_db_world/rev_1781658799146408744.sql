DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `SourceGroup` = 0 AND `SourceEntry` = 24277;
INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`,
    `ConditionTypeOrReference`, `ConditionValue1`, `Comment`)
VALUES
(30, 0, 24277, 9, 11324,
    'Garwal - visible only when on quest Alpha Worg');
