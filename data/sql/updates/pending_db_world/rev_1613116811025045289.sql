INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613116811025045289');

-- Fix prequest requirement for Encrypted Scroll

UPDATE `quest_template_addon` SET `PrevQuestID`=364 WHERE `ID`=3096;
