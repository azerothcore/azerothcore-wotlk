-- DB update 2025_12_29_08 -> 2025_12_29_09
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 58912);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 58912, 0, 0, 31, 1, 3, 32414, 0, 0, 0, 0, '', 'Deathstorm requires Lordaeron Captain'),
(17, 0, 58912, 0, 1, 31, 1, 3, 31254, 0, 0, 0, 0, '', 'Deathstorm requires Lordaeron Footsoldier');
