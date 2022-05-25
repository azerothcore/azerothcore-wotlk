
-- Change text and remove 10601 as the BroadcastTextId 'till sniff data
DELETE FROM `creature_text` WHERE `CreatureID`= 11380 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(11380, 0, 0, 'Grats!', 14, 0, 100, 0, 0, 0, 0, 3, 'mandokir SAY_GRATS_JINDO');

