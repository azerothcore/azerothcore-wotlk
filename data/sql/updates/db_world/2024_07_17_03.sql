-- DB update 2024_07_17_02 -> 2024_07_17_03
--
UPDATE `creature_text` SET `GroupID`=14, `ID`=0 WHERE `CreatureID`=11583 AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `GroupID`=15, `ID`=0, `Type`=6 WHERE `CreatureID`=11583 AND `GroupID`=0 AND `ID`=2;

DELETE FROM `conditions` WHERE `SourceEntry` IN (23361,23362);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 23361, 0, 0, 31, 0, 5, 179804, 0, 0, 0, 0, '', 'Nefarian - Raise Undead Drakonid - Target Drakonid Bones'),
(13, 1, 23362, 0, 0, 31, 0, 5, 179804, 0, 0, 0, 0, '', 'Nefarian - Raise Drakonids - Target Drakonid Bones');
