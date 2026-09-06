-- DB update 2025_11_28_08 -> 2025_11_29_00
-- Add creature_text for Eck the Ferocious "grows increasingly crazed" emote
DELETE FROM `creature_text` WHERE `CreatureID` = 29932 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES (29932, 1, 0, '%s grows increasingly crazed!', 16, 0, 100, 0, 0, 0, 30727, 0, 'Eck the Ferocious - Crazed Warning');
