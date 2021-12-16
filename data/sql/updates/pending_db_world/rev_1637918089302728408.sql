INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637918089302728408');

-- Disabled quest A little luck (6606)
UPDATE `quest_template` SET `QuestType` = 1 WHERE (`ID` = 6606);

