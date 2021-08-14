INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628925002692757285');

-- Remove incorrect quest prerequisite from Gurf's Dignity quest
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 9564; 

