INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609430933457259000');
UPDATE `quest_poi` SET `MapID` = 543, `WorldMapAreaId` = 0 WHERE `QuestID` IN (9572, 9575) AND `id` IN (0, 1, 2);
