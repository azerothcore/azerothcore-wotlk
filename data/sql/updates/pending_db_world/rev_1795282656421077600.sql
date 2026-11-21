--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (68400, 68401);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 68400, 0, 0, 31, 0, 3, 34496, 0, 0, 0, 0, '', 'Instakill Dark Val''kyr - Target Eydis Darkbane'),
(13, 1, 68401, 0, 0, 31, 0, 3, 34497, 0, 0, 0, 0, '', 'Instakill Light Val''kyr - Target Fjola Lightbane');
