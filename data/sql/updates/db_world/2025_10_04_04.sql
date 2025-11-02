-- DB update 2025_10_04_03 -> 2025_10_04_04
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 50674);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 50674, 0, 0, 31, 0, 3, 25469, 0, 0, 0, 0, '', 'The Demoralizer only hits Mindless Aberration'),
(13, 1, 50674, 0, 1, 31, 0, 3, 25332, 0, 0, 0, 0, '', 'The Demoralizer only hits Stitched Warsong Horror'),
(13, 1, 50674, 0, 2, 31, 0, 3, 25333, 0, 0, 0, 0, '', 'The Demoralizer only hits Undying Aggressor');
