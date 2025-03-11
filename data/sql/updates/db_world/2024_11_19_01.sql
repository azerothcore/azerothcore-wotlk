-- DB update 2024_11_19_00 -> 2024_11_19_01
DELETE FROM `conditions` WHERE 
    `SourceTypeOrReferenceId` = 23 AND
    `SourceGroup` = 14522 AND
    `SourceEntry` = 18687 AND
    `ConditionTypeOrReference` = 9 AND
    `ConditionValue1` = 7625;

INSERT INTO `conditions` (
    `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
    `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
    `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
    `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`
)
VALUES
(23, 14522, 18687, 0, 0, 9, 0, 7625, 0, 0, 0, 0, 0, '', 'Vendor: Require quest 7625 accepted to buy Xorothian Stardust');
