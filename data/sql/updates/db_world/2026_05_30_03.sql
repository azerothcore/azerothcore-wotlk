-- DB update 2026_05_30_02 -> 2026_05_30_03
--
-- 25029 Flamethrower TARGET_UNIT_CONE_ENTRY
-- 25030 Shoot Rocket TARGET_UNIT_CONE_ENTRY
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` IN (25029, 25030)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 15328) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 5, 25029, 0, 0, 31, 0, 3, 15328, 0, 0, 0, 0, '', 'target must be \'Steam Stonk\''),
(13, 1, 25030, 0, 0, 31, 0, 3, 15328, 0, 0, 0, 0, '', 'target must be \'Steam Stonk\'');
