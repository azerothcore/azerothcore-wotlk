--
-- Ony 25man difficulty Tail Sweep
DELETE FROM `spell_cone` WHERE `ID` = 69286;
INSERT INTO `spell_cone` (`ID`, `ConeDegrees`) VALUES (69286, 82);
-- Ony 10man difficulty Tail Sweep
UPDATE `spell_cone` SET `ConeDegrees`=82 WHERE `ID`=68867;
