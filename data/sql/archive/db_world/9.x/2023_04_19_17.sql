-- DB update 2023_04_19_16 -> 2023_04_19_17
-- 184073 (Ethereal Teleport Pad)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8062;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8062, 0, 0, 0, 29, 1, 20518, 10, 0, 1, 0, 0, '', '(AND) Ethereal Teleport Pad - Show Gossip option 0 only if no Image of Wind Trader Marid is within 10y.'),
(15, 8062, 0, 0, 0, 47, 0, 10270, 66, 0, 0, 0, 0, '', '(AND) Ethereal Teleport Pad - Show Gossip option 0 only if quest A Not-So-Modest Proposal has been completed or rewarded.');
