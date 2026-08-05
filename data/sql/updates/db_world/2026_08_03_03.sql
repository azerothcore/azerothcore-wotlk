-- DB update 2026_08_03_02 -> 2026_08_03_03
-- Guardian of Yogg-Saron: Shadow Nova (62714) entry-targeted effect must hit other Guardians (33136),
-- not Sara, who is already hit by the dedicated Shadow Nova (65719). Fixes double 25k damage on Sara.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 2) AND (`SourceEntry` = 62714) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 62714, 0, 0, 31, 0, 3, 33136, 0, 0, 0, 0, '', 'Shadow Nova');

-- Remove dead condition: creatures keep their normal entry (33134) in all difficulties,
-- so a check against Sara's 25-man difficulty entry (34332) can never match.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 65719) AND (`SourceId` = 0) AND (`ElseGroup` = 1) AND (`ConditionValue2` = 34332);
