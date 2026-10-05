-- frFR quest progress and completion texts missing from AzerothCore, taken from TrinityCore TDB 1210.26091.
-- Source: https://github.com/TrinityCore/TrinityCore/releases (TDB_full_1210.26091_2026_09_09). Licence: GPL-2.0.
-- A text is kept only when the source's English matches AzerothCore's English for the same quest,
-- or, for sources without English, when it passes length, placeholder and language checks.

DELETE FROM `quest_request_items_locale` WHERE `locale` = 'frFR' AND `ID` IN (8325);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8325, 'frFR', 'La reconstruction de notre société commence ici, $N. Lorsque nous aurons assuré la sécurité de notre foyer, nous pourrons commencer à regarder vers l''extérieur… et l''ailleurs.', 0);
