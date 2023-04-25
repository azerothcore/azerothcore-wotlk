-- DB update 2023_03_29_00 -> 2023_03_29_01
-- 
DELETE FROM `creature_text` WHERE `CreatureID`=17797 AND `GroupID`=4 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17797, 4, 0, 'Enjoy the storm warm bloods!', 14, 0, 100, 0, 0, 0, 19456, 0, 'thespia SAY_SPELL');
