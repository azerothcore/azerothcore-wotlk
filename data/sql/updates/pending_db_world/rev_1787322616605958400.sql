 -- Clientside area trigger 4089 smart ai
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 4089 AND `SourceId` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(22, 1, 4089, 2, 0, 2, 0, 22691, 1, 0, 0, 'Action invoker has 1 of item Corrupted Ashbringer (22691) in backpack'), -- Change it so it can trigger without equipping a weapon
(22, 1, 4089, 2, 0, 13, 0, 2, 0, 0, 0, 'instance data 2 equals 0');