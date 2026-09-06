-- DB update 2025_11_12_00 -> 2025_11_12_01
--
-- Unliving Chocker
UPDATE `conditions` SET `ConditionTypeOrReference` = 8, `NegativeCondition` = 1, `Comment` = 'must not have completed quest \'Cleansing Drak\'Tharon\'' WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 28519) AND (`SourceEntry` = 38660) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 14) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12238) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
-- Writhing Choker
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 28519) AND (`SourceEntry` = 38673) AND (`SourceId` = 0) AND (`ElseGroup` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 28519, 38673, 0, 0, 8, 0, 12238, 0, 0, 0, 0, 0, '', 'must have completed quest \'Cleansing Drak\'Tharon\''),
(1, 28519, 38673, 0, 0, 2, 0, 38660, 1, 1, 1, 0, 0, '', 'must not have item \'Unliving Chocker\''),
(1, 28519, 38673, 0, 0, 8, 0, 12631, 0, 0, 1, 0, 0, '', 'must not have completed quest \'An Invitation, of Sorts...\'');
