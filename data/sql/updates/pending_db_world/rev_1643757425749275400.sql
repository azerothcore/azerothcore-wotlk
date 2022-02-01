INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643757425749275400');
UPDATE `quest_template_addon` SET `PrevQuestID` = 9280 WHERE `id` IN (9288, 9290, 9287, 9291, 9421, 9290); /* Training quests should require complete Replenishing the Healing Crystals */
UPDATE `quest_template` SET `Flags` = 65664 WHERE `id` IN (9288, 9290, 9287, 9291, 9421, 9290); /* Quests should be auto-complete (Quest Complete text only) and have TBC flag set */
UPDATE `quest_template` SET `AllowableRaces` = 1024 WHERE `id` IN (9288, 9290, 9287, 9291, 9421, 9290); /* Draenei training quests should only be available to Draenei */
