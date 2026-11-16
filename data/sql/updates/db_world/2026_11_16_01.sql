-- DB update 2026_11_16_00 -> 2026_11_16_01
--
DELETE FROM `creature_text` WHERE `CreatureID` = 34496 AND `GroupID` = 10;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(34496, 10, 0, 'The sisters go into a Berserker Rage!', 41, 0, 100, 0, 0, 0, 35208, 0, 'Eydis Darkbane - Berserk emote');
