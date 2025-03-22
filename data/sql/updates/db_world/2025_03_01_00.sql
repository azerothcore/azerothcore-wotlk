-- DB update 2025_02_28_00 -> 2025_03_01_00

-- Correct text
DELETE FROM `creature_text` WHERE (`CreatureID` = 25372) AND (`GroupID` IN (0));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25372, 0, 0, 'Enemies spotted! Attack while I try to activate a Protector!', 14, 0, 100, 0, 0, 0, 25202, 0, 'Sunblade Scout');
