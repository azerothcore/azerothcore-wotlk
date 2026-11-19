
-- Add new conditions with boss state and delete the old ones.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14, 15) AND `SourceGroup` = 7868;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7868, 9635, 0, 0, 13, 0, 0, 3, 2, 1, 0, 0, '', 'Lakka - Show gossip text only if Darkweaver Syth is not defeated'),
(14, 7868, 9636, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Lakka - Show gossip text only if Darkweaver Syth is defeated'),
(15, 7868, 0, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Lakka - Show gossip option only if Darkweaver Syth is defeated');
