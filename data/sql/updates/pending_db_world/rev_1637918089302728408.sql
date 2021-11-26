INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637918089302728408');

-- Add quest A Little Luck [6606] as a requisite to get Luck Be With You [969] quest
UPDATE `quest_template_addon` SET `PrevQuestID` = 6606 WHERE (`ID` = 969);

