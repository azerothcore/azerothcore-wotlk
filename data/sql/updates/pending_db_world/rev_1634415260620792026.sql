INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634415260620792026');

DELETE FROM `broadcast_text` WHERE `ID` IN (7219, 7220, 7221, 7223, 7224, 7225);
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`) VALUES 
(7219, 0, 'Thank you, Tirion. What of your identity?', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(7220, 0, 'I must apologize for not being entirely truthful with you in regards to my identity. I had to be certain that you could be trusted - few people would have selflessly lent assistance to an old and forgotten hermit.$B$BYou have proven yourself as one of those people: A person of integrity and honor.', '', 1, 1, 0, 0, 0, 0, 0, 0, 1, 18019),
(7221, 0, 'I am ready to hear your tale, Tirion.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(7223, 0, 'I will, Tirion.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(7224, 0, 'Indeed. The Scarlet Crusade are an aberration of the Order of the Silver Hand.$B$BYou must believe me, $r; Taelan is a good man. He needs guidance. He needs to remember... remember what it is to be noble and honorable. I know that in his heart, he knows what he does is wrong. Will you help him? Will you help him remember?', '', 1, 1, 6, 0, 0, 0, 0, 0, 1, 18019),
(7225, 0, 'That is terrible.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);

