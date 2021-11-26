INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637899043891697627');

-- Training quest should not be available until after Quest 8325 Reclaiming Sunstrider Isle is complete
UPDATE `quest_template_addon` SET `PrevQuestID`=8325 WHERE `ID` IN (8328,8563,8564,9392,9393,9676);
