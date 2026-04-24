-- DB update 2026_04_24_00 -> 2026_04_24_01

-- Set New Condition (Death Knight Initiate).
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 20) AND (`SourceGroup` = 0) AND (`SourceEntry` = 28406) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 106) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 0) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(20, 0, 28406, 0, 0, 106, 0, 0, 0, 0, 1, 0, 0, '', 'Death Knight Initiate gossip only available if the npc is not in combat.');
