INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634540496312439970');

-- Updates the quest completion text for the Art of the Armorsmith (Alliance) to Ironforge
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Grumnus Steelshaper in Ironforge.' WHERE `ID` = 5283;
