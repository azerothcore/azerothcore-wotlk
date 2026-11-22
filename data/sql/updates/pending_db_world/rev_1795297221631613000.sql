--
-- Berserk 68378 targets the nearest creature of a listed entry: Fjola for Eydis, Noth himself for Noth
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 68378;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 68378, 0, 0, 31, 0, 3, 34497, 0, 0, 0, 0, '', 'Berserk - Target Fjola Lightbane'),
(13, 3, 68378, 0, 1, 31, 0, 3, 15954, 0, 0, 0, 0, '', 'Berserk - Target Noth the Plaguebringer');
