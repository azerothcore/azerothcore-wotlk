-- DB update 2024_07_04_02 -> 2024_07_04_03
--
-- Razuvious
DELETE FROM `creature_text` WHERE `CreatureID` = 16061 AND `GroupID` IN (4, 5);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16061, 4, 0, 'Pathetic...', 12, 0, 100, 5, 0, 0, 27865, 0, 'Razuvious SAY_PATHETIC'),
(16061, 5, 0, 'Start doing something before I replace that target dummy with you and begin a warm up session of my own!', 12, 0, 100, 5, 0, 0, 13136, 0, 'Razuvious SAY_TARGET_DUMMY');

-- Death Knight Understudy
DELETE FROM `creature_text` WHERE `CreatureID` = 16803;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16803, 0, 0, 'Sir, student requests that you beat him for his lack of understanding!', 12, 0, 100, 1, 0, 0, 13140, 0, 'Death Knight Understudy SAY_BEAT_ME'),
(16803, 0, 1, 'I am unworthy, master!', 12, 0, 100, 1, 0, 0, 13138, 0, 'Death Knight Understudy SAY_UNWORTHY'),
(16803, 0, 2, 'Student is worthless, master! Student apologizes for his deficiency!', 12, 0, 100, 1, 0, 0, 13137, 0, 'Death Knight Understudy SAY_WORTHLESS');
