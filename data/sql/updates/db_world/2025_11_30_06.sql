-- DB update 2025_11_30_05 -> 2025_11_30_06
--
-- Judgment Day Comes! should not be available if Honor Above All Else is taken/complete/rewarded
-- Uses CONDITION_QUESTSTATE (47) with state_mask 74 (2+8+64 = Completed+InProgress+Rewarded)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceEntry` IN (13226, 13227)) AND (`ConditionTypeOrReference` = 47) AND (`ConditionValue1` = 13036);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13226, 0, 0, 47, 0, 13036, 74, 0, 1, 0, 0, '', 'Judgment Day Comes! - NOT have Honor Above All Else (taken/complete/rewarded)'),
(19, 0, 13227, 0, 0, 47, 0, 13036, 74, 0, 1, 0, 0, '', 'Judgment Day Comes! - NOT have Honor Above All Else (taken/complete/rewarded)');
