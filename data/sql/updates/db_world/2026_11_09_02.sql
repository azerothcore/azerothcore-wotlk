-- DB update 2026_11_09_01 -> 2026_11_09_02
-- Chicken: CLUCK! cheer reaction text
DELETE FROM `creature_text` WHERE `CreatureID` = 620;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(620, 0, 0, '%s looks up at you quizzically. Maybe you should inspect it?', 16, 0, 100, 0, 0, 0, 4714, 0, 'Chicken'),
(620, 2, 0, '%s looks at you expectantly.', 16, 0, 100, 0, 0, 0, 5170, 0, 'Chicken');
DELETE FROM `creature_text_locale` WHERE `CreatureID` = 620 AND `GroupID` = 2 AND `ID` = 0;
