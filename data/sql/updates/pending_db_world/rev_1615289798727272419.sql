INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615289798727272419');

-- Quest Gathering Leather
UPDATE `quest_template_addon` SET `RequiredSkillID`=393, `RequiredSkillPoints`=1 WHERE `ID`=768;
