-- DB update 2023_03_02_00 -> 2023_03_03_00
-- Zorbin Fandazzle - show gossip menu if Quests Zapped Giants (7003) and  Fuel for the Zapping (7721) are rewarded
DELETE FROM `conditions` WHERE `SourceGroup` = 11361 AND `SourceTypeOrReferenceId` = 14 AND `ConditionValue1` IN (7003, 7721);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 11361, 7116, 0, 0, 8, 0, 7003, 0, 0, 0, 0, 0, '', '(AND) Zorbin Fandazzle - Show gossip menu if Quests Zapped Giants is rewarded'),
(14, 11361, 7116, 0, 0, 8, 0, 7721, 0, 0, 0, 0, 0, '', '(AND) Zorbin Fandazzle - Show gossip menu if Fuel for the Zapping is rewarded');
