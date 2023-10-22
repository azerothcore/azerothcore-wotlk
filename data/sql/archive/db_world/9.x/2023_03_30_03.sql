-- DB update 2023_03_30_02 -> 2023_03_30_03
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` = 35301) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue2` = 21062);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 35301, 0, 0, 31, 0, 3, 21062, 0, 0, 0, 0, '', 'Spell Suicide (35301) only targets Nether Wraith (21062)');

DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 19220 AND `ID` = 2);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(19220, 2, 29455, 0, 0, 48526);
