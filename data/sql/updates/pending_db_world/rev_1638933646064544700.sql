INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638933646064544700');

/* Fix incorrect quest tracking status.
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Mound of Dirt in The Eastern Plaguelands' WHERE  `ID`=6024;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Talvash del Kissel at the Mystic Ward in Ironforge.' WHERE  `ID`=2199;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Talvash del Kissel at the Mystic Ward in Ironforge.' WHERE  `ID`=2204;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Talvash del Kissel at the Mystic Ward in Ironforge.' WHERE  `ID`=8355;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Shen\'dralar Ancient in Dire Maul.' WHERE  `ID`=7461;
UPDATE ``quest_poi` SET `ObjectiveIndex`='0' WHERE  `QuestID`=7461 AND `id`=2;
