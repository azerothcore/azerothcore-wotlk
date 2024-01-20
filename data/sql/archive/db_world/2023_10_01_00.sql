-- DB update 2023_09_29_00 -> 2023_10_01_00
--
DELETE FROM `creature_text` WHERE `CreatureId` = 16524 AND `GroupID` = 10;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16524, 10, 0, '%s begins channelling his mana into a powerful arcane spell.', 16, 0, 100, 13515, 3, 'Shade of Aran EMOTE_ARCANE_EXPLOSION');
