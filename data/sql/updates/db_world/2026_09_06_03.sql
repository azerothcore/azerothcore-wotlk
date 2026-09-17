-- DB update 2026_09_06_02 -> 2026_09_06_03
-- Reconstructed Wyrm: do not refresh Frost Breath's active stun (effect 2).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 4 AND `SourceEntry` = 49342 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 1 AND `ConditionTarget` = 0 AND `ConditionValue1` = 49342 AND `ConditionValue2` = 2 AND `NegativeCondition` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
    `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
    `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
    (13, 4, 49342, 0, 0, 1, 0, 49342, 2, 0, 1, 0, 0, '', 'Frost Breath - effect 2 requires target without active Frost Breath stun');
