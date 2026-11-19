-- DB update 2026_11_08_00 -> 2026_11_08_01
--
DELETE FROM `creature_text` WHERE `CreatureID` IN (30449, 30452) AND `GroupID` = 6;
DELETE FROM `creature_text` WHERE `CreatureID` IN (30449, 30451, 30452) AND `GroupID` = 7;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30449, 6, 0, '%s begins to open a Twilight Portal!', 41, 0, 100, 0, 0, 0, 32554, 0, 'Vesperon WHISPER_OPEN_PORTAL'),
(30449, 7, 0, 'A Vesperon Disciple appears in the Twilight!', 41, 0, 100, 0, 0, 0, 32960, 0, 'Vesperon WHISPER_SUMMON_DICIPLE'),
(30451, 7, 0, 'A Shadron Disciple appears in the Twilight!', 41, 0, 100, 0, 0, 0, 32958, 0, 'Shadron WHISPER_SUMMON_DICIPLE'),
(30452, 6, 0, '%s begins to open a Twilight Portal!', 41, 0, 100, 0, 0, 0, 32554, 0, 'Tenebron WHISPER_OPEN_PORTAL'),
(30452, 7, 0, 'Tenebron begins to hatch eggs in the Twilight!', 41, 0, 100, 0, 0, 0, 32959, 0, 'Tenebron WHISPER_HATCH_EGGS');

DELETE FROM `creature_text_locale` WHERE `CreatureID` IN (30449, 30452) AND `GroupID` = 6 AND `ID` = 0;
