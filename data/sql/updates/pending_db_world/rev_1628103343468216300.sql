INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628103343468216300');

-- Removed the quest Sartheril's Haven(9395) from the quest chain starting at The Wayward Apprentice [9254]
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 9395);

