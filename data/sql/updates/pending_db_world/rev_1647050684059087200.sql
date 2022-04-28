-- Add condition to spawn NPC only when there is no other NPC nearbyDELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 160445 AND `ConditionTypeOrReference` = 29;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 160445, 1, 0, 29, 1, 9136, 100, 0, 1, 0, 0, '', 'Run action if no npcs in range');
