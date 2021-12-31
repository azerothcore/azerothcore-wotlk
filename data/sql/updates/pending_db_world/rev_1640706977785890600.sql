INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640706977785890600');

-- Setting probability to 25% for each of the texts. 5*25 = 100%
SET @PROBABILITY = 25;
UPDATE `npc_text` SET `Probability0` = @PROBABILITY, `Probability1` = @PROBABILITY, `Probability2` = @PROBABILITY, `Probability3` = @PROBABILITY, `Probability4` = @PROBABILITY WHERE `ID` IN (778);
