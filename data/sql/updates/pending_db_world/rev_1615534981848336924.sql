INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615534981848336924');

-- Remove quest prerequisite
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=46;
