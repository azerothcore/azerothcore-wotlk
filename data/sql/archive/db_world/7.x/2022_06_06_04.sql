-- DB update 2022_06_06_03 -> 2022_06_06_04
--
DELETE FROM `creature_text` WHERE `CreatureID` IN (11347, 11348) AND `GroupId` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration` ,`Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11347, 0, 0, '%s dies.', 16, 0, 100, 0, 0, 0, 8251, 3, ''),
(11348, 0, 0, '%s dies.', 16, 0, 100, 0, 0, 0, 8251, 3, '');

DELETE FROM `creature_text` WHERE `CreatureID` = 14509 AND `GroupId` = 2;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration` ,`Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14509, 2, 0, '%s dies.', 16, 0, 100, 0, 0, 0, 8251, 3, '');
