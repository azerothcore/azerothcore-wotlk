INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630263728286533056');

-- insert quest "Return to Krog" after "The Black Shield (1276)" 
UPDATE `quest_template_addon` SET `NextQuestID` = 11204 WHERE (`ID` = 1276);
