-- DB update 2023_03_06_00 -> 2023_03_07_00
-- Sha'ni Proudtusk's Remains GO SmartAI - Add condition for QUEST_STATE (Complete and rewarded) AND no Sha'ni Proudtusk within 10 yards.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=1 AND `SourceEntry`=160445;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22, 1, 160445, 1, 0, 47, 0, 3821, 66, 0, 0, 0, 0, '', '(AND) Execute SmartAI for gameobject 160445 only if player has COMPLETE and REWARDED quest 3821'),
(22, 1, 160445, 1, 0, 29, 0, 9136, 10, 0, 1, 0, 0, '', '(AND) Execute SmartAI for gameobject 160445 only if no Sha\'ni Proudtusk is within 10y.');
