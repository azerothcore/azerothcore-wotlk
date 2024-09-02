-- DB update 2024_05_26_00 -> 2024_05_26_01
--
DELETE FROM `creature_text` WHERE (`CreatureID` = 22515) AND (`GroupID` = 19);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22515, 19, 0, 'The Ancient Gate of the Keepers unlocks!', 41, 0, 100, 0, 0, 0, 34401, 0, 'Ulduar - The Ancient Gate of the Keepers unlocks!');
