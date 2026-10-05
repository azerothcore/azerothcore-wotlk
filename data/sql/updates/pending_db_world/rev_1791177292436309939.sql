-- frFR quest progress and completion texts missing from AzerothCore, taken from Wowhead TBC fr quest pages, read by hand.
-- Source: https://www.wowhead.com/tbc/fr/. Licence: Blizzard text.
-- A text is kept only when the source's English matches AzerothCore's English for the same quest,
-- or, for sources without English, when it passes length, placeholder and language checks.

DELETE FROM `quest_request_items_locale` WHERE `locale` = 'frFR' AND `ID` IN (9468);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9468, 'frFR', 'Vous avez l''air un peu roussi sur les bords. Comment s''est passée votre communion avec la flamme, $C ?', 0);
