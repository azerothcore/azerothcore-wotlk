INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555887226948080900');

-- Fix wrong prevQuestId assignment on BE starting zone.
UPDATE `quest_template_addon` SET `PrevQuestId`=8328 WHERE `Id`=10068;
UPDATE `quest_template_addon` SET `PrevQuestId`=9676 WHERE `Id`=10069;
UPDATE `quest_template_addon` SET `PrevQuestId`=9393 WHERE `Id`=10070;
UPDATE `quest_template_addon` SET `PrevQuestId`=8564 WHERE `Id`=10072;
