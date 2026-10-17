-- DB update 2025_10_02_00 -> 2025_10_02_01
--
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 30108);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(30108, 0, 55936, 0),
(30108, 1, 55951, 0),
(30108, 2, 55958, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 55951) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 29753) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 55951, 0, 0, 31, 1, 3, 29753, 0, 0, 0, 0, '', '');
