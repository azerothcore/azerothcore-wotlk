-- DB update 2022_05_21_00 -> 2022_05_21_01
-- Ulduar/Mimiron, set Computer model to be female
UPDATE `creature_template` SET `modelid1` = 29101 WHERE `entry` = 34143;

-- Leviathan Mk II
DELETE FROM `creature_text` WHERE `CreatureID` = 33432;
-- Leviathan Mk II - Plasma Blast boss emote
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(33432, 0, 0, '%s begins to cast Plasma Blast!', 41, 0, 100, 0, 0, 15800, 0, 0, 'Leviathan Mk II - EMOTE_PLASMA_BLAST');
