INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634415260620792026');

DELETE FROM `broadcast_text` WHERE `ID` IN (7219, 7220, 7221, 7223, 7224, 7225);
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`) VALUES 
(7219, 0, 'I am ready to hear your tale, Tirion.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(7221, 0, 'Thank you, Tirion. What of your identity?', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(7223, 0, 'That is terrible.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
(7225, 0, 'I will, Tirion.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),

