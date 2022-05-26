-- DB update 2022_05_26_00 -> 2022_05_26_01

-- Change text and remove 10601 as the BroadcastTextId 'till sniff data
DELETE FROM `creature_text` WHERE `CreatureID`= 11380 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(11380, 0, 0, 'Grats!', 14, 0, 100, 0, 0, 0, 0, 3, 'mandokir SAY_GRATS_JINDO');

-- Adjust dual dialogue on level up for Mandokir
UPDATE `creature_text` SET `Probability`=75, `comment`='mandokir SAY_DING_KILL_1' WHERE `CreatureID`=11382 AND `GroupID`=1 AND `ID`=0;
DELETE FROM `creature_text` WHERE `CreatureID`= 11382 AND `GroupID`=1 AND `ID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Probability`, `comment`) VALUES 
('11382', '1', '1', 'Your deaths feed my strength!', '14', '25', 'mandokir SAY_DING_KILL_2');

