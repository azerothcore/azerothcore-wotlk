INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621271952210432100');

UPDATE `quest_poi` SET `MapID`= 1, `WorldMapAreaId`= 17 WHERE `QuestID`= 7944 AND `id`= 0;

UPDATE `quest_poi_points` SET `X`= -732, `Y`= -2219 WHERE `QuestID`= 7944 AND `Idx1`= 0 AND `Idx2`= 0;
