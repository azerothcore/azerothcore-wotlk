-- DB update 2022_05_08_00 -> 2022_05_08_01
--
DELETE FROM `creature_text` WHERE `CreatureID` = 25740 AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(25740, 0, 0, "Ahune Retreats. His defenses diminish.", 41, 0, 100, 0, 0, 0, 24931, 0, "ahune EMOTE_RETREAT"),
(25740, 1, 0, "Ahune will soon resurface.", 41, 0, 100, 0, 0, 0, 24932, 0, "ahune EMOTE_RESURFACE");
