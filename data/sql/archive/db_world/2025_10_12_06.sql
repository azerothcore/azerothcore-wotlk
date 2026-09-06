-- DB update 2025_10_12_05 -> 2025_10_12_06
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry`=0 AND `SourceId`=0 AND `SourceGroup` IN (3443, 12919, 15471);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9087) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 12) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 109) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9087, 0, 0, 0, 12, 0, 109, 0, 0, 0, 0, 0, '', 'event \'Sun\'s Reach Reclamation Phase Anvil\' must be active');
