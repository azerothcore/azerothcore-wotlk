-- Added missing MaleText
DELETE FROM `broadcast_text` WHERE (`ID` = 12690);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `MaleText`, `FemaleText`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesId`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES
(12690, 0, '%s shimmers and becomes intangible!', '%s shimmers and becomes intangible!', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
