INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636255045851495435');

--Removes deprecated breadcrumb quests as prerequistes for 2 AV quests
UPDATE `quest_template_addon` SET `NextQuestID`= 0 WHERE `ID` IN (7221, 7222);

