-- DB update 2024_12_03_00 -> 2024_12_03_01
-- Marking a tower for Zeth'Gor Must Burn!
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 36325);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 36325, 0, 0, 29, 0, 21182, 25, 0, 0, 0, 0, '', 'Cast \' They Must Burn Bomb Drop (DND)\' only if within 25 of dummy target'),
(17, 0, 36325, 0, 1, 29, 0, 22401, 25, 0, 0, 0, 0, '', 'Cast \' They Must Burn Bomb Drop (DND)\' only if within 25 of dummy target'),
(17, 0, 36325, 0, 2, 29, 0, 22402, 25, 0, 0, 0, 0, '', 'Cast \' They Must Burn Bomb Drop (DND)\' only if within 25 of dummy target'),
(17, 0, 36325, 0, 3, 29, 0, 22403, 25, 0, 0, 0, 0, '', 'Cast \' They Must Burn Bomb Drop (DND)\' only if within 25 of dummy target');
