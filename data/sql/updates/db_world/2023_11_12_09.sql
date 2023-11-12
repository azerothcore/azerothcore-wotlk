-- DB update 2023_11_12_08 -> 2023_11_12_09
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 37984) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 185032) AND (`ConditionValue2` = 15) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 37984, 0, 0, 30, 0, 185032, 15, 0, 0, 0, 0, '', 'Quench the Forged Illidari-Bane Blade in the lava pools near the top of the Hand of Gul\'dan.');
