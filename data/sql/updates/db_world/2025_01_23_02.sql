-- DB update 2025_01_23_01 -> 2025_01_23_02
--
DELETE FROM `creature_text` WHERE `CreatureID` = 24664 AND `GroupID` = 7;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24664, 7, 0, 'Oh no, he was merely an instrument, a stepping stone to a much larger plan! It has all led to this... and this time you will not interfere!', 14, 0, 100, 25387, 0, 'kaelthas MT SAY_AGGRO_2');
