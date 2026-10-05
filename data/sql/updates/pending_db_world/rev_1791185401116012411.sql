--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8523 AND `SourceEntry` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8523, 0, 0, 0, 2, 0, 31366, 1, 0, 1, 0, 0, '', 'Show gossip only if player doesnt have Felsworn Gas Mask'),
(15, 8523, 0, 0, 0, 47, 0, 10819, 10, 0, 0, 0, 0, '', 'Show gossip if Felsworn Gas Mask quest taken or completed'),
(15, 8523, 0, 0, 1, 2, 0, 31366, 1, 0, 1, 0, 0, '', 'Show gossip only if player doesnt have Felsworn Gas Mask'),
(15, 8523, 0, 0, 1, 8, 0, 10819, 0, 0, 0, 0, 0, '', 'Show gossip if Felsworn Gas Mask quest rewarded'),
(15, 8523, 0, 0, 1, 8, 0, 10821, 0, 0, 1, 0, 0, '', 'Hide gossip when You''re Fired! quest rewarded');
