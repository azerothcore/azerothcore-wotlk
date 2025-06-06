-- DB update 2023_04_26_03 -> 2023_04_27_00
-- Add Highlord Tirion Fordring - SAY_TIRION_OUTRO_3
DELETE FROM `creature_text` WHERE `CreatureID`=38995 AND `GroupID`=4 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (38995, 4, 0, 'The Lich King must fall!!', 14, 0, 0, 0, 0, 17389, 38113, 0, 'Highlord Tirion Fordring - SAY_TIRION_OUTRO_3');
