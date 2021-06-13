INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622673575587160400');

SET @PART1 = 14352;
SET @PART2 = 14353;
UPDATE `quest_template_addon` SET `NextQuestID` = @PART2 WHERE `ID` = @PART1;
UPDATE `quest_template_addon` SET `PrevQuestID` = @PART1 WHERE `ID` = @PART2;
