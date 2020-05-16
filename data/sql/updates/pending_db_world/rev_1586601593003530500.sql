INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586601593003530500');

UPDATE `quest_template_addon` SET `PrevQuestID` = 12294, `NextQuestID` = 12225, `ExclusiveGroup` = -12222 WHERE `id` IN (12222, 12223);
UPDATE `quest_template_addon` SET `PrevQuestID` = 12222 WHERE `id` = 12255;
